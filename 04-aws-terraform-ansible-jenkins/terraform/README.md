## This project sets up a Jenkins server on a Digital Ocean droplet using Terraform

#### Credentials used by terraform to access Digital Ocean
Generate an API token on Digital Ocean and export it in the terminal where you run the terraform script.
```bash
export DIGITALOCEAN_TOKEN=<Your token>
```


#### ssh key pair and firewall rules for the droplet
This project sets up an ssh key pair and creates and assigns a firewall to the droplet. 
The ssh key path is set up as variable from the local machine.
The firewall rules include inbound ssh port 22 for your ip. 
It programmatically fetches your laptop ip from a script. (get_ip.sh)

#### Configuring the server 
Run the ansible script in the below repository after this to configure the server to install all the necessary tools
for this droplet to function as a jenkins server.
