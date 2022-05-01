FROM ghcr.io/dbushell/ubuntu

ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 5901

WORKDIR /root
USER root

RUN apt update \
  && apt upgrade -y \
  && apt autoremove -y \
  && apt install -y xfce4 xfce4-terminal \
    fonts-firacode fonts-noto-color-emoji \
  && apt clean -y

RUN wget -qO- https://iweb.dl.sourceforge.net/project/tigervnc/stable/1.12.0/tigervnc-1.12.0.x86_64.tar.gz \
  | tar xz --strip 1 -C /

ENV DISPLAY=:1 \
  VNC_DEPTH=24 \
  VNC_RESOLUTION=3840x2160 \
  VNC_PASSWORD=password

WORKDIR ${HOME}

RUN mkdir -p $HOME/.config/

COPY scripts/ ${HOME}/
COPY config/ ${HOME}/.config/

RUN chmod +x $HOME/*.sh \
  && chown -R ${PUID}:${PGID} $HOME

RUN $HOME/brave.sh && apt clean -y
RUN $HOME/edge.sh && apt clean -y
RUN $HOME/firefox.sh && apt clean -y

USER ${USER}

ENTRYPOINT ["/home/user/vnc.sh"]
