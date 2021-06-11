#!/usr/bin/env bash

#Read command line flags
while getopts m:h:u: flag
do
  case "${flag}" in
    m) mode=${OPTARG}
    h) hostname=${OPTARG}
    u) user=${OPTARG}
  esac
done
#Check DB_PASSWORD as env variable
if [[ -z "${DB_PASSWORD}" ]]; then
  echo "Password not found as env variable. Please enter your password:"
  read DB_PASSWORD
  if [[ -n "$DB_PASSWORD" ]]; then
    password=$DB_PASSWORD
  else 
    echo "Password invalid. Exiting!"
    exit 1
else
  password="${DB_PASSWORD}"

if [[ $mode == "deploy" || $mode == "Deploy" ]]; then
  docker build -t hello-app .
  docker push hello-app:latest
  kubectl create secret generic hello-secret --from-literal="username=${user}" --from-literal="password=${DB_PASSWORD}" --from-literal="host=${hostname}"
  kubectl apply -f hello-deployment.yaml hello-service.yaml
  mkdir /data
  mkdir /data/db
  kubectl apply -f mongo-deployment.yaml mongo-service.yaml
elif [[ $mode == "release" || $mode == "Release" ]]; then
  docker build -t hello-app .
  docker push hello-app:latest
  kubectl rollout restart deployment/hello-app
  