FROM monokrome/wine

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
ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["cgal_build_installer"]