local function find_files_all()
    local builtin = require("telescope.builtin")
    builtin.find_files({ hidden = true })
end

return {
    "nvim-telescope/telescope.nvim",
    keys = {
        { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
        { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
        { "<leader>sF", find_files_all, desc = "[S]earch All [F]iles" },
    },
}
