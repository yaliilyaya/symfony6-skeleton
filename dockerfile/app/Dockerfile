FROM yaliilyaya2/symfony6-skeleton-app:base

ARG SERVICE_NAME
ARG SERVICE_TAGS
ARG WORKING_DIR
ARG GIT_REPOSITORY

ENV SERVICE_NAME $SERVICE_NAME
ENV SERVICE_TAGS $SERVICE_TAGS

RUN git clone ${GIT_REPOSITORY} ${WORKING_DIR}

RUN cp ${WORKING_DIR}/.env.dist ${WORKING_DIR}/.env

RUN cd ${WORKING_DIR} \
    && composer install --no-cache \
    && composer clear-cache

COPY ./docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]