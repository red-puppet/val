#!/bin/bash
read STD
if [[ -z "${STD// }" ]]
then
    echo "Value cannot be empty"
    exit 1
fi

    echo "Value passed must contain string 'PASS' or 'FAIL'"
    exit 1
