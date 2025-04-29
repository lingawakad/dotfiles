function bup
    sudo dnf update -y \
        && fisher update \
        && pipx upgrade-all \
        && cargo install listenbrainz-mpd -F systemd \
        && cargo install eza \
        && go install github.com/ycd/dstp/cmd/dstp@latest \
        && chezmoi upgrade
end
