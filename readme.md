## INTRODUCTION

This Image is built on Python3.8 Buster, which is Debian Based Python Image. This image is solely built for Running Django with SQL Server Database. \
`Mind that, There's already an image for SQL SERVER. So what makes this image unique?` \
The Image Microsoft developed, is useful when we want to **mantaine** seperate database for the project, but _If anyone wants to connect to a remote database server using IP and Password_, it raises many issues.
Thats where this image will be helpful for those who want use this image for building Django application.

## How to use this Image?

well, in your **DOCKERFILE**, or **docker-compose.yml**, just use

```
sifatibnaamin/django-mssql-base:latest
```

as Base Image, and run your additional commands on the top of that,
A Template for the Dockerfile is given below

```
FROM sifatibnaamin/django-mssql-base:latest
COPY ./ /app
WORKDIR /app
RUN /py/bin/pip install -r requirements.txt
EXPOSE 8000
```

`Keep in mind that, it has already installed, Django & mssql-django package in /py virtual environment`

And As **DRIVER** I'm using **FreeTDS (TDS Protocol)** which needs extra configuration in your django settings.

so In the `settings.py` of your project,
in the `DATABASES` section,
your database configuration should look like below

```
DATABASES = {
    "default": {
        "ENGINE": "mssql",
        "NAME": "", // Database Name
        "USER": "",
        "PASSWORD": "",
        "HOST": "",
        "PORT": "",
        'OPTIONS': {
            'driver': 'FreeTDS',
            'unicode_results': True,
            'host_is_server': True,
            'driver_supports_utf8': True,
            'extra_params': 'tds_version=7.4'
        },
    },
}
```

`Keep in mind that, the values assigned to the OPTIONS key, is necessary to make this image work.`

HAPPY CODING 😇
