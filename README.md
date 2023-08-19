# idml2xml

Converts InDesign IDML to XML. Based on the transpect module [idml2xml](https://github.com/transpect/idml2xml).

## Introduction

Considering this [hello world example](https://github.com/transpect/idml2xml-frontend/tree/master/sample), idml2xml will generate flat [Hub XML with CSSa XML attributes](http://publishinggeekly.com/wp-content/uploads/2013/01/CSSa.pdf). 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="http://www.le-tex.de/resource/schema/hub/1.2/hub.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="http://www.le-tex.de/resource/schema/hub/1.2/hub.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
<hub xmlns="http://docbook.org/ns/docbook" xmlns:css="http://www.w3.org/1996/css" xml:lang="de-DE-2006" version="5.1-variant le-tex_Hub-1.2"
  css:version="3.0-variant le-tex_Hub-1.2" css:rule-selection-attribute="role">
  <info>
    <keywordset role="hub">
      <!-- Hub format properties -->
    </keywordset>
    <css:rules>
      <css:rule name="myStyle" native-name="myStyle" layout-type="para" 
        css:color="device-cmyk(0,0,0,1)" css:font-weight="normal"
        css:font-style="normal" css:font-size="12pt" css:text-transform="none" 
        css:margin-left="0pt" css:margin-right="0pt" css:text-indent="0pt"
        xml:lang="de-DE-2006" css:hyphens="auto" css:margin-top="0pt" 
        css:margin-bottom="0pt" css:text-decoration-line="none"
        css:page-break-before="auto" css:text-align="left" css:direction="ltr" 
        css:font-family="Minion Pro"/>
    </css:rules>
  </info>
  <para role="myStyle">hello world</para>
</hub>
```

## Requirements

At least Java 1.7 is required.

## Clone this project

This project depends on Git submodules. Therefore you have to clone it with the `--recurse-submodules` option to get the submodules, too:

```
git clone https://github.com/transpect/idml2xml-frontend --recurse-submodules
```

## Invocation

### Bash

For convenient use on command line, we provide a simple Bash script. You can run it in this way:
```
./idml2xml.sh sample/hello-world.idml
```

### Calabash

We provide also Bash and Windows Batch scripts to invoke the XProc pipeline directly:

```
./calabash.sh -o result=sample/hello-world.xml xpl/idml2xml-frontend.xpl idml=sample/hello-world.idml
```

## Include idml2xml in your XProc project

Please refer to this [tutorial](http://transpect.github.io/getting-started.html) for a more extensive documentation.
