if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_key_bindings fish_vi_key_bindings

export PATH="$PATH:$HOME/.local/bin"

# Session entry point. gamescope-session-switcher starts the desktop session
# (uwsm start default) and keeps running, owning the desktop <-> gamescope
# transition; drive it with `gamescope-session-switcher gamescope|desktop|status`.
if uwsm check may-start &> /dev/null
    if command -q gamescope
        exec gamescope-session-switcher
    else
        exec uwsm start default
    end
end
