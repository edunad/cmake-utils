# By edunad / failcake https://github.com/edunad/cmake-utils
include(FindPackageHandleStandardArgs)

if(NOT EXISTS "${STEAMWORKS_SDKPATH}")
   message(FATAL_ERROR "No Steamworks API path selected, download SDK and set `STEAMWORKS_SDKPATH` to base folder")
endif()

if(NOT STEAMWORKS_FOUND)
    FIND_PATH(STEAMWORKS_INCLUDE_DIR steam/steam_api.h
        /usr/include
        /usr/local/include
        ${STEAMWORKS_SDKPATH}/public/
        DOC "Include path for Steamworks"
    )

    # FIND LIB ----
    if(WIN32)
        if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
            set(STEAMWORKS_LIBRARIES
                "${STEAMWORKS_SDKPATH}/redistributable_bin/steam_api.lib"
                "${STEAMWORKS_SDKPATH}/public/steam/lib/win32/sdkencryptedappticket.lib"
            )
            set(STEAMWORKS_BINARIES
                "${STEAMWORKS_SDKPATH}/redistributable_bin/steam_api.dll"
                "${STEAMWORKS_SDKPATH}/public/steam/lib/win32/sdkencryptedappticket.dll"
            )

            MESSAGE("32 bit steam")
        else ()
            set(STEAMWORKS_LIBRARIES
                "${STEAMWORKS_SDKPATH}/redistributable_bin/win64/steam_api64.lib"
                "${STEAMWORKS_SDKPATH}/public/steam/lib/win64/sdkencryptedappticket64.lib"
            )
            set(STEAMWORKS_BINARIES
                "${STEAMWORKS_SDKPATH}/redistributable_bin/win64/steam_api64.dll"
                "${STEAMWORKS_SDKPATH}/public/steam/lib/win64/sdkencryptedappticket64.dll"
            )

            MESSAGE("64 bit steam")
        endif()
    elseif (APPLE)
        set(STEAMWORKS_LIBRARIES
            "${STEAMWORKS_SDKPATH}/redistributable_bin/osx/libsteam_api.dylib"
            "${STEAMWORKS_SDKPATH}/public/steam/lib/osx/libsdkencryptedappticket.dylib"
        )
        set(STEAMWORKS_BINARIES "${STEAMWORKS_LIBRARIES}")
	else()
        if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
            set(STEAMWORKS_LIBRARIES
                "${STEAMWORKS_SDKPATH}/redistributable_bin/linux32/libsteam_api.so"
                "${STEAMWORKS_SDKPATH}/public/steam/lib/linux32/libsdkencryptedappticket.so"
            )
            set(STEAMWORKS_BINARIES "${STEAMWORKS_LIBRARIES}")

            MESSAGE("32 bit steam")
        else()
            set(STEAMWORKS_LIBRARIES
                "${STEAMWORKS_SDKPATH}/redistributable_bin/linux64/libsteam_api.so"
                "${STEAMWORKS_SDKPATH}/public/steam/lib/linux64/libsdkencryptedappticket.so"
            )
            set(STEAMWORKS_BINARIES ${STEAMWORKS_LIBRARIES})
            MESSAGE("64 bit steam")
        endif()
    endif ()
    # ----------------------

	MESSAGE(STATUS "Steam libs: ${STEAMWORKS_LIBRARIES}")
	MESSAGE(STATUS "Steam bins: ${STEAMWORKS_BINARIES}")
	MESSAGE(STATUS "Steam include: ${STEAMWORKS_INCLUDE_DIR}")

    find_package_handle_standard_args(STEAMWORKS REQUIRED_VARS STEAMWORKS_LIBRARIES STEAMWORKS_BINARIES STEAMWORKS_INCLUDE_DIR)
endif()

# MIT License Copyright (c) 2024 FailCake

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
# ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
