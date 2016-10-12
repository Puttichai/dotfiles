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

alias denso_home="roslaunch denso_manipulation move_home_position.launch"
alias denso_fake="roslaunch denso_control denso_fake_controller.launch robot_name:=denso"
alias denso_fake_left="roslaunch denso_control denso_fake_controller.launch robot_name:=left"
alias denso_fake_right="roslaunch denso_control denso_fake_controller.launch robot_name:=right"
alias denso_left_rrt="roslaunch denso_control denso_rrt_controller.launch robot_name:=left denso_address:=192.168.0.11 netft_address:=192.168.0.12"
alias denso_right_rrt="roslaunch denso_control denso_rrt_controller.launch robot_name:=right denso_address:=192.168.0.21 netft_address:=192.168.0.22"
alias denso_left_rrt_read="roslaunch denso_control denso_rrt_controller.launch robot_name:=left motor_on:=False denso_address:=192.168.0.11 netft_address:=192.168.0.12"
alias denso_right_rrt_read="roslaunch denso_control denso_rrt_controller.launch robot_name:=right motor_on:=False denso_address:=192.168.0.21 netft_address:=192.168.0.22"

# Shortcut commands
alias up="cd .."

# Add OpenRAVE path to OPENRAVE_DATA
export OPENRAVE_DATA="${OPENRAVE_DATA}:/usr/local/share/openrave-0.9/data"

