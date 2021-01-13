#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/swetang/final_project_ws/src/turtlebot3_example"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/swetang/final_project_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/swetang/final_project_ws/install/lib/python2.7/dist-packages:/home/swetang/final_project_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/swetang/final_project_ws/build" \
    "/usr/bin/python2" \
    "/home/swetang/final_project_ws/src/turtlebot3_example/setup.py" \
     \
    build --build-base "/home/swetang/final_project_ws/build/turtlebot3_example" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/swetang/final_project_ws/install" --install-scripts="/home/swetang/final_project_ws/install/bin"
