cgal-nsis-image
===============

This Docker image can be used to build a Windows installer from a CGAL release.

It requires two user mounted volumes:

- `/mnt/cgal_sources` a CGAL source tree
- `/mnt/cgal_release` a CGAL release

Example Usage:

    # Build or pull the image
    docker build -t cgal-nsis .
    docker run -v /path/to/cgal/release/:/mnt/cgal_release \
               -v /path/to/cgal/:/mnt/cgal_sources         \
               cgal-nsis

    # Extract the created public release.
    public_release_name=`cat "/path/to/cgal/Maintenance/release_building/public_release_name"`
    docker cp container_id:/nsis_release/${public_release_name}.exe .

SELinux issues
--------------
On Linux system using SELinux (such as the default setting for the recent
versions of Fedora, RHEL, and CentOS), you might need to relabel the host
files and directories used as volumes by the containers:

    chcon -Rt svirt_sandbox_file_t /path/to/cgal/release /path/to/cgal
