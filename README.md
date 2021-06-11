# Hello-App

## Execution

Hello-App requires [Docker](https://docs.docker.com/get-docker/), [kubectl](https://kubernetes.io/docs/tasks/tools/) to run.

The project can be executed by the script provided. The executable can run in two modes: `Deploy`and `Release`. The Deploy mode will be considered as a first time installation while Release mode will be for iterative restart of the pods for any reason such as updates etc.

* It accepts command line flags for Database connectivity: `host` and `username` and checks the password as `DB_PASSWORD` in the environment variables. If not set, script will prompt for a password and if it is invalid (blank), the script will exit. 

```sh
bash execute.sh -m deploy -u user -h hostname
```

* The script expects docker and kubectl to be installed on the system and kubectl should have a valid config set in `~/.kube/config`. 
* Database will require a mounted volume at the path `/data/db`. The script will create the path if it does not exist/ Any external volume to be mounted should be done at this path. 
* The running app will be available at http://<host-address>:30007