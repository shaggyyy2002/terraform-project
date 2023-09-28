# Pre-Week (Week 0)

## Terraform Installation using bash scripting
To install terraform automatically we are using bash scripts which we are going to create throughout the bootcamp. 
[Install terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

**Bash file:** 
``` source ./bin/install-terraform-cli/sh ```


## Semantic Versioning
In this bootcamp we are using semantic versioning. If you're unsure what it is check the below link on how it works.
Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when you make incompatible API changes
2. MINOR version when you add functionality in a backward-compatible manner
3. PATCH version when you make backward compatible bug fixes <br>

Read the Article here: [Semantic Versioning](https://semver.org/#summary). 

## Install the Terraform CLI
- The issue we were facing before: Terraform CLI gpg keyring changes. So needed to refer the latest CLI installation and change how we download the Terraform CLI in gitpod. We have also changed `gitpod.yml` file on how to download the Teraaform CLI and linked it with a bash file in the `/bin` folder in the root directory.   
- To install it locally you can refer the [Installation Manual](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

1. Packages to verify HashiCorp's GPG signature and install HashiCorp's Debian package repository.
```!bash
 sudo apt-get update && sudo apt-get install -y gnupg software-properties-common 
 ```
2. Install the HashiCorp GPG key.
```!bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```
3. Verify the key's fingerprint.
```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```
4. Verify Installation 
```
terraform -help
```


## Environment Variables
 