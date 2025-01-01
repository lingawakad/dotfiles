function ll --wraps='eza --grid --long --icons=always --all --group-directories-first --git --git-repos' --description 'alias ll eza --grid --long --icons=always --all --group-directories-first --git --git-repos'
    eza --grid --long --icons=always --all --group-directories-first --git --git-repos --classify=always $argv

end
