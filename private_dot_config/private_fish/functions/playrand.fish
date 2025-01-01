function playrand
    if test (count $argv) -eq 0
        set count 6
    else
        set count $argv
    end
    mpc --quiet consume off
    mpc --quiet random off
    mpc --quiet repeat off
    mpc --quiet clear
    for albumname in (beet random -aef '$album' -n$count)
        mpc findadd album $albumname
    end
    mpc --quiet play 1
end
