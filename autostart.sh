dropbox start &
ssh-add &
pidgin &
while true; do find ~/Dropbox/Pictures/Wallpapers/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z | xargs -0 feh --bg-max; sleep 60m; done &
setxkbmap -option ctrl:nocaps
