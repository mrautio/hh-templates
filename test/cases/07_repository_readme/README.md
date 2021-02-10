---
title: "Readme as an example document"
author: "Mika Rautio"
date: "06.02.2021"
year: "2021"
orientation: "Business Information Technology 'n' stuff"
hhtemplatetype: "long" # "short" and "thesis" supported also
course: "ICT1TA001-1234 Orientaatio parempiin tekstinkäsittelyratkaisuihin"
abstract: "Here's some abstract text.\\par Let's see how it ends up..."
glossaries:
- name: PDF
  description: Portable Document Format
- name: MD
  description: Markdown
references:
- id: agilemanifesto2001
  title: Manifesto for Agile Software Development
  issued:
    year: 2001
  author:
  - family: Beck
    given: Kent
  - family: Beedle
    given: Mike
  - family: van Bennekum
    given: Arie
  - family: Cockburn
    given: Alistair
  - family: Cunningham
    given: Ward
  - family: Fowler
    given: Martin
  type: webpage
  URL: 'https://agilemanifesto.org/'
  accessed: "2021-02-06"

---

# Haaga-Helia pandoc/LaTeX document templates

This project's aim is to provide common [Haaga-Helia University of Applied Sciences](https://www.haaga-helia.fi/en) Microsoft Word document templates as [pandoc](https://pandoc.org/) LaTeX templates so that reports may be written in Markdown or LaTeX formats instead of Microsoft Office. At least the author prefers to do school assignments over processes and tools just like in the good ol' agile manifesto [@agilemanifesto2001]!

![Haaga-Helia University of Applied Sciences report logo](../../../media/hhreportlogo.png){#fig:id}

## Supported templates

Templates are intended to be as close to original templates as possible. However, templates are still work-in-progress and not 100 % accurate. Feel free to contribute with formatting improvements.

### Supported languages

* Finnish
* English

### Supported templates

* Short report template
* Long report template
* Thesis template

### Arial font support

Haaga-Helia templates use Arial as the default font. It is a Microsoft proprietary font and not commonly available outside Windows and Office systems.

Docker image does not have Arial font installed. FreeSans is used as Docker image default font instead of Arial.
If you need Arial font outside Windows then at least Debian/Ubuntu has the font available in the package 'ttf-mscorefonts-installer'.

## Usage

This README file is an example that can be rendered to Haaga-Helia document template PDF, check the [raw file contents](https://github.com/mrautio/hh-templates/raw/main/README.md) for details.

### Markdown to PDF with Docker

```sh
docker build -t hhtemplate -f Dockerfile .
docker run --rm -v host-path-to-report-data:/report -t hhtemplate -o /report/report.pdf /report/report.md
```

### Markdown to PDF with pandoc

```sh
pandoc --from markdown --template hhtemplate.tex --filter pandoc-fignos --filter pandoc-citeproc --pdf-engine=xelatex --listings -o report.pdf report.md
```

## License

Templates/code/examples are released as public domain. Any **graphical assets** or other school's IPR belong to their corresponding copyright holders and are not covered by repository's license agreement.

# References
