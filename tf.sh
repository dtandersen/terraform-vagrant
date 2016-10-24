#!/usr/bin/bash
if [[ -z "$2" ]]; then
	terraform
	exit 1
fi
if [[ ! -d ${@:$#} ]]; then
	echo "The directory '$2' doesn't exist."
	exit 1
fi

cd ${@:$#}
terraform ${*%${!#}}
cd ..
