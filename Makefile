# https://packages.debian.org/bookworm/sway
# https://code.krister.ee/lock-screen-in-sway/amp/
# https://wiki.debian.org/EnvironmentVariables
# Note: requires build-essential library

.POSIX:
.SUFFIX:
TMPDIR := $(shell mktemp -d -t swayula.XXXXX)

all: required optional extra
required: update sway foot
optional: update mako swayidle-swaylock wayvnc brightnessctl
extra: update firefox
update:
	sudo apt update
sway:
	sudo apt install -y sway
	mkdir -p ~/.config/sway
	cp -f /etc/sway/config ~/.config/sway/
foot:
	sudo apt install -y foot
brightnessctl:
	sudo apt install -y brightnessctl
	grep -q -F "XF86MonBrightnessDown" ~/.config/sway/config || echo "bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-" >> ~/.config/sway/config
	grep -q -F "XF86MonBrightnessUp" ~/.config/sway/config || echo "bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+" >> ~/.config/sway/config
mako:
	sudo apt install -y mako-notifier
	grep -q -F "exec mako" ~/.config/sway/config || echo "exec mako" >> ~/.config/sway/config
swayidle-swaylock:
	sudo apt install -y swayidle swaylock
	echo "exec swayidle -w timeout 600 'swaylock -c 550000' timeout 570 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"' before-sleep 'swaylock -c 550000'" >> ~/.config/sway/config
wayvnc:
	sudo apt install -y wayvnc
wofi:
	sudo apt install -y wofi
mpv:
	sudo apt install -y mpv
firefox:
	sudo apt install -y firefox-esr
	grep -q -F "MOZ_ENABLE_WAYLAND" ~/.profile || echo "export MOZ_ENABLE_WAYLAND=1" >> ~/.profile
