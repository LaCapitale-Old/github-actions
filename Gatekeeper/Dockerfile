  
FROM google/cloud-sdk:232.0.0

COPY ./entrypoint.sh entrypoint.sh
ADD ./cloudInfra-golang-gatekeeper-client_1.0.0-alpha_Linux_x86_64.tar.gz .
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
