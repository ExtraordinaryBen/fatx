# FATX FUSE Driver
#
# Copyright (C) 2015  Matt Borgerson

cmake_minimum_required(VERSION 3.15)

project(fatxfs)

find_package(PkgConfig REQUIRED)
pkg_check_modules(FUSE REQUIRED fuse)

find_package(libfatx REQUIRED)

add_executable(fatxfs ${CMAKE_CURRENT_SOURCE_DIR}/fatxfs_fuse.c)

target_link_libraries(fatxfs PUBLIC libfatx::fatx)
target_link_libraries(fatxfs PUBLIC ${FUSE_LIBRARIES})
target_include_directories(fatxfs PUBLIC ${FUSE_INCLUDE_DIRS})
target_compile_options(fatxfs PUBLIC ${FUSE_CFLAGS_OTHER})

install(TARGETS fatxfs DESTINATION ${CMAKE_INSTALL_BINDIR})

find_program(RONN NAMES ronn)
if(RONN)
    add_custom_target(manpage ${RONN} < ${CMAKE_CURRENT_SOURCE_DIR}/man/fatxfs.1.ronn
                                    > ${CMAKE_CURRENT_BINARY_DIR}/fatxfs.1)
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/fatxfs.1
            DESTINATION ${CMAKE_INSTALL_MANDIR}/man1)
endif()