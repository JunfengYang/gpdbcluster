#!/usr/bin/env bash
#   Use this script to test if a given TCP host/port are available

set -euxo pipefail

main() {
	service sshd start
	bash
}

main "$@"
