FROM alpine:3.4

RUN apk --no-cache add python postgresql-libs && \
    apk --no-cache add --virtual build-dependencies python-dev py-pip gcc musl-dev postgresql-dev wget ca-certificates && \
    wget -q https://ftp.postgresql.org/pub/pgadmin3/pgadmin4/v1.1/pip/pgadmin4-1.1-py2-none-any.whl && \
    pip --no-cache-dir install pgadmin4-1.1-py2-none-any.whl && \
    rm pgadmin4-1.1-py2-none-any.whl && \
    apk del build-dependencies

ENV PACKAGE_DIR /usr/lib/python2.7/site-packages/pgadmin4
ENV CONFIG_FILE $PACKAGE_DIR/config_local.py

RUN touch $CONFIG_FILE && \
    echo "SERVER_MODE = False" >> $CONFIG_FILE && \
    echo "DEFAULT_SERVER = '0.0.0.0'" >> $CONFIG_FILE && \
    adduser -D pgadmin

USER pgadmin

VOLUME /home/pgadmin

CMD ["sh", "-c", "python ${PACKAGE_DIR}/pgAdmin4.py"]
