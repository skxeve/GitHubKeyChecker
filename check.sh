#!/bin/bash

user_name=$1
if [ "${user_name}" == "" ]; then
    echo "Please specify username on GitHub"
    exit 1
fi

keys=/tmp/github_${user_name}.keys
curl https://github.com/${user_name}.keys -o ${keys} -# -L -Ss
if [ $? -ne 0 ]; then
    exit 1
fi

n=1
cat ${keys} | while read line
do
    key=/tmp/github_${user_name}.key$((n++))
    echo ${line} > ${key}
    ssh-keygen -lf ${key}
done
