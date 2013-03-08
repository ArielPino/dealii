#####
##
## Copyright (C) 2012, 2013 by the deal.II authors
##
## This file is part of the deal.II library.
##
## <TODO: Full License information>
## This file is dual licensed under QPL 1.0 and LGPL 2.1 or any later
## version of the LGPL license.
##
## Author: Matthias Maier <matthias.maier@iwr.uni-heidelberg.de>
##
#####

#
# Configuration for the SLEPC library:
#

SET(FEATURE_SLEPC_DEPENDS DEAL_II_WITH_PETSC)

MACRO(FEATURE_SLEPC_FIND_EXTERNAL var)
  FIND_PACKAGE(SLEPC)

  IF(SLEPC_FOUND)
    #
    # Check whether SLEPc and PETSc are compatible.
    #
    IF("${SLEPC_VERSION}" STREQUAL "${PETSC_VERSION}")
      SET(${var} TRUE)
    ELSE()

      MESSAGE(STATUS "Could not find a sufficient SLEPc installation: "
        "The SLEPc library must have the same version as the PETSc library."
        )
      SET(SLEPC_ADDITIONAL_ERROR_STRING
        "Could not find a sufficient SLEPc installation: "
        "The SLEPc library must have the same version as the PETSc library.\n"
        )

      UNSET(SLEPC_INCLUDE_DIR_ARCH CACHE)
      UNSET(SLEPC_INCLUDE_DIR_COMMON CACHE)
      UNSET(SLEPC_LIBRARY CACHE)
      SET(SLEPC_DIR "" CACHE STRING
        "An optional hint to a SLEPc directory"
        )
      SET(SLEPC_ARCH "" CACHE STRING
        "An optional hint to a SLEPc arch"
        )

      SET(${var} FALSE)
    ENDIF()
  ENDIF()
ENDMACRO()

MACRO(FEATURE_SLEPC_CONFIGURE_EXTERNAL)
  INCLUDE_DIRECTORIES(${SLEPC_INCLUDE_DIRS})

  # The user has to know the location of the SLEPC headers as well:
  LIST(APPEND DEAL_II_USER_INCLUDE_DIRS ${SLEPC_INCLUDE_DIRS})

  LIST(APPEND DEAL_II_EXTERNAL_LIBRARIES ${SLEPC_LIBRARIES})
ENDMACRO()


MACRO(FEATURE_SLEPC_ERROR_MESSAGE)
  MESSAGE(FATAL_ERROR "\n"
    "Could not find the SLEPc library!\n"
    ${SLEPC_ADDITIONAL_ERROR_STRING}
    "Please ensure that the SLEPc library version 3.0.0 or newer is installed on your computer\n"
    "and the version is the same as the one of the installed PETSc library.\n"
    "If the library is not at a default location, either provide some hints\n"
    "for the autodetection:\n"
    "SLEPc installed with --prefix=<...> to a destination:\n"
    "    $ SLEPC_DIR=\"...\" cmake <...>\n"
    "    $ cmake -DSLEPC_DIR=\"...\" <...>\n"
    "SLEPc compiled in source tree:\n"
    "    $ SLEPC_DIR=\"...\"  SLEPC_ARCH=\"...\" cmake <...>\n"
    "    $ cmake -DSLEPC_DIR=\"...\" -DSLEPC_ARCH=\"...\" <...>\n"
    "or set the relevant variables by hand in ccmake.\n\n"
    )
ENDMACRO()


CONFIGURE_FEATURE(SLEPC)