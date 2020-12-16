#!/bin/bash


echo "Starting SSH ..."
/usr/sbin/sshd

echo "Starting Go ..."
go-wrapper run

