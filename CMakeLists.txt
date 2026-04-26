cmake_minimum_required(VERSION 3.15)

project(fatx)
option(BUILD_FATXFS "Build fatxfs FUSE driver" ON)

add_subdirectory(libfatx)

if(BUILD_FATXFS)
    add_subdirectory(fatxfs)
endif()