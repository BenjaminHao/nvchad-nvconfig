local Util = require("nvconfig.utils")

local M = {}

local defaults = { -- default nvconfig module from Nvchad
  ui = {
    ------------------------------- base46 -------------------------------------
    -- hl = highlights
    hl_add = {},
    hl_override = {},
    changed_themes = {},
    theme_toggle = { "onedark", "one_light" },
    theme = "onedark", -- default theme
    transparency = false,
    cmp = {
      icons = true,
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    },
    telescope = { style = "borderless" }, -- borderless / bordered
    ------------------------------- nvchad_ui modules -----------------------------
    statusline = {
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = nil,
      modules = nil,
    },
    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
    },
    nvdash = {
      load_on_startup = false,
      header = {
        "           ▄ ▄                   ",
        "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
        "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
        "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
        "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
        "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
        "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
        "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
        "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
      },
      buttons = {
        { "  Find File", "Spc f f", "Telescope find_files" },
        { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
        { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
        { "  Bookmarks", "Spc m a", "Telescope marks" },
        { "  Themes", "Spc t h", "Telescope themes" },
        { "  Mappings", "Spc c h", "NvCheatsheet" },
      },
    },
    cheatsheet = { theme = "grid" }, -- simple/grid
    lsp = { signature = true },
    term = {
      hl = "Normal:term,WinSeparator:WinSeparator",
      sizes = { sp = 0.3, vsp = 0.2 },
      float = {
        relative = "editor",
        row = 0.3,
        col = 0.25,
        width = 0.5,
        height = 0.4,
        border = "single",
      },
    },
  },
  base46 = {
    integrations = {
      "blankline",
      "cmp",
      "defaults",
      "devicons",
      "git",
      "lsp",
      "mason",
      "nvcheatsheet",
      "nvdash",
      "nvimtree",
      "statusline",
      "syntax",
      "treesitter",
      "tbline",
      "telescope",
      "whichkey",
    },
  },
}

M.options = {}
M.path = ""

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", defaults, opts or {})
  M.path = debug.getinfo(2, "S").source:sub(2)

  local success, base46 = pcall(require, "base46")
  if not success then
    vim.notify("Error Loading base46.", vim.log.levels.ERROR)
  end

  vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
  base46.load_all_highlights()
end

return M
