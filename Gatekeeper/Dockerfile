  
FROM google/cloud-sdk:232.0.0

ADD ./entrypoint.sh entrypoint.sh
COPY ./cloudInfra-golang-gatekeeper-client_1.0.0-alpha_Linux_x86_64.tar.gz cloudInfra-golang-gatekeeper-client
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
