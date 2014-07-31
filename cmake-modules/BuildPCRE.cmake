macro(build_pcre install_prefix staging_prefix)
  
  IF(${CMAKE_BUILD_TYPE} STREQUAL Release)
    SET(EXT_C_FLAGS   "${CMAKE_C_FLAGS}   ${CMAKE_C_FLAGS_RELEASE}")
    SET(EXT_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_RELEASE}")
  ELSE()
    SET(EXT_C_FLAGS   "${CMAKE_C_FLAGS}    ${CMAKE_C_FLAGS_DEBUG}")
    SET(EXT_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG}")
  ENDIF()

  ExternalProject_Add(PCRE
    SOURCE_DIR PCRE
    URL "http://downloads.sourceforge.net/project/pcre/pcre/8.12/pcre-8.12.tar.gz"
    URL_MD5 "fa69e4c5d8971544acd71d1f10d59193"
    BUILD_IN_SOURCE 1
    INSTALL_DIR     "${staging_prefix}"
    BUILD_COMMAND   make 
    INSTALL_COMMAND make DESTDIR=${staging_prefix} install 
    CONFIGURE_COMMAND  ./configure --prefix=${install_prefix} --with-pic --disable-shared --enable-cpp CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} "CXXFLAGS=${EXT_CXX_FLAGS}" "CFLAGS=${EXT_C_FLAGS}"
  )

  SET(PCRE_INCLUDE_DIR  ${staging_prefix}/${install_prefix}/include )
  SET(PCRE_LIBRARY      ${staging_prefix}/${install_prefix}/lib/libpcre.a )
  SET(PCRECPP_LIBRARY   ${staging_prefix}/${install_prefix}/lib/libpcrecpp.a )
  SET(PCRE_FOUND ON)
 

endmacro(build_pcre)
