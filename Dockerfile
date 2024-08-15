FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean

#RUN rm /var/www/html/index.html

COPY index.html /var/www/html/index.html

COPY jonatan-pie-3l3RwQdHRHg-unsplash.jpg /var/www/html/jonatan-pie-3l3RwQdHRHg-unsplash.jpg

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
