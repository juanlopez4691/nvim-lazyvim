--[[
--- Determine which PHP linters to enable based on project setup.
--- @return table Linter names for PHP files
--]]
local function get_php_linters()
  local fs = require("helpers.filesystem")
  local work_dir = vim.fn.expand("$PWD")
  local vendor_dir = work_dir .. "/vendor"
  local linters = {}

  -- Add phpstan if config file exists
  if
    fs.file_exists(work_dir .. "/phpstan.neon")
    or fs.file_exists(work_dir .. "/phpstan.neon.dist")
    or fs.file_exists(work_dir .. "/phpstan.dist.neon")
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

--[[
--- Safely decode JSON output from phpcs.
--- @param output string Raw phpcs output
--- @return table Decoded table or empty table on failure
--]]
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

--[[
--- Convert decoded phpcs JSON into Neovim diagnostics.
--- @param decoded table Decoded phpcs output
--- @return table List of diagnostic items
--]]
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

    -- Detect local vs global phpcs
    local phpcs_cmd = "./vendor/bin/phpcs"
    if vim.fn.executable(phpcs_cmd) == 0 then
      phpcs_cmd = "phpcs"
    end

    -- Define custom phpcs linter
    lint.linters.phpcs = {
      cmd = "php",
      args = {
        "-d",
        "error_reporting=E_ALL & ~E_DEPRECATED & ~E_USER_DEPRECATED",
        phpcs_cmd,
        "--report=json",
        "-q",
        "--stdin-path=$FILENAME",
      },
      stdin = true,
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output)
        -- 🧹 Clean up stray PHP warnings/deprecations before decoding
        output = output:gsub("^[^\n]*Deprecated:[^\n]*\n", "")
        output = output:gsub("^[^\n]*Warning:[^\n]*\n", "")
        output = output:gsub("^[^\n]*Notice:[^\n]*\n", "")

        local decoded = decode_phpcs_output(output)
        return parse_diagnostics_from_phpcs(decoded)
      end,
    }

    -- Dynamically assign linters for PHP
    opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft or {}, {
      php = get_php_linters(),
    })

    return opts
  end,
}
