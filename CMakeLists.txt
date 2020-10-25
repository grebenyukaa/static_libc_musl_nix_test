project (test)
cmake_minimum_required(VERSION 3.18)

set (SOURCE_FILES
	test.cpp
)

#set (Boost_NO_SYSTEM_PATHS ON)
set (BOOST_ROOT "$ENV{CMAKE_BOOST_PATH}/")
#set (Boost_USE_STATIC_LIBS ON)
#set (Boost_USE_MULTITHREADED ON)
#message (STATUS "BOOST_ROOT = ${BOOST_ROOT}")
#find_package(Boost 1.69.0 REQUIRED COMPONENTS filesystem)

add_library (${PROJECT_NAME} SHARED ${SOURCE_FILES})

# The static side of libc is a pathway to many ldflags, some consider.. unnatural
#
# Here we perform a tedious task of telling gcc and ld how to link everything statically in correct order.
# Wrong link order results in .so files, that are linked to libc dynamically, even if -static is specified ¯\_(ツ)_/¯
target_link_libraries (${PROJECT_NAME}
	-Wl,--no-undefined
	-Wl,-Bstatic
	-Wl,-lboost_filesystem
	-Wl,-lboost_system
	-static-libgcc
	-static-libstdc++
	-Wl,-lstdc++
	-Wl,-lgcc
	-Wl,-lgcc_eh
	-Wl,-lc
	-nolibc
)
