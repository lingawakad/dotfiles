function bup
    sudo dnf update -y && fisher update && pipx upgrade-all && cargo install trippy
end
