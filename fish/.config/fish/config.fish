
if status is-interactive

    function projects_fun
        set project (ls $HOME/projects/ | fzf );
        cd $HOME/projects/$project 

        set is_session_present = (zellij list-sessions | grep $project | wc -l) -gt 0

        if [ is_session_present ] 
            zellij attach $project
        else 
            zellij -s $project
        end 
    end

    # Commands to run in interactive sessions can go here
    fish_add_path $HOME/.local/bin/
    fish_add_path $HOME/go/bin/
    fish_add_path $HOME/jetbrains/intellij/bin/
    fish_add_path $HOME/.local/share/coursier/bin/
    fish_add_path $HOME/.cargo/bin/
    set GOBIN $HOME/go/bin

    alias books='set book (ls $HOME/Documents/books | fzf); zathura $HOME/Documents/books/$book & disown && exit'
    alias projects=projects_fun
    alias ajava=archlinux-java
end


# opam configuration
source /home/jackob/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
