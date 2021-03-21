FROM hh-templates:latest

RUN apt-get update && apt-get install -y imagemagick \
  # Allow PDF handling
  && sed -i 's/<policy.\+"PDF"\s*\/>//g' /etc/ImageMagick-6/policy.xml

WORKDIR /tmp

COPY test.sh .
COPY cases cases

ENTRYPOINT [ "./test.sh" ]
