# GKE assumptions
1. Unrestricted public endpoint - should not do this in production
2. Regular release channel
3. VPC already exists, along with subnetwork and it is called `wifi-lab-network`
4. Region to be used is northamrica
5. Regional cluster


# CloudSQL assumptions
1. Standard means: n1-standard-1
2. Regional DB in northamerica-northeast1
3. Private DB with service networking and encryption
4. Delete protection is enabled

# Cloud Memorystore assumptions
1. Private DB with service networking
2. Regional DB in northamerica-northeast1
3. BASIC mode
4. Encrypted with server authentication

# Bash commands to deploy the infrastructure

Assumptions:
Following tools are available (may have missed some common ones): gcloud, terraform, kubectl and mysql-client. Also, the host on which the commands are to be executed is on the same VPC as the CloudSQL instance.

Commands to deploy
```
# Login to gcloud, additional steps are required for this
gcloud auth application-default login
gcloud auth login

# Create infrastructure
terraform init
terraform plan -out sample
terraform apply sample

# Seed the SQL DB 
sudo apt-get install default-mysql-client
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy

INSTANCE_CONNECTION_NAME=$(gcloud sql instances describe mymymysql | grep connectionName | sed "s/connectionName: //g")
./cloud_sql_proxy -instances=$INSTANCE_CONNECTION_NAME=tcp:3306 -ip_address_types=PRIVATE &

PASSWORD=$(gcloud secrets versions access latest --secret="cloudsql_password" --format='get(payload.data)' | tr '_-' '/+' | base64 -d)
USER=cloudsql_default_password

mysql -u $USER -p$PASSWORD --host 127.0.0.1

# Inside mysql client
CREATE TABLE mysqldb.user( id int, last_name varchar(255), first_name varchar(255), email varchar(255) );

# Back to bash
gcloud container clusters get-credentials autopilot-cluster --region northamerica-northeast1 --project capstone-wifi-lab-f20f10
kubectl apply -f ./deployment/nginx.yaml -n default
```
# Notes
Created this for fun but ideally it would have more docs, inputs and outputs documented in readme for each document. 
I'd also have more abstractions to each module to make it highly configurable and reusable 
