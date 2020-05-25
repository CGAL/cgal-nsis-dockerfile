#!/bin/bash
set -e

SOURCES_DIR=/mnt/cgal_sources/
NUMBERS_DIR=${SOURCES_DIR}/Maintenance/release_building/
if [ -f ${NUMBERS_DIR}/MAJOR_NUMBER ]; then
    MAJOR_NUMBER=`cat ${NUMBERS_DIR}/MAJOR_NUMBER`     # 2 digits max
    MINOR_NUMBER=`cat ${NUMBERS_DIR}/MINOR_NUMBER`     # 2 digits max
    BUGFIX_NUMBER=`cat ${NUMBERS_DIR}/BUGFIX_NUMBER`   # 1 digit max
    public_release_name=`cat "${NUMBERS_DIR}/public_release_name"`
else
    eval $(cmake -DCGALCONFIGVERSIONFILE=${SOURCES_DIR}/CGALConfigVersion.cmake -P ${SOURCES_DIR}/Scripts/developer_scripts/create_new_release_evaluate_versions.cmake 2>&1)
fi
mkdir nsis_release
cd nsis_release
cp -R /mnt/cgal_release "${public_release_name}"
cp ${SOURCES_DIR}/wininst/developer_scripts/* .
sed -i -e '/define *CGAL_SRC/,+20 s/CGAL-[0-9].[0-9]/'"${public_release_name}/g" script_cgal.nsi
makensis "script_cgal.nsi"
