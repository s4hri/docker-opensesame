export XSOCK=/tmp/.X11-unix
export XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Enable AUDIO specifying ALSA_CARD name.
# cat /proc/asound/cards
#  0 [NVidia         ]: HDA-Intel - HDA NVidia
#                      HDA NVidia at 0xf6080000 irq 95
#  1 [Generic        ]: HDA-Intel - HD-Audio Generic
#                      HD-Audio Generic at 0xf6800000 irq 97

docker run --gpus all \
           -ti --rm \
           -v $XSOCK:$XSOCK \
           -v $XAUTH:$XAUTH \
           --env "XAUTHORITY=${XAUTH}" \
           --env="DISPLAY=${DISPLAY}" \
           --device /dev/snd --env ALSA_CARD=Generic \
           opensesame:v3.2.8-runtime-ubuntu18.04-nvidia-opengl
