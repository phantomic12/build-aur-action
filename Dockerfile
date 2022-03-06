FROM archlinux:latest AS arch
RUN pacman -Syu base-devel git --noconfirm --overwrite '*' && sed -i '/E_ROOT/d' /usr/bin/makepkg
RUN useradd -m -G wheel -s /bin/bash build
RUN perl -i -pe 's/# (%wheel ALL=\(ALL:ALL\) NOPASSWD: ALL)/$1/' /etc/sudoers
RUN cat /etc/sudoers
USER build
RUN cd /tmp && git clone https://aur.archlinux.org/paru-bin.git
RUN cd /tmp/paru-bin && sudo pacman -Syu --noconfirm && makepkg -sf

USER root
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

