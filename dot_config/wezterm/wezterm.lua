local wezterm = require "wezterm";

return {
    color_scheme = "Builtin Solarized Light",
    font = wezterm.font("FiraCode Nerd Font"),
    font_size = 14,

    leader = { key="a", mods="ALT", timeout_milliseconds=1001 },
    keys = {
        {key="\\", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {key="-", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        {key="t", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
        {key="x", mods="LEADER", action=wezterm.action{CloseCurrentPane={confirm=false}}},
        {key="h", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
        {key="j", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
        {key="k", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
        {key="l", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},


        {key="1", mods="LEADER", action=wezterm.action{ActivateTab=0}},
        {key="2", mods="LEADER", action=wezterm.action{ActivateTab=1}},
        {key="3", mods="LEADER", action=wezterm.action{ActivateTab=2}},
        {key="4", mods="LEADER", action=wezterm.action{ActivateTab=3}},
        {key="5", mods="LEADER", action=wezterm.action{ActivateTab=4}},
        {key="6", mods="LEADER", action=wezterm.action{ActivateTab=5}},
        {key="7", mods="LEADER", action=wezterm.action{ActivateTab=6}},
        {key="8", mods="LEADER", action=wezterm.action{ActivateTab=7}},
        {key="9", mods="LEADER", action=wezterm.action{ActivateTab=8}},
    },
}
