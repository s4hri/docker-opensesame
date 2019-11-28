setfacl -m user:1000:r $XAUTHORITY
docker run -ti --rm \
           -v $XAUTHORITY:/home/user/.Xauthority \
           --net=host \
           -e $DISPLAY \
           --privileged \
           opensesame_src:psycho3
