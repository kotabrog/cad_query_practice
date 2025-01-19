docker build -t cadquery-conda:latest .

docker run -it --rm \
  -p 8888:8888 \
  -e DISPLAY \
  -e WAYLAND_DISPLAY \
  -e XDG_RUNTIME_DIR \
  -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  cadquery-conda:latest
