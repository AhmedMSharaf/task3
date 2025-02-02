FROM postman/newman:5.3-alpine
RUN apk update && apk upgrade
RUN apk add --no-cache curl zip iputils
RUN npm install -g newman-reporter-csvallinone
ENV NODE_PATH=/usr/local/lib/node_modules
WORKDIR /etc/newman
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'echo "nameserver 8.8.8.8" > /etc/resolv.conf' >> /entrypoint.sh && \
    echo 'echo "nameserver 1.1.1.1" >> /etc/resolv.conf' >> /entrypoint.sh && \
    echo 'exec "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh", "newman"]
