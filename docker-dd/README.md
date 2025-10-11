# Docker DD

The Docker DD is a collection of the shell command to control the Docker much more simple than using original docker command. 

In many case of the using original docker commands, you need to obtain a something like the container ID in advance. 

You will not need them if you use the Docker DD

You will be able to execute a lot of complex docker command in the simple commands which begins with DD(for docker), DN(for docker network) or DV(for docker volume).

## Requirements

* [Docker](http://www.docker.com/)
* [peco](https://github.com/peco/peco)

## Getting started

STEP 1. Clone this repository. It doesn't care of a directory at local.

```
git clone https://github.com/nutsllc/docker-dd.git
```

STEP 2. Open your ``.bash_profile`` or ``.bashrc`` and add the following line of code:

```
source /path/to/docker-dd/docker-dd-common.fnc
source /path/to/docker-dd/docker-dd-network.fnc
source /path/to/docker-dd/docker-dd-volume.fnc
```

STEP 3. Restart shell.

## Usage

Run docker-dd command below in a shell.

### List of the Docker DD commands

| Docker DD | In case of docker command                                                             | Description                                                    |
|:--------- |:------------------------------------------------------------------------------------- |:-------------------------------------------------------------- |
| DD        | docker ps -a                                                                          | Show all containers                                            |
| DDimages  | docker images                                                                         | Show all images                                                |
| DDps      | docker ps                                                                             | Show running containers in default format                      |
| DDpsa     | docker ps -a                                                                          | Show all containers in default format                          |
| DDstart   | docker start \<container id>                                                          | start stopped container                                        |
| DDstop    | docker stop \<container id>                                                           | Stop running container                                         |
| DDstopa   | docker stop $(docker ps -q)                                                           | Stop all of running container                                  |
| DDrm      | docker rm \<container id>                                                             | Remove a container                                             |
| DDrma     | docker rm $(docker ps -aq)                                                            | Remove all of running containers                               |
| DDdown    | docker stop \<container id><br>docker rm \<container id>                              | Stop and remove running container                              |
| DDid      | docker inspect -f '{{.Id}}' \<container id>                                           | Show container id                                              |
| DDrmi     | docker rmi \<image id>                                                                | Remove image                                                   |
| DDrmia    | docker rmi $(docker images -q)                                                        | Remove all images                                              |
| DDnone    | docker rmi $(docker images \| awk '/^<none>/ { print $3 }')                           | Remove \<none> image                                           |
| DDidi     | docker inspect -f '{{.Id}}' \<image id>                                               | Show image id                                                  |
| DDbash    | docker exec -it \<container id> /bin/bash                                             | Go into container with /bin/bash                               |
| DDsh      | docker exec -it \<container id> /bin/sh                                               | Go into container with /bin/sh                                 |
| DDmysql   | docker exec -it \<container id> mysql -u root -proot                                  | Go into container with mysql -u root -proot                    |
| DDmongo   | docker exec -it \<container id> mongo -u root -p                                      | Go into container with mongo -u root -p                        |
| DDmyadmin | docker run -d -e PMA_HOST=\<container IP adress> -p 8080:80 phpmyadmin/phpmyadmin     | Run phpMyAdmin container and connect to your running container |
| DDstats   | docker status                                                                         | Display a live stream of container                             |
| DDtop     | docker top \<container id>                                                            | Display the running processes of a container                   |
| DDlogs    | docker logs \<container id>                                                           | Fetch the logs of a container                                  |
| DDhistory | docker history \<image id>                                                            | Show the history of an image                                   |
| DDinspect | docker inspect \<container id>                                                        | Return low-level information on a container                    |
| DDip      | docker inspect -f "{{.NetworkSettings.IPAddress}}" \<container id>                    | Show the IP Address of a container                             |
| DDvol     | docker                                                                                | List volumes of a container mounted                            |
| DDhosts   | docker exec -it \<container id> cat /etc/hosts                                        | Show the contents in /etc/hosts file                           |
| DDenv     | docker exec -it \<container id> env                                                   | List defined environment variables                             |
|           |                                                                                       |                                                                |
| DN        | docker network ls                                                                     | Show all networks                                              |
| DNrm      | docker network rm \<network id>                                                       | Remove a network                                               |
| DNinspect | docker network inspect \<network id>                                                  | Display detailed information on network                        |
| DNgateway | docker network inspect -f '{{range .IPAM.Config}} {{.Gateway}} {{end}}' \<network id> | Show the Gateway IPv4 Address of a network                     |
| DNsubnet  | docker network inspect -f '{{range .IPAM.Config}} {{.Subnet}} {{end}}' \<network id>  | Show the Subnet IPv4 Address of a network                      |
| DNnode    | docker network inspect -f '{{range .Containers}} {{.Name}} {{end}}'                   | List containers connected a network                            |
| DNid      | docker network inspect -f '{{.Id}}' \<network id>                                     | Show a network id                                              |
|           |                                                                                       |                                                                |
| DV        | docker volume ls                                                                      | Show all volumes                                               |
| DVrm      | docker volume rm \<volume name>                                                       | Remove a volume                                                |
| DVinspect | docker volume inspect \<volume name>                                                  | Display detailed information on volume                         |
| DVmp      | docker volume inspect -f "{{.Mountpoint}}" \<volume name>                             | Show the directory path stored real data                       |
| DVid      | docker volume inspect -f "{{.Name}}" \<volume name>                                   | Show a volume name                                             |

## License

* Docker - The Apache 2.0 Licence
* peco - The MIT Licence