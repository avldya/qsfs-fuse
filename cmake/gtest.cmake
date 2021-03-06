if (CMAKE_VERSION VERSION_LESS 3.2)
    set(UPDATE_DISCONNECTED_IF_AVAILABLE "")
else()
    # UPDATE_DISCONNECTED is 1 by default
    if (UPDATE_CONNECT)
        set(UPDATE_DISCONNECTED_IF_AVAILABLE "UPDATE_DISCONNECTED 0")
    endif()
endif()

include(cmake/DownloadInstallProject.cmake)

# Use googletest instead of gtest to avoid override the CMAKE implict variables
# gtest_SOURCE_DIR and gtest_BINARY_DIR
setup_download_project(PROJ      googletest
             GIT_REPOSITORY      https://github.com/google/googletest.git
             #GIT_TAG             master
             GIT_TAG             cf9d634  # choose this commit, as gtest latest version borken on gcc 4.4 or below
             ${UPDATE_DISCONNECTED_IF_AVAILABLE}
)

# Prevent GoogleTest from overriding our compiler/linker options
# when building with Visual Studio
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Download
download_project(googletest)

# Install
install_project(googletest ${EXTERNAL_PROJECT_INSTALL_PREFIX})

# Uninstall
include(cmake/UninstallProject.cmake)
setup_uninstall_project(googletest)
