FROM debian
#FROM apache/nifi:1.6.0

RUN apt-get update && apt-get install -yy sudo wget curl unzip default-jdk

# Get kylo
RUN wget https://s3-us-west-2.amazonaws.com/kylo-io/releases/tar/0.9.1.1/kylo-0.9.1.1.tar
USER root
RUN mkdir -p /opt/kylo/setup/nifi && tar xvf kylo-*.tar -C /opt/kylo/ && rm -f kylo-*.tar

# Install spark
RUN mkdir -p /opt/spark
RUN wget http://apache.crihan.fr/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
RUN tar zxvf spark-2.3.1-bin-hadoop2.7.tgz -C /opt/spark && rm -f spark-2.3.1-bin-hadoop2.7.tgz
RUN ln -s /opt/spark/spark-2.3.1-bin-hadoop2.7 /opt/spark/current

# Manual installation - Step 7: Install Nifi - Option 2: Leverage an existing NiFi instance
# @See https://kylo.readthedocs.io/en/latest/installation/ManualDeploymentGuide.html#step-7-install-nifi

RUN useradd -r nifi
RUN /opt/kylo/setup/nifi/install-nifi.sh 1.6.0 /opt/nifi nifi nifi
RUN sed -i 's/SPARK_SUBMIT=.*/SPARK_SUBMIT=\/opt\/spark\/current\/bin\/spark-submit/' /opt/kylo/setup/nifi/create-symbolic-links.sh
RUN /opt/kylo/setup/nifi/install-kylo-components.sh /opt/nifi /opt/kylo/ nifi nifi

#RUN mkdir -p /opt/nifi/nifi-1.6.0/current/conf && mkdir -p /opt/nifi/nifi-1.6.0/current/lib
#RUN sed -i 's/jms.activemq.broker.url=.*/jms.activemq.broker.url=tcp:\/\/activemq:61616/' /opt/kylo/setup/nifi/config.properties
#RUN /opt/kylo/setup/nifi/install-kylo-components.sh /opt/nifi/nifi-1.6.0 /opt/kylo nifi nifi
#RUN mkdir -p /opt/nifi/nifi-1.6.0/activemq && cp /opt/kylo/setup/nifi/activemq/*.jar /opt/nifi/nifi-1.6.0/activemq && chown -R nifi:nifi /opt/nifi/nifi-1.6.0/activemq

# Clean up
#RUN rm -rf /opt/kylo

WORKDIR /opt/nifi
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh