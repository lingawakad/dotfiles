if status is-interactive

end

set fish_greeting

set -Ux EDITOR hx
set -Ux VISUAL hx

fzf --fish | source

set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

set fzf_preview_dir_cmd eza --grid --long --icons=always --all --group-directories-first --git --git-repos

set fzf_diff_highlighter delta --paging=never --width=20

set PATH $PATH ~/.local/bin ~/.cargo/bin
