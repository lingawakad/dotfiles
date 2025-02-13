function playrand --description "Plays random albums, ensuring no repeat for at least 100 plays"
    # obviously, you'll need mpd, mpc and beets (with the random plugin) at a minimum

    # set the desired album count
    if test (count $argv) -eq 0
        set count 6
    else
        set count $argv
    end

    # clear the previous mpd playlist
    mpc --quiet clear

    # Initialize an array to store the last 100 played albums if it doesn't exist
    if not set -q last_played_albums
        set -U last_played_albums
    end

    # Function to check if an album is already played
    function is_album_played
        for albumname in $last_played_albums
            if test $argv = $albumname
                return 0 # Album found, do not play it
            end
        end
        return 1 # Album not found, safe to play
    end

    for albumname in (beet random -aef '$album' -n$count)
        if is_album_played (string replace -ra ' ' '' "$albumname")
            continue
        else
            mpc findadd album $albumname
            set -a last_played_albums (string replace -ra ' ' '' "$albumname")
            if test (count $last_played_albums) -gt 100
                set -e last_played_albums[1]
            end
        end
    end

    mpc --quiet consume off
    mpc --quiet random off
    mpc --quiet repeat off
    mpc --quiet play 1
end
