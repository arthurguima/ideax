FROM python:alpine

ARG VERSION=master

RUN \
    apk add --no-cache unzip wget ca-certificates gcc openldap-dev binutils-libs binutils gmp isl libgomp libatomic libgcc pkgconf pkgconfig mpfr3 mpc1 libstdc++ libc-dev musl-dev mariadb-dev postgresql-dev nginx

RUN \
    cd /var/www; \
    wget -q -O ideax.tar.gz https://github.com/filhocf/ideax/archive/${VERSION}.tar.gz; \
    tar xf ideax.tar.gz; \
    mv ideax-master ideax; \
    rm ideax.tar.gz; \
    cd ideax; \
    pip install -r docker/requeriments.txt

#RUN \
#    apk del binutils-libs binutils gmp isl libgomp libatomic libgcc pkgconf pkgconfig mpfr3 mpc1 libstdc++ gcc musl-dev libc-dev zlib-dev openssl-dev mariadb-common mariadb-client-libs libaio mariadb-libs mariadb-dev db libsasl cyrus-sasl-dev libuuid libblkid libfdisk libmount libsmartcols util-linux-dev unzip wget

WORKDIR /var/www/ideax

COPY ./docker/entrypoint.sh /

COPY ./docker/nginx.conf /etc/nginx/

CMD ["/entrypoint.sh"]
