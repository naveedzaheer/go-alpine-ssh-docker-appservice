#!/bin/bash


echo "Starting SSH ..."
service sshd start

echo "Starting Go ..."
go-wrapper run

