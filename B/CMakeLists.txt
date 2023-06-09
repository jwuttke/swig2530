set(lib B)

add_library(${lib} SHARED)
set_target_properties(${lib} PROPERTIES
    SOURCE_FILES Bar.cpp
    INCLUDE_FILES Bar.h)

MakeLib(${lib})

target_link_libraries(${lib} PUBLIC A)
target_include_directories(${lib} PUBLIC ${CMAKE_SOURCE_DIR})
