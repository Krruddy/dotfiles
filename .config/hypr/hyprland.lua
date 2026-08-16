-- ################
-- ### MONITORS ###
-- ################

-- 1. Primary Monitor
hl.monitor({ output = "DP-4", mode = "3840x2160@160", position = "0x0", scale = 1.5 })
-- hl.monitor({ output = "DP-4", disabled = true })

-- 2. Secondary Monitor
-- Position math: 3840 / 1.5 = 2560.
-- So the second monitor should start at 2560x0.
hl.monitor({ output = "DP-5", mode = "1920x1200@60", position = "2560x0", scale = 1 })

-- 3. Fallback for laptop or other displays
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- ###################
-- ### MY PROGRAMS ###
-- ###################

-- See https://wiki.hypr.land/Configuring/Keywords/

-- Set programs that you use
local terminal     = "kitty"
local fileManager  = "dolphin"
-- local menu      = "wofi --insensitive -n --show drun"
local menu         = "/home/ruddy/.config/rofi/launchers/type-3/launcher.sh"
local screenLocker = "hyprlock"
local browser      = "zen-browser"

-- #################
-- ### AUTOSTART ###
-- #################

-- exec-once has no direct keyword; subscribe to the session start event.
-- hyprland.start fires once at startup (config reloads fire a separate event).
hl.on("hyprland.start", function()
  hl.dispatch(hl.dsp.exec_cmd(terminal .. " --class scratchpad"))
  hl.dispatch(hl.dsp.exec_cmd("waybar"))
  hl.dispatch(hl.dsp.exec_cmd("systemctl --user start hyprpolkitagent"))
  hl.dispatch(hl.dsp.exec_cmd("hyprpaper --config ~/.config/hypr/hyprpaper.conf"))
  hl.dispatch(hl.dsp.exec_cmd("swaync"))
  hl.dispatch(hl.dsp.exec_cmd("blueman-applet"))
  hl.dispatch(hl.dsp.exec_cmd(browser, { workspace = 1 }))
  hl.dispatch(hl.dsp.exec_cmd("kdeconnectd"))
  hl.dispatch(hl.dsp.exec_cmd("kdeconnect-indicator"))
end)

-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

-- See https://wiki.hypr.land/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GDK_SCALE", "1.5")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- #####################
-- ### LOOK AND FEEL ###
-- #####################

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
-- hl.config({ ... }) is a function call. Multiple invocations are allowed;
-- each one updates only what you pass in.

-- general
hl.config({
  general = {
    border_size = 2,

    gaps_in = 5,
    -- gaps_out = { 5, 5, 5, 5 },
    gaps_out = 2,
    float_gaps = 0,

    -- https://wiki.hypr.land/Configuring/Basics/Variables/ for info about colors
    -- Gradients are a table: { colors = { "c1", "c2" }, angle = N }.
    -- A single solid color stays a plain string.
    col = {
      active_border   = { colors = { "rgb(000000)", "rgb(ffffff)" }, angle = 45 },
      -- active_border   = { colors = { "rgba(00000000)", "rgba(ffffffff)" }, angle = 45 },
      --                   { colors = { "rgba(...)", "rgba(...)" }, angle? = 45 }
      -- active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(00000000)",
      -- inactive_border = "rgba(595959aa)",
    },
  },
})

-- decoration
hl.config({
  decoration = {
    rounding = 5,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },

    blur = {
      enabled = true,
      size = 3,
      vibrancy = 1,
    },
  },
})

-- animations
hl.config({
  animations = {
    enabled = true, -- yes, please :)
  },
})

-- Default animations, see https://wiki.hypr.land/Configuring/Animations/ for more
-- Curves are defined with hl.curve(name, { type = "bezier", points = { {x1,y1}, {x2,y2} } })
hl.curve("easeOutQuint",    { type = "bezier", points = { {0.23, 1},   {0.32, 1}     } })
hl.curve("easeInOutCubic",  { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("easeInExpo",      { type = "bezier", points = { {0.95, 0.05}, {0.795, 0.035} } })
hl.curve("linear",          { type = "bezier", points = { {0, 0},      {1, 1}        } })
hl.curve("almostLinear",    { type = "bezier", points = { {0.5, 0.5},  {0.75, 1.0}   } })
hl.curve("quick",           { type = "bezier", points = { {0.15, 0},   {0.1, 1}      } })
hl.curve("overshot",        { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1}    } })

-- Leaves are configured with hl.animation({ leaf, enabled, speed, bezier / style })
hl.animation({ leaf = "global",         enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",         enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",        enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",         enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",        enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",           enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",         enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",       enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",     enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 1.8,  bezier = "quick",        style = "slide" })
hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 1.94, bezier = "overshot",     style = "fade" })

-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- misc
hl.config({
  misc = {
    force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
  },
})

-- #############
-- ### INPUT ###
-- #############

hl.config({
  input = {
    kb_layout = "us",
    -- kb_layout = "fr",
    follow_mouse = 1,

    touchpad = {
      natural_scroll = true,
    },
  },
})

-- gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- 4k monitor blur fix
hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})

-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal .. " --class scratchpad"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- This is the old one and the not recommended way of doing it as opposed to the one below
-- hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
-- This is deprecated and now uses the new thingy.
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
-- hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(screenLocker))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("~/.config/hypr/Scripts/toggle_res.sh"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind("ALT + TAB", hl.dsp.focus({ last = true }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Switch workspaces 1 and 2 (swap active workspaces between monitors 0 and 1)
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.workspace.swap_monitors({ monitor1 = "0", monitor2 = "1" }))

-- Special workspaces
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Terminal Scratchpad (Already exists, adding move bind)
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("term"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:term" }))
-- Terminal default workspace
hl.window_rule({ match = { class = "^(scratchpad)$" }, workspace = "special:term" })

-- Notes Scratchpad (Obsidian) -> Key: O
hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special("notes"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:notes" }))
-- Obsidian default workspace
hl.window_rule({ match = { class = "^(obsidian)$" }, workspace = "special:notes" })

-- Comm Scratchpad (Messages) -> Key: M
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("comm"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:comm" }))
-- Communication apps default workspace
hl.window_rule({ match = { class = "^(discord|vesktop|Signal|thunderbird)$" }, workspace = "special:comm" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { drag = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { drag = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                           { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                           { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- SCREENSHOT STACK (Key: P)

-- 1. Region (Most common) -> Super + Shift + P
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S.png') | wl-copy"))

-- 2. Annotate/Edit (For Obsidian) -> Super + Alt + P
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -"))

-- 3. Whole Screen -> Super + Ctrl + P
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("grim - | tee ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H%M%S.png') | wl-copy"))

-- Fix for JetBrains IDEs (IntelliJ, PyCharm, etc.) focus issues
-- JetBrains IDEs prevents focus on floating windows (code completion, popups, etc.)
hl.window_rule({
  match = { class = "^jetbrains-(.*)", float = true },
  no_initial_focus = true,
})

-- JetBrains IDEs no focus for floating windows with titles like win1, win2, etc.
-- This is specifically for invisible windows that cause flickering when hovering
-- over the taskbar on the right.
hl.window_rule({
  match = { class = "^jetbrains-(.*)", title = "^win\\d+$", float = true },
  no_focus = true,
})
