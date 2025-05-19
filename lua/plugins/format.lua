return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			["*"] = { "prettier" },
			-- Prettier will be used for all file types except Lua
		},
		format_on_save = function(bufnr)
			-- Disable autoformat on certain filetypes
			local ignore_filetypes = { "md" }
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return {}
			end
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return {}
			end
			-- Disable autoformat for files in a certain path
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return {}
			end
			-- ...additional logic...
			return { timeout_ms = 500, lsp_fallback = true }
		end,
	},
}
