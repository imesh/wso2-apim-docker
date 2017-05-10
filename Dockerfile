FROM docker.wso2.com/wso2am:2.1.0

COPY conf/ /mnt/wso2am-2.1.0/repository/conf/
COPY synapse-configs/default/api/ /mnt/wso2am-2.1.0/repository/deployment/server/synapse-configs/default/api/
COPY synapse-configs/default/sequences/ /mnt/wso2am-2.1.0/repository/deployment/server/synapse-configs/default/sequences/
