local M = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
   if not theme then
      theme = require("layers.ui.options").theme
   end

   -- set the global theme, used at various places like theme switcher, highlights
   vim.g.cosmos_theme = theme

   local present, base16 = pcall(require, "base16")

   if present then
      -- first load the base16 theme
      -- base16(base16.themes(theme), true)

      -- unload to force reload
      package.loaded["layers.ui.highlights" or false] = nil
      -- then load the highlights
      require "layers.ui.highlights"
   end
end

-- returns a table of colors for given or current theme
M.get = function(theme)
   if not theme then
      theme = vim.g.cosmos_theme
   end

   return require("hl_themes." .. theme)
end

return M
