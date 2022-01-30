---
title: "Readme as an example document"
author: "Mika Rautio"
date: "06.02.2021"
year: "2021"
lang: en-GB
orientation: "Business Information Technology 'n' stuff"
hhtemplatetype: "long" # "short" and "thesis" supported also
course: "ICT1TA001-1234 Orientaatio parempiin tekstinkäsittelyratkaisuihin"
abstract: "Here's some abstract text.\\par Let's see how it ends up..."
hhdocumentkeywords:
- LaTeX
- Markdown
- pandoc
- Haaga-Helia
- report templates
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
  accessed:
    year: 2021
    month: 02
    day: 06

---

# Haaga-Helia pandoc/LaTeX document templates

![Build and test status](https://github.com/mrautio/hh-templates/workflows/CI/badge.svg){#fig:id}

This project's aim is to provide common [Haaga-Helia University of Applied Sciences](https://www.haaga-helia.fi/en) Microsoft Word document templates as [pandoc](https://pandoc.org/) LaTeX templates so that reports may be written in Markdown or LaTeX formats instead of Microsoft Office. At least the author prefers to do school assignments over processes and tools just like in the good ol' agile manifesto [@agilemanifesto2001]!

![Haaga-Helia University of Applied Sciences report logo](media/hhreportlogo.png){#fig:id}

## Supported templates

Templates are intended to be as close to original templates as possible. Feel free to contribute with formatting improvements.

### Supported languages

Variable (in Markdown file YAML header): lang

* Finnish: fi-FI
* English: en-GB

### Supported templates

Variable: hhtemplatetype

* Short (SFS 2487) report template: [short](https://github.com/mrautio/hh-templates/blob/main/examples/README_short_english.pdf)
* Long report template: [long](https://github.com/mrautio/hh-templates/blob/main/examples/README_long_english.pdf)
* Thesis template: [thesis](https://github.com/mrautio/hh-templates/blob/main/examples/README_thesis_english.pdf)

### Arial font support

Haaga-Helia templates use Arial as the default font. It is a Microsoft proprietary font and not commonly available outside Windows and Office systems.

Docker image does not have Arial font installed. FreeSans is used as Docker image default font instead of Arial.
If you need Arial font outside Windows then at least Debian/Ubuntu has the font available in the package 'ttf-mscorefonts-installer'.

## Usage

This README file is an example that can be rendered to Haaga-Helia document template PDF, check the [raw file contents](https://github.com/mrautio/hh-templates/raw/main/README.md) for details.

### Markdown to PDF with Docker

Convert report Markdown to a PDF that is using the long report template format:
```sh
docker run --rm --volume host-path-to-report-data:/report --tty mrautio/hh-templates --output /report/report.pdf /report/report.md --variable=hhtemplatetype:long
```

Convert report Markdown and attachments Markdown file to a PDF that is using the long report template format:
```sh
docker run --rm --volume host-path-to-report-data:/report --tty mrautio/hh-templates --output /report/report.pdf /report/report.md /appdata/references.md /report/attachments.md --variable=hhtemplatetype:long
```

### More secure Markdown to PDF with Docker

In general the container image is attempted to be kept up-to-date and relatively secure. Unfortunately LaTeX and related components require extensive amounts of dependencies. To decrease risk to your data, you may sandbox the container operations further by disabling networking and using read-only volumes.

- `--network none` disables network access. Container does not require networking unless you refer to Internet resources (like Internet URLs for images) in your input documents. 

- Read-only volumes with `:ro` suffix ensure that the container can only read the volume data, not write to it. Container does not require write access to mount volume with the report data. However this requires reports to be written to STDOUT or another write accessible volume mount. Direct use of PowerShell should be avoided as [it corrupts the STDOUT data](https://docs.microsoft.com/en-us/archive/blogs/sergey_babkins_blog/un-messing-unicode-in-powershell). Output to STDOUT may hide potential document conversion errors.

```sh
docker run --rm --network none --volume host-path-to-report-data:/report:ro --attach stdout mrautio/hh-templates --to=pdf --output - /report/report.md > report.pdf
```

You can use [cosign](https://github.com/sigstore/cosign) to validate the container image release authenticity.

```sh
cosign verify --key cosign.pub mrautio/hh-templates
```

### Markdown to PDF with pandoc

Note: Filters are not mandatory but some features depend on them

```sh
pandoc --from markdown --template hhtemplate.tex --filter pandoc-tablenos --filter pandoc-fignos --filter pandoc-citeproc --filter pandoc-plantuml --pdf-engine=xelatex --listings --csl=https://www.zotero.org/styles/haaga-helia-university-of-applied-sciences-harvard -o report.pdf report.md --variable=hhtemplatetype:long
```

## Report functionality

Here you can find some examples beyond this README that illustrate how to format a report.

### Figures and tables

* [Example](https://raw.githubusercontent.com/mrautio/hh-templates/main/test/cases/05_tables/README.md) of adding a table and referring to it
* [Example](https://raw.githubusercontent.com/mrautio/hh-templates/main/test/cases/04_figures/README.md) of adding a figure and referring to it

### References

References are included in the YAML header of the document. See the [example](https://raw.githubusercontent.com/mrautio/hh-templates/main/test/cases/03_references/README.md) of various references and citations. References will be by default printed in the end of the document. Add a blank `# References` chapter or include `/appdata/references.md` file in the conversion command.

### Attachments

Attachments are created in a separate Markdown file. See [attachments.md](https://github.com/mrautio/hh-templates/blob/main/attachments.md) for an example.

## Haaga-Helia reference Citation Style Language (CSL) configuration

Haaga-Helia reference style CSL configuration is available from [https://www.zotero.org/styles/haaga-helia-university-of-applied-sciences-harvard](https://www.zotero.org/styles/haaga-helia-university-of-applied-sciences-harvard). You can use the style with CSL supporting reference management software like Papers, RefWorks or Zotero. Check the [contributing guide](https://github.com/citation-style-language/styles/blob/master/CONTRIBUTING.md), if you want to improve the style.

## License

Templates/code/examples are released as public domain. Any **graphical assets** or other school's IPR belong to their corresponding copyright holders and are not covered by repository's license agreement.

