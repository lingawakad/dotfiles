function bup
    sudo dnf update -y \
        && fisher update \
        && pipx upgrade-all \
        && cargo install trippy --locked \
        && cargo install listenbrainz-mpd -F systemd \
        && go install github.com/ycd/dstp/cmd/dstp@latest
end
