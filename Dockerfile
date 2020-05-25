FROM ubuntu:bionic
MAINTAINER Laurent Rineau <laurent.rineau@cgal.org>

RUN dpkg --add-architecture i386

RUN apt-get update -y && apt-get install -y wget gnupg2 software-properties-common cmake
#RUN wget -O- https://dl.winehq.org/wine-builds/Release.key | apt-key add -
#RUN wget -O- https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
#RUN apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
#RUN apt-get update -y

RUN apt-get install -y wine-stable winetricks xvfb

RUN apt-get purge -y software-properties-common
RUN apt-get autoclean -y

RUN apt-get update && apt-get install -y winbind nsis && apt-get clean -y
# ENV NSIS_URL http://prdownloads.sourceforge.net/nsis/nsis-2.46-setup.exe?download
# RUN wget -q -O nsis.exe $NSIS_URL && rm -rf /tmp/.wine-* && xvfb-run -a wine nsis.exe && rm -rf /tmp/.wine-*

# Install Locate and inetc plugin
ADD Locate.dll /usr/share/nsis/Plugins/
ADD Locate.nsh /usr/share/nsis/Include/
ADD inetc.dll /usr/share/nsis/Plugins/
ADD ZipDLL.dll /usr/share/nsis/Plugins/

VOLUME ["/mnt/cgal_sources", "/mnt/cgal_release"]

COPY ./docker_entrypoint.sh /
CMD ["/docker_entrypoint.sh"]
