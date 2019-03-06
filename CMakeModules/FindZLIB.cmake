# Find the Zlib library
#
# This module defines
# ZLIB_INCLUDE_DIR, where to find zlib.h
# ZLIB_LIBRARIES, the libraries to link against to use Zlib.
# ZLIB_FOUND, If false, do not try to use Zlib
#
# The user may specify ZLIB_INCLUDE_DIR and ZLIB_LIBRARY_DIR variables
# to locate include and library files
#
include(CheckLibraryExists)
include(CheckIncludeFile)

set(ZLIB_INCLUDE_DIR CACHE STRING "Location of ZLIB include files")
set(ZLIB_LIBRARY_DIR CACHE STRING "Location of ZLIB library files")

if(ZLIB_INCLUDE_DIR)
  set(CMAKE_REQUIRED_INCLUDES ${ZLIB_INCLUDE_DIR})
endif(ZLIB_INCLUDE_DIR)

check_include_file(zlib.h HAVE_ZLIB_H)

find_library(ZLIB_LIBRARY NAMES zlibdll zlib z PATHS ${ZLIB_LIBRARY_DIR})
if(ZLIB_LIBRARY)
  check_library_exists(${ZLIB_LIBRARY} deflate "" HAVE_ZLIB_LIBRARY)
endif(ZLIB_LIBRARY)
if(HAVE_ZLIB_LIBRARY)
  set(ZLIB_LIBRARIES ${ZLIB_LIBRARY})
endif(HAVE_ZLIB_LIBRARY)

if(WIN32 AND HAVE_ZLIB_LIBRARY)
get_filename_component(ZLIB_LIBRARY_NAME ${ZLIB_LIBRARY} NAME_WE)
find_file(ZLIB_DLL NAMES ${ZLIB_LIBRARY_NAME}.dll PATHS ${ZLIB_LIBRARY_DIR} ${ZLIB_LIBRARY_DIR}/../bin)
if(ZLIB_DLL)
set(ZLIB_DLLS ${ZLIB_DLL})
endif(ZLIB_DLL)
endif(WIN32 AND HAVE_ZLIB_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZLIB DEFAULT_MSG HAVE_ZLIB_LIBRARY HAVE_ZLIB_H)
