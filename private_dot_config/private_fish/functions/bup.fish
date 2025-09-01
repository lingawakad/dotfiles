function bup
    echo -e "\n\nupdating base system...\n\n"
    sudo dnf update -y
    echo -e "\n\nflattenning paks...\n\n"
    flatpak update
    echo -e "\n\ncasting for fishes...\n\n"
    fisher update
    echo -e "\n\nwrangling pythongs...\n\n"
    pipx upgrade-all
    echo -e "\n\nrustbuckets incoming...\n\n"
    cargo install listenbrainz-mpd -F systemd
    cargo install eza
    cargo install trippy --locked
    echo -e "\n\ngoing the distance...\n\n"
    go install github.com/ycd/dstp/cmd/dstp@latest
    echo -e "\n\nhouse inspection...\n\n"
    chezmoi upgrade
    echo -e "\n\n...done...\n\n"
end
