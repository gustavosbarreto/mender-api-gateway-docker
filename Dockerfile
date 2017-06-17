FROM openresty/openresty:alpine


# forward request and error logs to docker log collector
RUN mkdir -p /var/log/nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

RUN mkdir /usr/local/openresty/nginx/conf.d

COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY nginx-ssl.conf /usr/local/openresty/nginx/conf.d/nginx-ssl.conf

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
