FROM 88413075412.dkr.ecr.eu-west-2.amazonaws.com/geo/tomcat85-with-status

#
# Set GeoServer version and data directory 
#
ENV GEOSERVER_VERSION=2.13.0
ENV GEOSERVER_DATA_DIR="/geoserver_data"

#
# Additional Java settings to provide Geoserver with more memory
#
ENV JAVA_OPTS -Xms256m -Xmx512m

#
# Additional components needed to install geo server
#
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget 

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
    && mkdir geoserver \
    && cd geoserver \
    && unzip -q ../_tmp/geoserver.war \
    && rm -rf data \
    && cd .. \
    && rm -rf _tmp \
    && mkdir $GEOSERVER_DATA_DIR

