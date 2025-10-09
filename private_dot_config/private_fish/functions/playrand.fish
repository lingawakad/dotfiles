function playrand --description "Plays random albums, ensuring no repeat for at least 350 plays"
    # obviously, you'll need mpd, mpc and possibly libmpdclient. i would recommend beets for library management which provides the musicbrainz id, or picard autotagger

    # set the desired album count
    if test (count $argv) -eq 0
        set count 6
    else
        set count $argv
    end

    printf '\n\n%s %d %s\n\n' "...picking out" "$count" "new albums to play..."

    # clear the previous mpd playlist
    mpc --quiet clear

    # Initialize an array to store the last 350 played albums if it doesn't exist
    if not set -q last_played_albums
        set -U last_played_albums
    end

    # Function to check if an album is already played
    function is_album_played
        for mbid in $last_played_albums
            set playhistory (echo $last_played_albums | grep -o $mbid | count)
            if test (count $playhistory) -gt 3
                return 0 # Album found, do not play it
            end
        end
        return 1 # Album not found, safe to play
    end

    set counter 0
    while test $counter -lt $count
        set mbid (mpc list musicbrainz_albumid | shuf -n 1)
        if is_album_played $mbid
            continue
        else
            mpc findadd musicbrainz_albumid $mbid
            set -a last_played_albums $mbid
            if test (count $last_played_albums) -gt 350
                set -e last_played_albums[1]
            end
            set counter (math $counter + 1)
        end
    end

    printf %s\n\n ":::enjoy..."
    mpc --quiet consume off
    mpc --quiet random off
    mpc --quiet repeat off
    mpc --quiet play 1
end
