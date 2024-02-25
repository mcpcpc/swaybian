# https://packages.debian.org/bookworm/sway
# Note: requires build-essential library

.POSIX:
.SUFFIX:
TMPDIR := $(shell mktemp -d -t swayula.XXXXX)

all: core dev extra
core: update sway foot swaylock swayidle wayvnc wofi
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
swaylock:
	sudo apt install -y swaylock
swayidle:
	sudo apt install -y swayidle
wayvnc:
	sudo apt install -y wayvnc	
wofi:
	sudo apt install -y wofi	
firefox:
	sudo apt install -y firefox-esr
	grep -q -F "MOZ_ENABLE_WAYLAND" ~/.profile || echo "export MOZ_ENABLE_WAYLAND=1" >> ~/.profile
