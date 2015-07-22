cgal-nsis-image
===============

This Docker image can be used to build a Windows installer from a CGAL release.

Example Usage:

    # Build or pull the image
    docker build -t cgal-nsis .
    docker run -v /path/to/cgal/release/:/mnt/cgal_release \
               -v /path/to/cgal/wininst/developer_scripts:/mnt/cgal_script  \
               -v /path/to/output/dir:/mnt/cgal_setup \
               -e CGAL_MAJOR=4 \
               -e CGAL_MINOR=7 \
               cgal-nsis cgal_build_installer

