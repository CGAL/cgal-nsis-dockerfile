cgal-nsis-image
===============

This Docker image can be used to build a Windows installer from a CGAL release.

Example Usage:

    # Build or pull the image
    docker build -t cgal-nsis .
    docker run -v /path/to/cgal/release/:/mnt/cgal_release                  \
               -v /path/to/cgal/wininst/developer_scripts:/mnt/cgal_script  \
               cgal-nsis cgal_build_installer
    # Extract the created file setup.exe
    docker cp container_id:/nsis-release/CGAL-${CGAL_MAJOR}.${CGAL_MINOR}.exe .
