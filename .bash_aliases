# Cool function for removing temporary files ending with ~ . 
# Obtained from
# http://askubuntu.com/questions/233544/command-for-deleting-temporary-files-ending-with

rm~() {
    case "$1" in
    "--dry-run")
        find . -name "*~" -type f -printf "[dry-run] Removing file %p\n"
        ;;
    "-d")
        find . -name "*~" -type f -printf "[dry-run] Removing file %p\n"
        ;;
    "")
        find . -name "*~" -type f -printf "Removing file %p\n" -delete
        ;;
    *)
        echo "Unsupported option \`$1'. Did you mean --dry-run?"
        ;;
    esac
}

# Add OpenRAVE path to OPENRAVE_DATA
export OPENRAVE_DATA="${OPENRAVE_DATA}:/usr/local/share/openrave-0.9/data"

export SWIFT_ROOT="/opt/swift-3.1.1"
export PATH="$SWIFT_ROOT/usr/bin:$PATH"

[ ! -d "$HOME/usr/src" ] && mkdir -p "$HOME/usr/src"
export PKG_CONFIG_PATH="${HOME}/usr/lib/pkgconfig:${PKG_CONFIG_PATH}"
export CPATH="${HOME}/usr/include:${CPATH}"

export MANPATH="${HOME}/usr/share/man:${MANPATH}"

export PATH="${HOME}/usr/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/usr/lib:${LD_LIBRARY_PATH}"

# Go lang (NOV 2020)
export PATH=$PATH:/usr/local/go/bin

# Julia
alias julia="/home/petch/git/julia/./julia"

# Flutter
export PATH="$PATH:/home/petch/dev/flutter/bin"

# Android Studio
export PATH="$PATH:/home/petch/dev/android-studio/bin"