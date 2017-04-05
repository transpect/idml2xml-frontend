<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:idml2xml="http://transpect.io/idml2xml"
  version="1.0">
  
  <p:documentation>
    Frontend pipeline which implements the idml2xml library. 
    This step takes an IDML file from InDesign and transform it 
    to Hub XML.
  </p:documentation>
  
  <p:output port="result"/>
  
  <p:option name="idml"/>
  <p:option name="debug" select="'no'"/>
  <p:option name="debug-dir-uri" select="'yes'"/>
  <p:option name="status-dir-uri" select="'status'"/>
  
  <p:import href="http://transpect.io/idml2xml/xpl/idml2hub.xpl"/>
  
  <idml2xml:hub name="idml2xml">
    <p:with-option name="idmlfile" select="$idml"/>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
  </idml2xml:hub>
  
</p:declare-step>