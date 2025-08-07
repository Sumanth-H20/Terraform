Provisioning AWS EC2 instance with Nginx using Terraform Scripts.

first laucj the ec2 instance with ubutu and follow below steps to install Terraform

update system packages
sudo apt update && sudo apt upgrade -y

download and addd the hashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

Add the HashiCorp Repository to your Sources List
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
 
update package list
sudo apt update
 
install terraform
sudo apt install terraform -y

verify installation
terraform --version


then install awscli 
sudo apt install awscli


now we need to configure for that cearting a new user where we need generate acccess key and secrete access key
once you create new IAM user -- navigate to create access key option and generate.

now run the command to configure
aws configure 

it will ask for access key and serete key provide them. - enter
