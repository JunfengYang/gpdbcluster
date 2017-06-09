## Deploy GPDB cluster using docker-compose

Using docker-compose to deploy GPDB cluster. It's easy to config and deploy.

#### Instructions
Make sure docker and docker-compose installed.

* |-DockerfileMaster (The docker file to build the GPDB master host image. **Note:** Need to set correct GPDB binary version and binary name)
* |-DockerfileSegHost (The docker file to build the GPDB segment host image)
* |-configs
	* |-90-nproc.conf.add (nporc cinfig)
	* |-limits.conf.add (limits config)
	* |-sysctl.conf.add (sysctl config)
	* |-ssh_config (ssh config)
	* |-env_setting (will write into ~/.bashrc)
	* |-**GPDB_BINARY_TAR_GZ** (Please put GPDB binary tar.gz here)
	* |-**id_rsa and id_rsa.pub** (Please generate ssh key here)
* |-scripts
	* |-gpdb-hosts (A file contains hosts to install GPDB segments)
	* |-gpinitsystem_config (gpinitsystem config file)
	* |-install-gpdb.sh (For master host, to install GPDB cluster, **Note:** Please set correct env path taht located in container)
	* |-ssh-start.sh (For segment hosts, start ssh service)
	* |-wait-for-it.sh (**Note:** Please get from https://github.com/vishnubob/wait-for-it)
* |-docker-compose.yml (The config for docker-compose)

#### docker-compose.yml
First of all, set correct path for all commands and volumes.
If you want to add more segment hosts, just copy sdw2 setting and rename it.
Then add hostname in the scripts/gpdb-hosts.

Start all services:
```bash
docker-compose up
```
or start in background
```bash
docker-compose up -d
```

Use ```Ctrl + c``` to stop services or
```bash
docker-compose stop
```

To login GPDB master host
```bash
docker exec -it MASTER_HOST_CONTAINER_NAME bash
```
Then change to 'gpadmin'.
```bash
su gpadmin
gpstate
```

You can restart the stop services by running
```bash
docker-compose up [-d]
```
