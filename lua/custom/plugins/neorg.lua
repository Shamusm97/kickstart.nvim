return {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {}, -- We added this line!
    }
})
}
