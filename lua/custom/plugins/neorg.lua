return {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = require("neorg").setup({
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {}, -- We added this line!
            ["core.journal"] = {
                config = {
                    strategy = function()
                        local date = os.date("*t")
                        return string.format("%04d/%02d/%02d/%02d.norg", date.year, date.month, date.day, date.day)
                    end,
                },
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes  = "~/notes", -- Format: <name_of_workspace> = <path_to_workspace_root>
                        uni = "~/notes/uni",
                        projects = "~/notes/projects",
                    },
                    default_workspace = "notes",
                    index = "index.norg", -- The name of the main (root) .norg file
                }
            }
        }
    }),
}
