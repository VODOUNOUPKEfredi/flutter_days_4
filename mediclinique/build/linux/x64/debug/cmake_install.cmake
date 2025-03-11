# Install script for directory: /home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/linux

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/")
  
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic"
         RPATH "$ORIGIN/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle" TYPE EXECUTABLE FILES "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/intermediates_do_not_run/mediclic")
  if(EXISTS "$ENV{DESTDIR}/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic"
         OLD_RPATH "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/linux/flutter/ephemeral:"
         NEW_RPATH "$ORIGIN/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/mediclic")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/data/icudtl.dat")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/data" TYPE FILE FILES "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/linux/flutter/ephemeral/icudtl.dat")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/lib/libflutter_linux_gtk.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/lib" TYPE FILE FILES "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/linux/flutter/ephemeral/libflutter_linux_gtk.so")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/lib/")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/lib" TYPE DIRECTORY FILES "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/native_assets/linux/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/data/flutter_assets")
  
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/data/flutter_assets")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/bundle/data" TYPE DIRECTORY FILES "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build//flutter_assets")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/flutter/cmake_install.cmake")
  include("/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/runner/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/fredy/aptMobile/flutter_days _4/flutter_days_4/mediclicinique/build/linux/x64/debug/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
