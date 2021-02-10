FROM hhtemplate:latest

RUN apt-get update && apt-get install -y imagemagick \
  # Allow PDF handling
  && sed -i 's/<policy.\+"PDF"\s*\/>//g' /etc/ImageMagick-6/policy.xml

WORKDIR /tmp

ADD test.sh .
ADD cases cases

ENTRYPOINT [ "/bin/bash", "./test.sh" ]
