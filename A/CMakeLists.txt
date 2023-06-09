set(lib A)

add_library(${lib} SHARED)
set_target_properties(${lib} PROPERTIES
    SOURCE_FILES Foo.cpp
    INCLUDE_FILES Foo.h)

MakeLib(${lib})

target_include_directories(${lib} PUBLIC ${CMAKE_SOURCE_DIR})
