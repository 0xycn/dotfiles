require("yac.keymaps")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	"NMAC427/guess-indent.nvim",
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			delay = 0,
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				build = "make",

				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
				theme = "doom",
				config = {
					header = {

						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠐⠁⠀⢀⡠⠀⣤⣶⣖⣾⣿⣿⢠⣾⣿⠿⣿⣿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣷⣝⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠁⢀⣠⣾⠯⢑⣾⣿⢯⣿⣿⣿⣿⡏⠺⣷⣿⣭⣻⢿⣿⣿⣿⣦⣀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣯⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠏⢀⣴⣿⣿⣿⢓⣾⣿⢯⣿⣿⣿⣿⣿⣿⣠⡽⣿⣿⣿⣷⣽⢿⣿⣿⣿⣷⣦⡀⠀⠄⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣷⡌⢿⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠍⣰⣿⣿⣿⣟⢦⣿⣿⡿⣾⣿⣿⣿⣿⣿⣿⣯⢷⣮⢿⣿⣿⣿⣷⣝⢿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⡨⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣓⣾⣿⡿⣷⣿⡟⣾⣿⣿⢷⣿⣿⣿⣿⣿⣿⣿⣿⣯⢿⣷⡻⣿⣿⣿⣿⣿⡻⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣷⣙⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⣾⣿⣿⣽⣿⣿⢻⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣷⡽⣿⣿⣿⣿⣿⡽⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠨⢿⣿⣿⣿⣿⣿⣷⠸⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⠗⣾⣿⣿⣻⣿⣿⡿⣿⣿⣿⡏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡽⣿⣿⣿⣿⣿⡽⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⢏⣿⣿⣿⣿⣿⣿⡖⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⡟⢸⣿⣿⢧⣿⣿⣿⡇⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⠜⣿⣿⣿⣿⣿⣿⣿⣿⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⢸⡼⣿⣿⣿⣿⣿⣇⡹⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⠗⣿⣿⡿⣾⣿⣿⣿⣿⣿⣿⣿⠃⣿⣿⣿⣿⣿⣿⡾⡿⣿⣿⣿⣿⣿⣿⣿⣷⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⢸⣴⢿⣿⣿⣿⣿⣿⠰⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⡟⢸⣿⣿⢷⣿⣿⣿⣿⣿⣿⣏⡏⠀⢹⣿⣿⣿⣿⣿⣿⣻⡽⣿⣯⢿⣿⣿⣿⣿⣷⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⣷⡞⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⡗⣿⣿⡿⣾⣿⣿⣿⣿⡿⣿⣹⠀⠀⠘⣿⣟⣿⣯⣿⣿⣧⢿⣟⣿⣯⠿⣿⣿⣿⣿⣧⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⣿⣷⢻⣿⣿⣿⣿⣧⣹⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⠀⣿⣿⣧⣿⣿⣿⣿⣿⣇⣏⡇⠀⠀⠀⠹⣿⡽⣿⣿⣿⣿⣯⢿⣯⣿⣯⣮⣿⣿⣷⣻⣯⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⣿⣿⡾⣿⣿⣿⣿⣿⢹⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⢵⣿⣿⢿⣿⣿⣿⣿⣿⡯⡌⠁⠀⠀⠀⠀⢳⣳⠹⣿⣿⣿⣿⣯⣿⣷⣽⣷⡿⣝⢿⣿⡽⡞⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⣿⣿⣧⣿⣿⣿⣿⣿⣜⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⢺⣿⣿⢸⣿⢿⣿⣿⣿⡏⠘⠀⠀⠀⠀⠀⠀⠻⣥⡹⣿⣿⣿⣿⣷⡻⣿⣮⣿⣾⢿⣿⣿⣽⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⢹⣿⣿⢹⢹⢫⣻⣿⣿",
						"⣿⣿⣿⣿⣿⣿⠀⣿⣼⡇⡿⢸⣿⣿⣟⣷⠄⠀⠀⠀⠀⠀⠀⠀⠙⣦⢘⢿⣿⣿⣿⣿⣿⢿⣿⣿⣷⣿⢿⡿⡍⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⡇⣹⣿⣿⢸⡏⣿⡌⣾⡈⣨⢿⣿",
						"⣿⣿⣿⣿⣿⣿⡆⡏⣿⣷⠇⡏⣿⣿⣿⣭⢆⠀⠀⠀⠀⠀⠀⡀⠀⠈⠣⠑⠙⣿⣿⣿⣿⣷⣵⣿⣿⣿⡻⣿⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⡛⡇⣿⣿⣿⢸⡇⡏⠁⡟⣹⣾⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣇⡇⣹⣿⡞⡿⣼⣿⣿⡿⣎⢆⠀⠀⠀⠀⠐⠀⠃⠆⠄⠑⠀⠀⢙⢿⣯⣻⣿⣷⣝⢝⡿⣿⣟⢜⢿⣿⣿⣿⣿⣿⣿⣿⢀⡇⣿⣿⣿⢸⣇⡧⣦⠁⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⡇⠁⠐⠉⣿⡇⣱⣻⢿⣷⢈⠃⠳⡄⠀⠀⠀⣀⡄⣖⣾⣿⣷⣮⡩⣟⣫⡻⣿⡳⣯⣗⣝⣾⣜⣽⣏⡟⠻⣿⣿⣿⣿⡟⢦⢷⣿⣿⣿⠳⡿⡇⣿⣰⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⡆⠾⣎⢸⡇⡏⢧⡸⡻⡞⣷⡀⠈⣠⣴⣿⣿⣿⡺⣿⣿⣿⣿⣿⣾⣿⣿⣷⣽⢢⢏⡟⣻⠯⢹⣿⡿⣿⣷⣿⣽⡟⡍⡞⣼⣿⣿⠏⣽⠇⢹⣧⣼⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣦⣙⡖⠹⡃⡞⣷⣽⣎⡪⣳⢺⣿⡿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣽⣾⣵⣫⠜⠿⠿⠿⣇⣿⠟⡰⢍⢶⣿⣟⡟⢰⡟⠨⣾⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡘⡐⠤⠚⣿⣿⣽⣷⣖⡵⣿⣿⣿⣿⣿⡿⢿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡾⠊⣶⣾⣿⣻⢹⢵⠣⢥⢫⣿⡟⢊⠀⡟⣐⣽⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡵⢱⣦⡬⣻⣿⡹⣿⣮⣎⡻⣿⣿⣿⣾⡼⢿⣿⣶⣿⣿⣿⣿⣿⣿⡿⡯⣥⣆⣿⢿⠗⡏⢿⡗⢜⢡⠟⢏⣶⡿⠒⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡘⣛⣝⣂⣙⡷⣮⡙⡿⣌⢺⢟⢿⣿⣿⣿⣿⣿⣾⣿⣿⣿⢟⠯⣾⢽⡿⡼⠫⠫⠸⡤⡜⢣⠈⣑⢘⣼⣷⡯⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡜⢹⣿⡟⣷⣮⣵⠁⠅⡌⠀⣦⡍⠻⢿⣿⡿⠿⠛⢫⡄⢫⣼⣾⠿⢫⡆⢰⡆⠀⣾⣦⠈⠠⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⣿⣿⣿⢻⠋⣁⣠⠋⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣠⣼⠀⠀⢺⣧⣷⣶⣶⣾⣿⣿⣿⣼⣤⣼⡇⠈⠃⢰⣿⣿⣷⣄⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⣿⣿⣿⠟⣛⡬⠊⠁⠀⠈⠻⣷⡧⣍⠟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠈⠉⠉⠉⠛⠛⠛⠛⠉⠉⠉⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⡿⢛⣬⣾⠏⢀⠂⡁⠠⠀⠀⠘⢻⢧⣝⢠⠘⠟⢿⣿⣿⡿⢿⠿⠋⠾⣠⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
						"⣠⣾⡿⠁⡐⠠⠂⠄⠡⢀⠀⠀⠀⠑⠌⠣⠄⠀⠈⣭⣵⣶⣾⠟⠋⠉⠙⠛⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⡛⠛⠟⣿⣿⣿⣿",
						"⣿⢟⡠⠡⠐⠡⠈⠄⠁⠀⠀⠀⠀⠀⠀⠁⠈⠀⡀⠊⠛⠉⠀⠀⢀⠀⠀⠀⠀⠁⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢋⠟⣿⡿⠟⣟⣭⣭⣭⣭⣴⠏⠀⢀⠀⠈⠋⣿⣿",
						"⡿⣢⠇⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢯⠶⣐⠻⣿⣿⣿⣿⣿⠋⠀⡐⠀⡈⠀⠀⠈⢽",
						"⡷⡟⠀⠂⠄⠀⡀⠐⠀⠂⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⠔⢂⠈⣿⡿⠟⠁⢀⠐⠀⠁⠀⠀⠠⠀⠀",
						"⣿⠃⠈⠄⠀⠁⠀⠐⠀⠐⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⢂⠘⣤⣀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀",
						"⡟⠀⢂⠠⠈⠀⠀⠀⠈⠀⢀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠐⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠓⠠⠐⠀⠀⠀⠀⠀⠀⠀",
					},
					center = {
						{
							desc = "🌐Github: 0xycn",
						},
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				--clangd = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},

	{
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				["<tab>"] = { "accept", "fallback" },
				preset = "default",
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },

			fuzzy = { implementation = "lua" },

			signature = { enabled = true },
		},
	},

	{
		"rose-pine/neovim",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					italic = false,
					transparency = true,
				},
			})

			vim.cmd.colorscheme("rose-pine-moon")
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"ej-shafran/compile-mode.nvim",
		version = "^5.0.0",
		-- you can just use the latest version:
		-- branch = "latest",
		-- or the most up-to-date updates:
		-- branch = "nightly",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- if you want to enable coloring of ANSI escape codes in
			-- compilation output, add:
			-- { "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		config = function()
			---@type CompileModeOpts
			vim.g.compile_mode = {
				-- to add ANSI escape code support, add:
				-- baleia_setup = true,

				-- to make `:Compile` replace special characters (e.g. `%`) in
				-- the command (and behave more like `:!`), add:
				-- bang_expansion = true,
			}
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })

			require("mini.surround").setup()

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"hlsl",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
