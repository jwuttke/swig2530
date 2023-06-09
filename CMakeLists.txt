### CMake configuration

cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR})

### Project settings

project(MinimalExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)

### Function definition

function(MakeLib lib)

    # get target properties
    get_target_property(source_files ${lib} SOURCE_FILES)
    get_target_property(include_files ${lib} INCLUDE_FILES)

    # suppress warnings from auto-generated code
    set_source_files_properties(${AUTO_DIR}/lib${lib}_wrap.cpp
        PROPERTIES COMPILE_OPTIONS "-Wno-unused-parameter;")

    list(APPEND source_files ${AUTO_DIR}/lib${lib}_wrap.cpp)

    set_target_properties(${lib} PROPERTIES SOURCES "${source_files}")

    # run Swig
    set(SWIG_FLAGS "-c++;-python;-Werror;-o;${AUTO_DIR}/lib${lib}_wrap.cpp;-outdir;${AUTO_DIR}"
        ";-I${CMAKE_SOURCE_DIR};-I${CMAKE_BINARY_DIR}/inc")

    add_custom_command(
        OUTPUT ${AUTO_DIR}/lib${lib}.py
               ${AUTO_DIR}/lib${lib}_wrap.h
               ${AUTO_DIR}/lib${lib}_wrap.cpp
        COMMAND ${SWIG_EXECUTABLE} ${SWIG_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/lib${lib}.i
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/lib${lib}.i ${include_files}
        )

    # include Python headers and link to Python shared library
    target_include_directories(${lib} PRIVATE ${Python3_INCLUDE_DIRS})
    target_link_libraries(${lib} PRIVATE ${Python3_LIBRARIES})

endfunction()

### Directories

set(AUTO_DIR ${CMAKE_SOURCE_DIR}/auto)
file(MAKE_DIRECTORY ${AUTO_DIR})

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY         ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY         ${CMAKE_BINARY_DIR}/bin)

### Python

find_package(Python3 3.8 REQUIRED COMPONENTS Development)

### Swig

find_package(SWIG 4.1 EXACT REQUIRED)
include(${SWIG_USE_FILE})

### Sources

add_subdirectory(A)
add_subdirectory(B)
