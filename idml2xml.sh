#!/bin/bash

function usage {
    echo ""
    echo "idml2xml"
    echo ""
    echo "Usage: idml2xml.sh [options ...] <idml file>"
    echo ""
    echo "Options:"
    echo "   -o    relative or absolute path to custom output directory"
    echo "   -d    debug mode"
    1>&2; exit 1;
}
function exitonerror {
    echo "[ERROR] $2. Exited with code $1."
    echo "For details see $LOG"
    exit 1
}
function log {
    2>&1 2>>$OUT_DIR/$BASENAME.d2h.log
}

# cygwin check
cygwin=false;
case "`uname`" in
    CYGWIN*) cygwin=true;
esac

# script directory
DIR="$( cd -P "$(dirname $( readlink -f "$0" ))" && pwd )"
PWD=$(readlink -f .)
CALABASH=$DIR/calabash/calabash.sh
HEAP=1024m

# specify options
while getopts ":o:d" opt; do
    case "${opt}" in
	o)
	    OUT_DIR=${OPTARG}
	    ;;
	d)
	    DEBUG=yes
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    usage
	    ;;
	:)
	    echo "Option -$OPTARG requires an argument." >&2
	    usage
	    ;;
    esac
done
shift $((OPTIND-1))
# check if argument for file is set
if [ -z $1 ]; then
    usage
fi

FILE=$(readlink -f $1)
BASENAME=$(basename $FILE .idml)
if [[ -z "$OUT_DIR" ]]; then
    OUT_DIR="$(dirname $(readlink -f "$FILE" ))"
else
if [[ "$OUT_DIR" != /* ]]; then 
    OUT_DIR="$PWD/$OUT_DIR"
fi
fi

mkdir -p $OUT_DIR

# set log 
LOG=$OUT_DIR/$BASENAME.log
# remove log from previous runs
if [ -e $LOG ]; then
    rm $LOG
fi

# debugging
DEBUG_DIR=$OUT_DIR/$BASENAME.debug

# make absolute paths
if $cygwin; then
    FILE=$(cygpath -ma "$FILE")
    DIR=$(cygpath -ma "$DIR")
    OUT_DIR=$(cygpath -ma "$OUT_DIR")
    DEBUG_DIR_URI=file:/$(cygpath -ma "$DEBUG_DIR" )
else
    DEBUG_DIR_URI=file:$(readlink -f $DEBUG_DIR)
fi

# check if file exists
if [ ! -f $FILE ]; then
    exitonerror 1 "input file not found: $FILE"
fi

echo "starting idml2xml"

if [ "$DEBUG" = "yes" ]; then
    echo "debug mode: $DEBUG"
    echo "storing debug files to $DEBUG_DIR"
    echo ""
    echo "Parameters"
    echo "  workdir: $DIR"
    echo "  outdir: $OUT_DIR"
    echo "  file: $FILE"
    echo ""
fi

# idml2xml xproc pipeline
HEAP=$HEAP $CALABASH \
    -o result=$OUT_DIR/$BASENAME.xml \
    $DIR/xpl/idml2xml-frontend.xpl \
    idml=$FILE \
    debug=$DEBUG \
    debug-dir-uri=$DEBUG_DIR_URI \
    status-dir-uri=$DEBUG_DIR_URI/status 2>&1 2>>$LOG || exitonerror $? xproc


# delete temp files
if [ "$DEBUG" != "yes" ]; then
    rm -rf $FILE.tmp $DEBUG_DIR
fi

echo "writing xml => $OUT_DIR/$BASENAME.xml"

echo "idml2xml finished, for details see $LOG"
echo ""
