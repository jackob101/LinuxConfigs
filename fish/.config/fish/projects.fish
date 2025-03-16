#!/bin/fish

set project (ls $HOME/projects/ | fzf );
cd $HOME/projects/$project 

set is_session_present = (zellij list-sessions | grep $project | wc -l) -gt 0

if [ is_session_present ] 
    zellij attach $project
else 
    zellij -s $project
end 

