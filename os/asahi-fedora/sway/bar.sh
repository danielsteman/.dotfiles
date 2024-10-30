while true
do
    # $(cmd) stores the output of cmd
    date=$(date +'%a, %b %d, %Y')
    time=$(date +'%T')
    volume=$(pamixer --get-volume-human)
    brightness=$(brightnessctl g)

    # => Friday, Mar 05 | 03:47 PM
    echo "$date | $time | 🔊 $volume | 💡 $brightness"
    sleep 1
done
