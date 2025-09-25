-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local opacity = 0.75
-- local transparent_bg = "rgba(22, 24, 26, .65)" --this is for transparent background (any theme)
local transparent_bg = "rgba(34, 36, 54, 0.85)" -- This is for tokyo night theme
local windowPadding = {
	top = 10,
	bottom = 0,
	left = 10,
	right = 10,
}

-- Set the shell to powershell
config.default_prog = { "pwsh", "-NoLogo" }

-- Color Configuration
config.colors = require("cyberdream")
-- INFO: colorscheme for solorized osaka
-- config.color_scheme = "Solarized (dark) (terminal.sexy)"
-- config.color_scheme = "Kanagawa (Gogh)"
config.color_scheme = "Tokyo Night Storm"
config.force_reverse_video_cursor = true

-- Window Configuration
config.initial_rows = 45
config.initial_cols = 180
config.window_padding = windowPadding
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
-- config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
	background = transparent_bg,
	new_tab = { fg_color = config.colors.foreground, bg_color = config.colors.brights[1] },
	new_tab_hover = { fg_color = config.colors.brights[1], bg_color = config.colors.brights[8] },
}

wezterm.on("user-var-changed", function(window, pane, name, value)
	window:toast_notification("wezterm", "SetUserVar called: " .. name .. "=" .. value, nil, 4000)
end)

-- -- Zen mode neovim configuration
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		window:toast_notification("wezterm", "zen mode called" .. value)
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	window:toast_notification("wezterm", "variable change")
end)

-- wezterm.on("user-var-changed", function(window, pane, name, value)
-- 	local overrides = window:get_config_overrides() or {}
-- 	-- window:toast_notification("wezterm", "user var changed!" .. name, nil, 4000)
-- 	window:toast_notification("wezterm", "variable changed!" .. name, nil, 4000)
-- 	if name == "ZEN_MODE" then
-- 		local incremental = value:find("+")
-- 		local number_value = tonumber(value)
-- 		if incremental ~= nil then
-- 			while number_value > 0 do
-- 				window:perform_action(wezterm.action.IncreaseFontSize, pane)
-- 				number_value = number_value - 1
-- 			end
-- 			overrides.enable_tab_bar = false
-- 		elseif number_value < 0 then
-- 			window:perform_action(wezterm.action.ResetFontSize, pane)
-- 			overrides.font_size = nil
-- 			overrides.enable_tab_bar = true
-- 		else
-- 			overrides.font_size = number_value
-- 			overrides.enable_tab_bar = false
-- 		end
-- 	end
-- 	window:set_config_overrides(overrides)
-- end)

-- Tab Formatting
--
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

--This function checks to see if there is a different screen active and changed the
--padding accordingly
wezterm.on("update-status", function(window, _)
	local tab = window:active_tab()
	local panes = tab:panes()
	local alt_screen_active = false

	for i = 1, #panes, 1 do
		local pane = panes[i]
		if pane:is_alt_screen_active() then
			alt_screen_active = true
			break
		end
	end

	if alt_screen_active then
		window:set_config_overrides({
			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
			use_resize_increments = false,
		})
	else
		window:set_config_overrides({
			window_padding = windowPadding,
		})
	end
end)

config.window_frame = {
	-- font = wezterm.font({ family = "SauceCodePro Nerd Font Mono", weight = "Bold" }),
	font = wezterm.font({ family = "IosevkaTerm Nerd Font Mono", weight = "Bold" }),

	font_size = 16.0,
}

-- config.font = wezterm.font("CaskaydiaCove Nerd Font")
-- config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")
config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
-- config.font = wezterm.font("UbuntuSansMono Nerd Font Mono")
-- config.font = wezterm.font("SauceCodePro Nerd Font Mono")

config.font_size = 18

-- config.window_decorations = "RESIZE"
--
-- config.window_background_opacity = 0.9

-- For example, changing the color scheme:
-- config.color_scheme = "Gruvbox dark, soft (base16)"
-- config.color_scheme = "Sonokai (Gogh)"

-- Set the background image for wezterm
-- config.window_background_image = "./images/gundam_by_slimshadywallpaper_dhg108t-fullview.jpg"

-- config.window_background_image_hsb = {
-- 	-- Darken the background image by reducing it to 1/3rd
-- 	brightness = 1.3,
--
-- 	-- You can adjust the hue by scaling its value.
-- 	-- a multiplier of 1.0 leaves the value unchanged.
-- 	hue = 1.0,
--
-- 	-- You can adjust the saturation also.
-- 	saturation = 1.0,
-- }

-- and finally, return the configuration to wezterm
--
config.front_end = "OpenGL"
return config
