-- render-markdown needs the markdown parsers for its highlighting
local ok, ts = pcall(require, "nvim-treesitter")
if ok then
    ts.install { "markdown", "markdown_inline" }
end
