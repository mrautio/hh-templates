FROM debian:latest

RUN apt-get update \
  && apt-get install -y texlive-xetex texlive-latex-extra texlive-lang-english texlive-lang-european fonts-freefont-ttf librsvg2-bin pandoc pandoc-citeproc python3-pip \
  && pip3 install pandoc-fignos pandoc-tablenos

#to install Arial font: However Docker image will use FreeSans instead of proprietary Arial
#RUN apt-get install -y ttf-mscorefonts-installer

WORKDIR /tmp

COPY media/*.png ./media/
ADD https://www.zotero.org/styles/haaga-helia-university-of-applied-sciences-harvard ./haaga-helia-university-of-applied-sciences-harvard.csl
COPY hhtemplate.tex ./

ENTRYPOINT [ "pandoc", "--template=/tmp/hhtemplate.tex", "--filter=pandoc-tablenos", "--filter=pandoc-fignos", "--filter=pandoc-citeproc", "--pdf-engine=xelatex", "--listings", "--variable=hhreportlogopath:/tmp/media/hhreportlogo.png", "--variable=hhdocumentfont:FreeSans", "--csl=/tmp/haaga-helia-university-of-applied-sciences-harvard.csl" ]
