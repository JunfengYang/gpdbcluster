#!/usr/bin/env bash
#   Use this script to test if a given TCP host/port are available

set -euxo pipefail

GPDB_ENV_PATH=""
GPTEXT_ENV_PATH=""
SCRIPTS_PATH=""
GPTEXT_PACKAGE_PATH=""

main() {
	service sshd start
	if [ -d "/data/master/gpseg-1" ]; then
		su gpadmin -l -c "source $GPDB_ENV_PATH; gpstart -a; exit 0"
	else
		chmod 777 $SCRIPTS_PATH/gpinitsystem_config
		su gpadmin -l -c "source $GPDB_ENV_PATH; gpseginstall -f $SCRIPTS_PATH/gpdb-hosts -u gpadmin -p pivotal; exit 0"
		su gpadmin -l -c "source $GPDB_ENV_PATH; gpinitsystem -a -c $SCRIPTS_PATH/gpinitsystem_config -h $SCRIPTS_PATH/gpdb-hosts; exit 0"
		echo "host all all 0.0.0.0/0 trust" >> /data/master/gpseg-1/pg_hba.conf
		su gpadmin -l -c "export MASTER_DATA_DIRECTORY=/data/master/gpseg-1; source $GPDB_ENV_PATH; psql -d template1 -c \"alter user gpadmin password 'pivotal'\"; createdb gpadmin; createdb demo; exit 0"
		su gpadmin -l -c "source $GPDB_ENV_PATH; gpstop -ar; exit 0"
	fi
	bash
}

main "$@"
