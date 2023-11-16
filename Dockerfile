FROM httpd
RUN mkdir /usr/local/apache2/htdocs -p
COPY index.html /usr/local/apache2/htdocs

