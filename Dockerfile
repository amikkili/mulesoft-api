FROM centos
ENV MULE_HOME /opt/mule
ENV MULE_VERSION 3.9.4
# yum install JDK,Maven and MuleStandalone runtime
RUN yum update -y \

   && yum install -y java-1.8.0-openjdk-devel maven zip \
   && yum clean all -y \
   && cd /opt \
   && curl -k -o mule-3.9.4.zip http://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-3.9.4-hf1.zip  \
   && unzip mule-3.9.4.zip \
   && mv mule-enterprise-standalone-$MULE_VERSION-hf1 mule

# Copy application files
COPY ./target/*.zip $MULE_HOME/apps/
# EXPOSED Application Port
EXPOSE 8080
ENTRYPOINT /opt/mule/bin/mule
