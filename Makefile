DATA_FILES:=data.xml
FO_FORMAT:=format-fo.xsl

all: clean resume.pdf resume.html

resume.pdf: temp.fo
	fop temp.fo $@

resume.html: temp.fo
	xsltproc --output $@ fo2html.xsl $<

temp.fo:
	xsltproc --output $@ ${FO_FORMAT} ${DATA_FILES}

clean:
	rm -f temp.fo
	rm -f resume.pdf
