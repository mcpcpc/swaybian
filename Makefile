# https://packages.debian.org/bookworm/sway
# https://code.krister.ee/lock-screen-in-sway/amp/
# https://wiki.debian.org/EnvironmentVariables
# Note: requires build-essential library

.POSIX:
.SUFFIX:
TMPDIR := $(shell mktemp -d -t swayula.XXXXX)

all: core dev extra
core: update sway foot swaylock swayidle wayvnc wofi mako
dev: update screen git
extra: update firefox
update:
	sudo apt update
screen:
	sudo apt install -y screen
git:
	sudo apt install -y git
sway:
	sudo apt install -y sway
	mkdir -p ~/.config/sway
	cp -f /etc/sway/config ~/.config/sway/
foot:
	sudo apt install -y foot
mako:
	sudo apt install -y mako-notifier
	grep -q -F "exec mako" ~/.config/sway/config || echo "exec mako" >> ~/.config/sway/config
swaylock:
	sudo apt install -y swaylock
swayidle:
	sudo apt install -y swayidle
	grep -q -F "set $lock" ~/.config/sway/config || echo "set $lock swaylock -c 550000" >> ~/.config/sway/config
	grep -q -F "exec swayidle" ~/.config/sway/config || echo "exec swayidle -w timeout 600 $lock timeout 570 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"' before-sleep $lock" >> ~/.config/sway/config
wayvnc:
	sudo apt install -y wayvnc
	mkdir -p ~/.config/wayvnc
	ssh-keygen -m pem -f ~/.config/wayvnc/rsa_key.pem -t rsa -N ""
	echo "rsa_private_key_file=$(HOME)/.config/wayvnc/rsa_key.pem" > ~/.config/wayvnc/config
	
wofi:
	sudo apt install -y wofi	
firefox:
	sudo apt install -y firefox-esr
	grep -q -F "MOZ_ENABLE_WAYLAND" ~/.profile || echo "export MOZ_ENABLE_WAYLAND=1" >> ~/.profile
