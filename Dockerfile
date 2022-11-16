FROM python:3.9-alpine3.16
LABEL maintainer="apiproject.com"

ENV PYTHONUNBUFFERED 1

copy ./requirements.txt /tmp/requirements.txt
copy ./requirements.dev.txt /tmp/requirements.dev.txt
copy ./app /app
WORKDIR /app
EXPOSE 8080
ARG DEV=false
RUN python -m venv /py && \
/py/bin/pip install --upgrade pip && \
/py/bin/pip install -r /tmp/requirements.txt && \
if [ $DEV = "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
fi && \
rm -rf /tmp && \
adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user
