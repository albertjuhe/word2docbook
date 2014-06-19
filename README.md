word2docbook
============

Convert Word documents (docx) to XML docbook, usign XSLT 2.0 with [saxonhe9-2-1-5j](http://saxon.sourceforge.net/) and XMLPipeline with [calumet](https://community.emc.com/docs/DOC-4242).

##Installation

Download de code.
Install java 1.6.

##Usage

Execute word2docbook.bat wordfile, without extension.
The process will take the document from the input folder and it will store the xml docbook output in the output folder.

In the template folder there is a file with the conversion instructions, template.xml.

```xml
<t:template xmlns:t="http://www.omaonk.com/schema">
   <t:style word="heading 1" tag="chapter"/>
   <t:style word="heading 2" tag="sect1"/>
   <t:style word="heading 3" tag="sect2"/>
   <t:style word="List Paragraph" tag="listitem"/>
   <t:style word="heading 4" tag="sect3"/>
   <t:style word="heading 5" tag="sect4"/>
   <t:style word="heading 6" tag="example"/>
   <t:style word="Quote" tag="blockquote"/>
   <t:style word="Intense Quote" tag="important"/>
   <t:style word="Title" tag="title"/>
</t:template>
```
In this file you can find the rules conversions, for example if the docx document contains a heading 1 style, this is transformed to chapter. Tables, lists and inline elements (bold, underline, sub, sup, ...) are autodetected.

##Demo

In the input folder there is a test.docx document.
Execute: word2docbook.bat test
The output will be in the output folder in XML docbook format and with the document images.
