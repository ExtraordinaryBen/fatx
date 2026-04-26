# FATX Filesystem Library
#
# Copyright (C) 2015  Matt Borgerson

cmake_minimum_required(VERSION 3.15)

project(libfatx VERSION 1.0)

set(CMAKE_C_STANDARD 11)
add_library(fatx STATIC
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_attr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_dev.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_dir.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_disk.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_fat.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_file.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_misc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_partition.c
    ${CMAKE_CURRENT_SOURCE_DIR}/ext.c
)

set_target_properties(fatx PROPERTIES 
    POSITION_INDEPENDENT_CODE ON
    CMAKE_C_STANDARD_REQUIRED ON
)
target_compile_options(fatx PRIVATE -D_FILE_OFFSET_BITS=64 -Wall)
if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(fatx PRIVATE -fPIC)
endif()

include(GNUInstallDirs)

install(TARGETS fatx
    EXPORT fatxTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx.h
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_log.h
    ${CMAKE_CURRENT_SOURCE_DIR}/fatx_version.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(EXPORT fatxTargets
    NAMESPACE libfatx::
    FILE libfatxTargets.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libfatx
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/libfatxTargetsConfig.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/libfatxConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/libfatxConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libfatx
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/libfatxConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/libfatxTargetsConfig.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libfatx
)

configure_file(libfatx.pc.in ${CMAKE_CURRENT_BINARY_DIR}/libfatx.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libfatx.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)