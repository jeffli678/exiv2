set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_CONTACT "Luis Díaz Más <piponazo@gmail.com>")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

set(CPACK_SOURCE_GENERATOR TGZ)
set(CPACK_SOURCE_IGNORE_FILES "build.*;\.git/;\.DS_Store;")

## -----------------------------------------------
## TODO:  Luis will rewrite this -----------------
if ( MINGW OR MSYS )
    if ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
        set (PACKNAME MinGW-64)
    else()
        set (PACKNAME MinGW-32)
    endif()
    set (PACKDIR MinGW)
elseif ( MSVC )
    set (PACKNAME MSVC)
    set (PACKDIR  MSVC)
else()
    set (PACKNAME ${CMAKE_SYSTEM_NAME}) # Darwin or Linux or CYGWIN
    set (PACKDIR  ${PACKNAME})
endif()

if ( CYGWIN OR MINGW OR MSYS )
    set(CPACK_GENERATOR TGZ)  # MinGW/Cygwin use .tar.gz
elseif ( MSVC )
    set(CPACK_GENERATOR ZIP)  # use .zip - less likely to damage bin/exiv2lib.dll permissions
else()
    set(CPACK_GENERATOR TGZ)  # Linux or MacOS-X: use .tar.gz
endif()

set(CPACK_PACKAGE_FILE_NAME ${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${PACKNAME})

# https://stackoverflow.com/questions/17495906/copying-files-and-including-them-in-a-cpack-archive
install(FILES     "${PROJECT_SOURCE_DIR}/samples/exifprint.cpp" DESTINATION "samples")
install(DIRECTORY "${PROJECT_SOURCE_DIR}/contrib/"              DESTINATION "contrib")

# Copy top level documents (eg README.md)
# https://stackoverflow.com/questions/21541707/cpack-embed-text-files
set( DOCS
     README.md
     README-CONAN.md
     license.txt
)
foreach(doc ${DOCS})
    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/${doc} DESTINATION .)
endforeach()

# Copy releasenotes.txt and appropriate ReadMe.txt (eg releasenotes/${PACKDIR}/ReadMe.txt)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/releasenotes/${PACKDIR}/ReadMe.txt DESTINATION .)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/releasenotes/releasenotes.txt      DESTINATION .)

## TODO: End                     -----------------
## -----------------------------------------------

include (CPack)
