if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_key_bindings fish_vi_key_bindings

export PATH="$PATH:$HOME/.local/bin"

function choose_session
    clear
    echo "choose option:"
    echo "1) uwsm"
    echo "2) gamescope"
    
    read -P "" choice
    
    switch $choice
        case "1"
            exec uwsm start default
        case "2"
            clear
            exec gamescope-session
        case '*'
            choose_session
    end
end

if uwsm check may-start &> /dev/null; then
  choose_session
fi

end
