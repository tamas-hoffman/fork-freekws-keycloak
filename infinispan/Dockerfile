FROM infinispan/server:11.0

ENV JAVA_OPTS="-Djgroups.ignore.bind_addr=true"

#Create a script that lets us run the command ./connect to connect to infinispan server easily.
RUN echo -e '#!/bin/bash\n/opt/infinispan/bin/cli.sh -c https://${POD_IP}:11222 --trustall' > connect
RUN chmod 775 connect

CMD ["sh", "-c", "./bin/server.sh -c /etc/config/infinispan.xml" ]