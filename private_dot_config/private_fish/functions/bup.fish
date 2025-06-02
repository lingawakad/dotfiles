function bup
    sudo dnf update -y \
        && flatpak update \
        && fisher update \
        && pipx upgrade-all \
        && cargo install listenbrainz-mpd -F systemd \
        && cargo install eza \
        && cargo install trippy --locked \
        && cargo install --git https://github.com/ShenMian/tracker \
        && go install github.com/ycd/dstp/cmd/dstp@latest \
        && chezmoi upgrade
end
