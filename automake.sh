#!/usr/bin/env bash
echo "O=======================================================================O"
echo "|                                                                       |"
echo "|      ██╗   ██╗ ██████╗ ██╗  ██╗██████╗ ██████╗ ███████╗██╗   ██╗      |";
echo "|      ██║   ██║██╔═══██╗╚██╗██╔╝╚════██╗██╔══██╗██╔════╝██║   ██║      |";
echo "|      ██║   ██║██║   ██║ ╚███╔╝  █████╔╝██║  ██║█████╗  ██║   ██║      |";
echo "|      ██║   ██║██║   ██║ ██╔██╗  ╚═══██╗██║  ██║██╔══╝  ╚██╗ ██╔╝      |";
echo "|      ╚██████╔╝╚██████╔╝██╔╝ ██╗██████╔╝██████╔╝███████╗ ╚████╔╝       |";
echo "|       ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝  ╚═══╝        |";
echo "O=======================================================================O"
echo "| The Original UO Emulation Project -=- The Real Choice in UO Emulation |";
echo "O=======================================================================O"
echo "|                          https://www.uox3.org                         |"
echo "|                  https://github.com/UOX3DevTeam/UOX3                  |"
echo "O=======================================================================O"
debug=1
for flag in "$@"
do
    if [[ $flag -eq "release" || $flag -eq "RELEASE" ]];
    then
        define="BUILD_OPT=1 "
        bm="_r"
        buildmode="OPT"
        debug=0
        zlibmode=""
    fi
done

if [[ $debug -eq 1 ]];
then
    define=""
    bm="_d"
    buildmode="DBG"
    zlibmode="--debug"
    echo "|             DEBUG : DEBUG : DEBUG : DEBUG : DEBUG : DEBUG             |"
else
    echo "|             RELEASE : RELEASE : RELEASE : RELEASE : RELEASE           |"
fi
echo "O=======================================================================O"
echo

echo "O=======================================================================O"
echo "| ███╗ ██╗  █╗ ██╗  ███╗ ██╗   ██╗  ██╗  ██╗  █╗   █╗ █╗ █╗ ███╗ █╗  █╗ |"
echo "| █╔═╝ █╔█╗ █║ █╔█╗ █╔═╝ █╔█╗  ███╗███║ █╔═█╗ ██╗  █║ █║█╔╝ █╔═╝ ╚█╗█╔╝ |" 
echo "| ███╗ ██╔╝ █║ █║█║ ██╗  ██╔╝  █╔███╔█║ █║ █║ █╔█╗ █║ ██╔╝  ██╗   ╚█╔╝  |"
echo "| ╚═█║ █╔╝  █║ █║█║ █╔╝  █╔█╗  █║╚█╔╝█║ █║ █║ █║╚█╗█║ █╔█╗  █╔╝    █║   |"
echo "| ███║ █║   █║ ██╔╝ ███╗ █║█║  █║ ╚╝ █║ ╚██╔╝ █║ ╚██║ █║ █╗ ███╗   █║   |"
echo "| ╚══╝ ╚╝   ╚╝ ╚═╝  ╚══╝ ╚╝╚╝  ╚╝    ╚╝  ╚═╝  ╚╝  ╚═╝ ╚╝ ╚╝ ╚══╝   ╚╝   |"
echo "O=======================================================================O"
echo "|                              Version 1.7                              |"
echo "O=======================================================================O"

cd source/JSE
if [ "$(uname)" = "FreeBSD" ]
then
    gmake -f Makefile.ref ${define}DEFINES=-DHAVE_VA_LIST_AS_ARRAY CC=clang
else
    make -f Makefile.ref ${define}DEFINES=-DHAVE_VA_LIST_AS_ARRAY CC=gcc
fi

echo -n "Does library output folder exist... "
if [[ ! -d "../obj" ]]; 
then
    echo -n "No, creating... "
    mkdir -p "../obj/"
    echo "Done."
else
    echo "Yes, Done."
fi

echo -n "Packaging static library for "
if [ "$(uname)" = "Darwin" ]
then
        # Mac OS X
        echo -n "[MacOS]"
        ar rcs ../obj/libuox3jse${bm}.a Darwin_${buildmode}.OBJ/*.o
        cp Darwin_${buildmode}.OBJ/jsautocfg.h ./
elif [ "$(uname)" = "FreeBSD" ]
then
        echo -n "[FreeBSD]"
        ar rcs ../obj/libuox3jse${bm}.a FreeBSD_${buildmode}.OBJ/*.o
        cp FreeBSD_${buildmode}.OBJ/jsautocfg.h ./
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]
then
        # Linux
        echo -n "[Linux]"
        ar -rsc ../obj/libuox3jse${bm}.a Linux_All_${buildmode}.OBJ/*.o
        cp Linux_All_${buildmode}.OBJ/jsautocfg.h ./
fi

echo " -> Created '../obj/libuox3jse${bm}.a'... Done."

if [ $? -ne 0 ]; then
    echo "********************************************"
    echo "********* FAILED TO BUILD UOX3 JSE *********"
    echo "********************************************"
    echo "Exiting!"
    exit $?
else
    echo "********************************************"
    echo "******** UOX3 JSE BUILD SUCCESSFULL ********"
    echo "********************************************"
fi

echo

echo "O=======================================================================O"
echo "|         █████╗ █╗    █╗ ██╗               █████╗ █╗    █╗ ██╗         |"
echo "|         ╚══█╔╝ █║    █║ █╔█╗              ╚══█╔╝ █║    █║ █╔█╗        |"
echo "|           █╔╝  █║    █║ ██╔╝                █╔╝  █║    █║ ██╔╝        |"
echo "|          █╔╝   █║    █║ █╔█╗               █╔╝   █║    █║ █╔█╗        |"
echo "|         █████╗ ████╗ █║ ██╔╝              █████╗ ████╗ █║ ██╔╝        |"
echo "|         ╚════╝ ╚═══╝ ╚╝ ╚═╝               ╚════╝ ╚═══╝ ╚╝ ╚═╝         |"
echo "O=======================================================================O"
echo "|                           Version 1.2.11                              |"
echo "O=======================================================================O"
cd ../zlib
make distclean
./configure --static --64 ${zlibmode} --prefix="../obj" --libdir="../obj"
make
make install
echo -n "Renaming zlib.a -> "
if [[ $debug -eq 1 ]];
then
    echo -n "libzlib_d.a ... "
    mv ../obj/libz.a ../obj/libzlib_d.a
else
    echo -n "libzlib_r.a ... "
    mv ../obj/libz.a ../obj/libzlib_r.a
fi
echo "Done."

if [ $? -ne 0 ]; then
    echo "********************************************"
    echo "*********** FAILED TO BUILD ZLIB ***********"
    echo "********************************************"
    echo "Exiting!"
    exit $ev
else
    echo "********************************************"
    echo "********** ZLIB BUILD SUCCESSFULL **********"
    echo "********************************************"
fi

echo
echo "O=======================================================================O"
echo "|        █╗ █╗  ██╗ █╗  █╗ ███╗          █╗ █╗  ██╗ █╗  █╗ ███╗         |"
echo "|        █║ █║ █╔═█╗╚█╗█╔╝ ╚═██╗         █║ █║ █╔═█╗╚█╗█╔╝ ╚═██╗        |"
echo "|        █║ █║ █║ █║ ╚█╔╝   ██╔╝         █║ █║ █║ █║ ╚█╔╝   ██╔╝        |"
echo "|        █║ █║ █║ █║ █╔█╗   ╚██╗         █║ █║ █║ █║ █╔█╗   ╚██╗        |"
echo "|        ╚██╔╝ ╚██╔╝█╔╝ █╗ ███╔╝         ╚██╔╝ ╚██╔╝█╔╝ █╗ ███╔╝        |"
echo "|         ╚═╝   ╚═╝ ╚╝  ╚╝ ╚═╝            ╚═╝   ╚═╝ ╚╝  ╚╝ ╚═╝          |"
echo "O=======================================================================O"
echo "|                           Version 0.99.x                              |"
echo "O=======================================================================O"
cd ../
echo "Building UOX3"
if [ "$(uname)" = "FreeBSD" ]
then
  gmake
else
  make
fi

ls

result=$?
if [[ ! -f ../data/uox3 ] || [ $result -ne 0 ] ]; then
    echo "********************************************"
    echo "*********** FAILED TO BUILD UOX3 ***********"
    echo "********************************************"
    echo "Exiting!"
    cd ../
    exit ${result}
else
    echo "********************************************"
    echo "********** UOX3 BUILD SUCCESSFULL **********"
    echo "********************************************"
    echo "Switching to data folder."
    echo "Type './uox3' to run."
    cd ../data
fi

exit ${result}
