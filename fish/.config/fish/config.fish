if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path $HOME/.local/bin/
end

# opam configuration
source /home/jackob/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
