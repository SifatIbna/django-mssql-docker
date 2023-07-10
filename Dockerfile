FROM python:3.9.13-slim-buster

LABEL maintainer='SIFAT'

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive

ADD odbcinst.ini /etc/

# Installing ODBC Drive 17
RUN apt-get update -y \
    && apt-get install -y curl gnupg \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update -y \
    && apt-get install -y unixodbc unixodbc-dev tdsodbc freetds-common freetds-bin freetds-dev \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get -y install mssql-tools msodbcsql17 \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && apt-get update

# COPY requirements.txt file
COPY ./requirements.txt /tmp

# Creating Environment
RUN python -m venv /py \
    && apt-get update \
    && /py/bin/pip install --upgrade pip \
    && /py/bin/pip install -r /tmp/requirements.txt \
    && rm -rf /tmp

ENV PATH="/py/bin:$PATH"

EXPOSE 8000