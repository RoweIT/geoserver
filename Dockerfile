ARG AWS_ECR=
FROM ${AWS_ECR}geo/tomcat85-minimal

#
# Set GeoServer version and data directory 
#
ENV GEOSERVER_VERSION=2.14.0
ENV GEOSERVER_DATA_DIR="/geoserver_data"

#
# Additional Java settings to provide Geoserver with more memory
#
ENV JAVA_OPTS -Xms256m -Xmx512m

#
# Additional components needed to install geo server
#
RUN apk update && apk add wget && rm -rf /var/cache/apk/*
#
# Download and install GeoServer
# This will unpack the war and remove any sample data
# 
RUN cd $CATALINA_HOME/webapps \
    && mkdir _tmp \
    && cd _tmp \
    && wget --progress=bar:force:noscroll https://sourceforge.net/projects/geoserver/files/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-war.zip \
    && unzip -q geoserver-$GEOSERVER_VERSION-war.zip \
    && rm geoserver-$GEOSERVER_VERSION-war.zip \
    && cd .. \
    && mkdir ROOT \
    && cd ROOT \
    && unzip -q ../_tmp/geoserver.war \
    && rm -rf data \
    && cd .. \
    && rm -rf _tmp \
    && mkdir $GEOSERVER_DATA_DIR

