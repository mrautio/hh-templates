FROM hh-templates:latest

USER root

RUN apt-get update && apt-get install -y imagemagick \
  # Allow PDF handling
  && sed -i 's/<policy.\+"PDF"\s*\/>//g' /etc/ImageMagick-6/policy.xml

WORKDIR /appdata
COPY test.sh .
COPY cases cases

RUN chown -R appuser:appuser test.sh cases 
USER appuser

ENTRYPOINT [ "./test.sh" ]
