return {
	-- INFO: This is the colorscheme for solarized osaka
	-- foreground = "#fdf6e3", -- base3
	-- -- background = "#16181a", --
	-- background = "rgba(22, 24, 26, 0.7)", --
	--
	-- cursor_bg = "#fdf6e3", -- base3
	-- cursor_fg = "#002b36", -- base03
	-- cursor_border = "#fdf6e3", -- base3
	--
	-- selection_fg = "#fdf6e3", -- base3
	-- selection_bg = "#586e75", -- base01
	--
	-- scrollbar_thumb = "#002b36", -- base03
	-- split = "#002b36", -- base03
	--
	-- ansi = { "#002b36", "#dc322f", "#859900", "#b58900", "#268bd2", "#d33682", "#2aa198", "#eee8d5" }, -- base03, red, green, yellow, blue, magenta, cyan, base2
	-- brights = { "#073642", "#dc322f", "#859900", "#b58900", "#268bd2", "#d33682", "#2aa198", "#fdf6e3" }, -- base02, red, green, yellow, blue, magenta, cyan, base3
	-- indexed = { [16] = "#cb4b16", [17] = "#dc322f" }, -- orange, red
	--
	-- INFO: This is the colorscheme for kanagawa
	-- foreground = "#dcd7ba",
	-- -- background = "#1f1f28",
	-- background = "rgba(31, 31, 40, 0.75)",
	--
	-- cursor_bg = "#c8c093",
	-- cursor_fg = "#c8c093",
	-- cursor_border = "#c8c093",
	--
	-- selection_fg = "#c8c093",
	-- selection_bg = "#2d4f67",
	--
	-- scrollbar_thumb = "#16161d",
	-- split = "#16161d",
	--
	-- ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	-- brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	-- indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	--
	foreground = "#c8d3f5",
	background = "#222436",
	cursor_bg = "#c8d3f5",
	cursor_border = "#c8d3f5",
	cursor_fg = "#222436",
	selection_bg = "#2d3f76",
	selection_fg = "#c8d3f5",
	split = "#82aaff",
	compose_cursor = "#ff966c",
	scrollbar_thumb = "#2f334d",

	ansi = {
		"#1b1d2b",
		"#ff757f",
		"#c3e88d",
		"#ffc777",
		"#82aaff",
		"#c099ff",
		"#86e1fc",
		"#828bb8",
	},
	brights = {
		"#444a73",
		"#ff8d94",
		"#c7fb6d",
		"#ffd8ab",
		"#9ab8ff",
		"#caabff",
		"#b2ebff",
		"#c8d3f5",
	},

	indexed = {
		[16] = "#ff966c", -- orange
		[17] = "#ff757f", -- alt red
	},

	tab_bar = {
		background = "#222436",
		inactive_tab_edge = "#1e2030",

		active_tab = {
			bg_color = "#82aaff",
			fg_color = "#1e2030",
		},

		inactive_tab = {
			bg_color = "#2f334d",
			fg_color = "#545c7e",
		},

		inactive_tab_hover = {
			bg_color = "#2f334d",
			fg_color = "#82aaff",
			-- intensity = "Bold", -- optional
		},

		new_tab = {
			bg_color = "#222436",
			fg_color = "#82aaff",
		},

		new_tab_hover = {
			bg_color = "#222436",
			fg_color = "#82aaff",
			intensity = "Bold",
		},
	},
}
