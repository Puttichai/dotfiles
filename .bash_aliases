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

# ROS Staff
source ~/catkin_ws/devel/setup.bash
alias roscat="cd ~/catkin_ws && catkin_make && cd -"
alias cd_catkin="cd ~/catkin_ws/src"
alias cd_denso_ros="cd ~/catkin_ws/src/denso_ros"

# Shortcut commands
alias up="cd .."

# Add OpenRAVE path to OPENRAVE_DATA
export OPENRAVE_DATA="${OPENRAVE_DATA}:/usr/local/share/openrave-0.9/data"

