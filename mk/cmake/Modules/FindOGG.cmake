# Defines
#  OGG_FOUND
#  OGG_INCLUDE_DIR
#  OGG_LIBRARY
#  VORBIS_LIBRARY
#  VORBIS_FILE_LIBRARY
#

IF(WANT_STATIC_LIBS)
	OPTION(OGG_STATIC "Set to ON to link your project with static library (instead of DLL)." ON)
ENDIF()

# check for cache to avoid littering log
IF(OGG_INCLUDE_DIR AND OGG_LIBRARY AND VORBIS_LIBRARY)
	SET(OGG_BE_QUIET TRUE)
ENDIF()

FIND_PATH(OGG_INCLUDE_DIR ogg/ogg.h)

IF (OGG_STATIC AND NOT OGG_LIBRARY)
	FIND_LIBRARY(OGG_LIBRARY NAMES libogg.a ogg)
ELSE()
	FIND_LIBRARY(OGG_LIBRARY NAMES ogg)
ENDIF()

IF (OGG_STATIC AND NOT VORBIS_LIBRARY)
	FIND_LIBRARY(VORBIS_LIBRARY NAMES libvorbis.a vorbis)
ELSE()
	FIND_LIBRARY(VORBIS_LIBRARY NAMES vorbis)
ENDIF()

#on macosx the vorbisfile library is part of the vorbisone...
#IF(NOT APPLE)
# comment above is full of lies

IF (OGG_STATIC AND NOT VORBIS_FILE_LIBRARY)
	FIND_LIBRARY(VORBIS_FILE_LIBRARY NAMES libvorbisfile.a vorbisfile)
ELSE()
	FIND_LIBRARY(VORBIS_FILE_LIBRARY NAMES vorbisfile)
ENDIF()

#ENDIF(NOT APPLE)

IF(OGG_INCLUDE_DIR AND OGG_LIBRARY AND VORBIS_LIBRARY AND (APPLE OR VORBIS_FILE_LIBRARY))
	SET(OGG_FOUND TRUE)
	IF(NOT OGG_BE_QUIET)
		MESSAGE(STATUS "OGG/Vorbis includes: ${OGG_INCLUDE_DIR}")
		MESSAGE(STATUS "OGG library        : ${OGG_LIBRARY}")
		MESSAGE(STATUS "Vorbis library     : ${VORBIS_LIBRARY}")
		MESSAGE(STATUS "Vorbis file library: ${VORBIS_FILE_LIBRARY}")
	ENDIF(NOT OGG_BE_QUIET)
ELSE()
	SET(OGG_FOUND FALSE)
	MESSAGE("OGG/Vorbis was not found on this system!")
ENDIF()

MARK_AS_ADVANCED(
	OGG_INCLUDE_DIR
	OGG_LIBRARY
	VORBIS_LIBRARY
	VORBIS_FILE_LIBRARY
)
