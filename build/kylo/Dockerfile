FROM debian

RUN apt-get update && apt-get install -yy wget curl bash mysql-client sudo unzip procps default-jdk

# Get Kylo
RUN wget https://s3-us-west-2.amazonaws.com/kylo-io/releases/deb/0.9.1.1/kylo-0.9.1.1.deb
RUN useradd -r -G users kylo
RUN dpkg -i kylo-0.9.1.1.deb

# Install spark
RUN mkdir -p /opt/spark
RUN wget http://apache.crihan.fr/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
RUN tar zxvf spark-2.3.1-bin-hadoop2.7.tgz -C /opt/spark && rm -f spark-2.3.1-bin-hadoop2.7.tgz
RUN ln -s /opt/spark/spark-2.3.1-bin-hadoop2.7 /opt/spark/current

## Set entrypoint
WORKDIR /opt/kylo

COPY entrypoint*.sh /
RUN chmod +x /entrypoint*.sh

#ENTRYPOINT /entrypoint.sh