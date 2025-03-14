-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local opacity = 0.65
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

-- Set the shell to powershell
config.default_prog = { "pwsh", "-NoLogo" }

-- Color Configuration
config.colors = require("cyberdream")
config.color_scheme = "Solarized (dark) (terminal.sexy)"
config.force_reverse_video_cursor = true

-- Window Configuration
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
	background = transparent_bg,
	new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
	new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
}

-- Tab Formatting
wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = config.colors.brights[1]
	local foreground = config.colors.foreground

	if tab.is_active then
		background = config.colors.brights[7]
		foreground = config.colors.background
	elseif hover then
		background = config.colors.brights[8]
		foreground = config.colors.background
	end

	local title = tostring(tab.tab_index + 1)
	return {
		{ Foreground = { Color = background } },
		{ Text = "█" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Text = "█" },
	}
end)

-- These functions perform the tab switch in wezterm
wezterm.on("switch-to-left", function(window, pane)
	local tab = window:mux_window():active_tab()

	if tab:get_pane_direction("Left") ~= nil then
		window:perform_action(wezterm.action.ActivatePaneDirection("Left"), pane)
	else
		window:perform_action(wezterm.action.ActivateTabRelative(-1), pane)
	end
end)

wezterm.on("switch-to-right", function(window, pane)
	local tab = window:mux_window():active_tab()

	if tab:get_pane_direction("Right") ~= nil then
		window:perform_action(wezterm.action.ActivatePaneDirection("Right"), pane)
	else
		window:perform_action(wezterm.action.ActivateTabRelative(1), pane)
	end
end)

-- Custom keymaps
config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action.EmitEvent("switch-to-left"),
	},
	-- {
	-- 	key = "j",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.ActivatePaneDirection("Down"),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.ActivatePaneDirection("Up"),
	-- },
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action.EmitEvent("switch-to-right"),
	},
}

config.window_frame = {
	font = wezterm.font({ family = "CaskaydiaCove Nerd Font", weight = "Bold" }),

	font_size = 13.0,
}

config.font = wezterm.font("CaskaydiaCove Nerd Font")

config.font_size = 12

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.9

-- For example, changing the color scheme:
-- config.color_scheme = "Gruvbox dark, soft (base16)"
-- config.color_scheme = "Sonokai (Gogh)"

-- Set the background image for wezterm
config.window_background_image = "./images/gundam_by_slimshadywallpaper_dhg108t-fullview.jpg"

config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 1.3,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}

-- and finally, return the configuration to wezterm
return config
