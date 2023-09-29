# Pre-Week (Week 0)

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

## Environment Variables  (Env Vars)
- In the terminal we can set using `export HELLO='world`
- In the terrminal we unset using `unset HELLO`
- We can set an env var temporarily when just running a command
```sh
HELLO='world' ./bin/print_message
```

- Within a bash script we can set env without writing export eg.
```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

### Printing Vars
We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars
- When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.
- If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

### Persisting Env Vars in Gitpod
We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.
```
gp env HELLO='world'
```
All future workspaces launched will set the env vars for all bash terminals opened in thoes workspaces.
You can also set en vars in the `.gitpod.yml` but this can only contain non-senstive env vars.

### Best Practise 
While working on a project its always a good practise to create an .env.example so when someone comes to this repository they know what Env Vars this project needs