# https://packages.debian.org/bookworm/sway

.POSIX:
.SUFFIX:
TMPDIR := $(shell mktemp -d -t swayula.XXXXX)

all: core dev extra
core: update sway foot swaylock swayidle wofi
dev: update screen git
extra: update firefox wayvnc
update:
	apt update
screen:
	apt install -y screen
git:
	apt install -y git
sway:
	apt install -y sway
foot:
	apt install -y foot
swaylock:
	apt install -y swaylock
swayidle:
	apt install -y swayidle
wayvnc:
	apt install -y wayvnc
wofi:
	apt install -y wofi	
firefox:
	apt install -y firefox-esr
	export MOZ_ENABLE_WAYLAND=1
