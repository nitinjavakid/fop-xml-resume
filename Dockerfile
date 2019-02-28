FROM ubuntu:18.04

RUN apt-get update && apt-get install -y fop xsltproc
ADD run.sh /
RUN chmod +x /run.sh
ADD format-fo.xsl /

ENTRYPOINT ["/run.sh"]
