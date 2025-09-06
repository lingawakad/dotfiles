function playrand --description "Plays random albums, ensuring no repeat for at least 450 plays"
    # obviously, you'll need mpd, mpc and beets (with the random plugin) at a minimum

    # set the desired album count
    if test (count $argv) -eq 0
        set count 6
    else
        set count $argv
    end

    printf '\n\n%s %d %s\n\n' "...picking out" "$count" "new albums to play..."

    # clear the previous mpd playlist
    mpc --quiet clear

    # Initialize an array to store the last 450 played albums if it doesn't exist
    if not set -q last_played_albums
        set -U last_played_albums
    end

    # Function to check if an album is already played
    function is_album_played
        for albumname in $last_played_albums
            set playhistory (echo $last_played_albums | grep $argv | count)
            if test (count $playhistory) -gt 3
                return 0 # Album found, do not play it
            end
        end
        return 1 # Album not found, safe to play
    end

    set counter 0
    while test $counter -lt $count
        set albumfull (beet random -ae)
        echo $albumfull | cut -d- -f2 | string trim | read albumname
        if is_album_played (string replace -ra ' ' '' "$albumname")
            continue
        else
            mpc findadd album $albumname
            set -a last_played_albums (string replace -ra ' ' '' "$albumname")
            if test (count $last_played_albums) -gt 450
                set -e last_played_albums[1]
            end
            set counter (math $counter + 1)
            printf '%s\n\n' $albumfull
        end
    end

    printf %s\n\n "...now playing:::" ":::enjoy..."
    mpc --quiet consume off
    mpc --quiet random off
    mpc --quiet repeat off
    mpc --quiet play 1
end
