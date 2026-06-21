local fs = require("helpers.filesystem")

--- Resolve the phpcs binary to an absolute path.
--- Prefers the project-local binary, then the Mason-managed one, then PATH.
--- An absolute path is required so the linter works regardless of nvim's cwd.
--- @param buf integer Buffer handle
--- @return string Absolute path to phpcs, or "phpcs" as a PATH fallback
local function resolve_phpcs(buf)
  local root = vim.fs.root(buf, { "composer.json", ".git" })
  if root then
    local local_bin = root .. "/vendor/bin/phpcs"
    if fs.file_exists(local_bin) then
      return local_bin
    end
  end

  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/phpcs"
  if fs.file_exists(mason_bin) then
    return mason_bin
  end

  return "phpcs"
end

--- Determine which PHP linters to enable based on project setup.
--- @param buf integer Buffer handle
--- @return table Linter names for PHP files
local function get_php_linters(buf)
  local root = vim.fs.root(buf, { "composer.json", ".git" }) or vim.fn.expand("%:p:h")
  local vendor_dir = root .. "/vendor"
  local linters = {}

  -- Add phpstan if config file exists
  if
    fs.file_exists(root .. "/phpstan.neon")
    or fs.file_exists(root .. "/phpstan.neon.dist")
    or fs.file_exists(root .. "/phpstan.dist.neon")
  then
    table.insert(linters, "phpstan")
  end

  -- Skip phpcs if Laravel Pint is present
  if fs.file_exists(vendor_dir .. "/bin/pint") then
    return linters
  end

  -- Add phpcs
  table.insert(linters, "phpcs")

  return linters
end

--- Safely decode JSON output from phpcs.
--- @param output string Raw phpcs output
--- @return table Decoded table or empty table on failure
local function decode_phpcs_output(output)
  local ok, decoded = pcall(vim.json.decode, output)
  if not ok or type(decoded) ~= "table" then
    vim.schedule(function()
      vim.notify_once("phpcs parser: failed to decode JSON", vim.log.levels.WARN)
    end)

    return {}
  end

  return decoded
end

--- Convert decoded phpcs JSON into Neovim diagnostics.
--- @param decoded table Decoded phpcs output
--- @return table List of diagnostic items
local function parse_diagnostics_from_phpcs(decoded)
  local diagnostics = {}
  if not decoded.files then
    return diagnostics
  end

  for _, file in pairs(decoded.files) do
    for _, message in ipairs(file.messages or {}) do
      table.insert(diagnostics, {
        lnum = (message.line or 1) - 1,
        col = (message.column or 1) - 1,
        end_lnum = (message.endLine or message.line or 1) - 1,
        end_col = (message.endColumn or message.column or 1) - 1,
        message = message.message or "",
        code = message.source,
        severity = message.type == "ERROR" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
        source = "phpcs",
      })
    end
  end

  return diagnostics
end

-- Return plugin specification for LazyVim
return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  opts = function(_, opts)
    local lint = require("lint")

    -- Define custom phpcs linter. Wrapped in a function so cmd and cwd are
    -- resolved per lint invocation (nvim-lint reads `cwd` literally, not as a
    -- function).
    lint.linters.phpcs = function()
      return {
        cmd = resolve_phpcs(0),
        -- Run from the project root so phpcs discovers the project ruleset
        -- (phpcs.xml/.dist); phpcs locates rulesets by walking up from cwd,
        -- not from --stdin-path.
        cwd = vim.fs.root(0, { "composer.json", ".git" }) or vim.fn.getcwd(),
        args = {
          "--report=json",
          "-q",
          "--stdin-path=" .. vim.api.nvim_buf_get_name(0),
          "-",
        },
        stdin = true,
        stream = "stdout",
        ignore_exitcode = true,
        parser = function(output)
          -- phpcs may emit PHP deprecation/warning lines before the JSON payload;
          -- discard anything ahead of the first opening brace before decoding.
          local brace = output:find("{", 1, true)
          if brace then
            output = output:sub(brace)
          end

          local decoded = decode_phpcs_output(output)
          return parse_diagnostics_from_phpcs(decoded)
        end,
      }
    end

    -- Dynamically assign linters for PHP per buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "php",
      callback = function(args)
        lint.linters_by_ft.php = get_php_linters(args.buf)
      end,
    })

    return opts
  end,
}
