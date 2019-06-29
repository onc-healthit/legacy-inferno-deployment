This directory contains a self-signed certificate to enable TLS access to a copy running at https://localhost/ for development purposes.  It is not required unless you would like to view the site through TLS.

By default, `docker-compose.yml` maps nginx's certification location to:
```
/etc/ssl/certs/inferno
```

To enable access to `https://localhost`, you will either need to provide an `inferno.key` and `inferno.crt` file in `/etc/ssl/certs/inferno`, or you can use the self-signed certificate located in this directory.  To do so, comment out this line in docker-compose:
```
 - /etc/ssl/certs/inferno:/etc/ssl/certs/inferno:ro
```
and uncomment out the following line:
```
# - ./nginx/development-certs:/etc/ssl/certs/inferno:ro
```

You can then view the site on https://localhost, though your browser will likely warn you that the TLS certiifcate is self-signed.

Be careful to not commit these changes to `docker-compose.yml`.

To regenerate a certificate valid for one year, run the following command:
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout inferno.key -out inferno.crt -config localhost.conf
```


This is not suitable for a production deployment and should only be used to test the site using TLS on a development machine.