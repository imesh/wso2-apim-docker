# WSO2 API Manager Dockerfile

This git repository provides a Dockerfile for configuring WSO2 API Manager with custom configurations. Currently placeholders for following configurations have been added:

## Configurations:

- Hostname
  
  ````
  repository/conf/carbon.xml
  <!--
    Host name or IP address of the machine hosting this server
    e.g. www.wso2.org, 192.168.1.10
    This is will become part of the End Point Reference of the
    services deployed on this server instance.
  -->
  <HostName>{load-balancer-hostname}</HostName>
  ````

- Management Hostname

  ````
  repository/conf/carbon.xml
  <!--
    Host name to be used for the Carbon management console
    -->
  <MgtHostName>{load-balancer-hostname}</MgtHostName>
  ````

- API Publisher URL

  ````
  repository/conf/api-manager.xml
  <APIPublisher>
     ...
     <URL>https://{load-balancer-hostname}:{load-balancer-https-port}/publisher</URL>
     ...
  </APIPublisher>
  ````

- API Store URL

  ````
  repository/conf/api-manager.xml
  <APIStore>
     ...
     <URL>https://{load-balancer-hostname}:{load-balancer-https-port}/store</URL>
     ...
  </APIStore>
  ````

- API Gateway URL

  ````
  repository/conf/api-manager.xml
  <Environments>
     <Environment type="hybrid" api-console="true">
        ...
        <!-- Endpoint URLs for the APIs hosted in this API gateway.-->
        <GatewayEndpoint>http://{load-balancer-hostname}:{load-balancer-http-port},https://{load-balancer-hostname}:{load-balancer-https-port}</GatewayEndpoint>
     </Environment>
  </Environments>
  ````

## System APIs

This repository has also included following APIs for the below mentioned reasons:

- Publisher API
  
  Exposes API Publisher UI via the API Gateway.

- Store API

  Exposes API Store UI via the API Gateway.

- Registry API 

  Exposes Carbon Registry API via the API Gateway. This has been used by the PizzaShack API sample for fetching images.

- Echo API

  This echo API can be used for implementing health checks for the API gateway:

  ````bash
  > GET /echo/WSO2 HTTP/1.1
  > Host: 192.168.1.2:8280
  > User-Agent: curl/7.49.1
  > Accept: */*
  >
  < HTTP/1.1 200 OK
  < Host: 192.168.1.2:8280
  < Content-Type: application/json
  < Accept: */*
  < Date: Fri, 28 Oct 2016 04:52:26 GMT
  < Server: WSO2-PassThrough-HTTP
  < Transfer-Encoding: chunked
  <
  * Connection #0 to host 192.168.1.2 left intact
  {"response":{"hello":"WSO2","server-ip":"192.168.1.2"}}
  ````

## How to build

- Set load balancer hostname, http port and https ports in the carbon.xml and api-manager.xml files found in the conf folder. These can be found by searching for the following placeholders:

  ````
  {load-balancer-hostname}
  {load-balancer-http-port}
  {load-balancer-https-port}
  ````
- Execute the build.sh:

  ````
  ./build.sh
  ````

- Tag Docker image as required:

  ````
  docker tag wso2am-with-config:2.1.0 [docker-registry-hostname]/[docker-repository-name]:[version]
  ````

- Push Docker image to the Docker registry:

  ````
  docker push [docker-registry-hostname]/[docker-repository-name]:[version]
  ````

## License

Licensed under Apache 2.0