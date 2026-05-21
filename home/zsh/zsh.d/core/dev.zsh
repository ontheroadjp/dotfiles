
tunnel1() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -R 3000:127.0.0.1:3000 nobita
}

tunnel2() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -R 4000:127.0.0.1:4000 nobita
}

tunnel3() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -R 5000:127.0.0.1:5000 nobita
}

tunneltmux() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -R 10322:127.0.0.1:10322 nobita
}

lo() {
    open http://localhost:${1:-8080}
}

