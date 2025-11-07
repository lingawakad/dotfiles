function playrand --description "Plays random albums, ensuring (🤞) no more than repeat for at least 400 plays"

    if test (count $argv) -eq 0
        set count 6
    else
        set count $argv
    end

    printf '\n\n%s %d %s\n\n' "...picking out" "$count" "albums to play..."

    mpc --quiet clear

    set -aU last_played_albums

    set counter 0
    while test $counter -lt $count
        set mbid (mpc list musicbrainz_albumid | shuf -n 1)
        if test (count (string match -a $mbid $last_played_albums)) -lt 3
            mpc findadd musicbrainz_albumid $mbid
            set -a last_played_albums $mbid
            if test (count $last_played_albums) -gt 400
                set -e last_played_albums[1]
            end
            set counter (math $counter + 1)
        else
            continue
        end
    end

    printf %s\n\n ":::enjoy..."
    mpc --quiet consume off
    mpc --quiet random off
    mpc --quiet repeat off
    mpc --quiet play 1
end
