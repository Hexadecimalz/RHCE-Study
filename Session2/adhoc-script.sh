#!/bin/bash

hosts=$1

ansible $hosts -m user -a "name=testrhce state=present" --become

ansible $hosts -m copy -a "src=/etc/whatever dest=/home/ansible/whatever" --become