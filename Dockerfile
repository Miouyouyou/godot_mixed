FROM ubuntu AS builder

RUN apt-get -y install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm git

RUN cd /tmp && git clone https://github.com/V-Sekai/groups_merge_script

RUN cd /tmp/groups_merge_script && ./godot_v_sekai_update.sh

RUN cd /tmp/groups_merge_script && scons platform=x11 use_lto=yes target=release_debug

FROM ubuntu

RUN mkdir /tmp/godot

COPY --from=builder /tmp/groups_merge_script/bin /godot

CMD ["cp", "-r", "/godot", "/host/godot"]
