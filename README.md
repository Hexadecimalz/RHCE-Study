# 🐧 RHCE-Study
Here are published notes for a private RHCE study group. You can find notes within the sub folders on this repo. This repository is not affiliated with RedHat in any way, it is an independent and private study project. 

## Recommended Environment
1. Master Node
    1. OS: RHEL8.5
    1. Memory: 2GB
    1. Ansible version 2.9 
1. Cloned Virtual Machines
    1. OS: CentOS Stream 8.5
    1. Memory: 1GB
    1. Quantity: 3x (or more)

You can obtain a free copy of Red Hat Enterprise Linux through a free developer account from RedHat for personal use. 
See: [Red Hat Developer Program](https://developers.redhat.com/about). After logging in select your profile icon at the top right and choose 'subscriptions' to manage your licenses. 

## Formatting Notes
Ansible relies on playbooks, which are files formatted in YAML, but those playbooks are run at the command line. 
In order to make it more clear which is which, we've tried to add the following indicators for files versus commands: 

- *📃 playbook.yml* = file with name and extension specified after (may also include a relative path)
- *🖥️ at the prompt:* = yup, you guessed it, run at the prompt 
- At certain points the disctinction should be obvious, so we'll omit this when it should be clear. 

## Contributing 
Contributions are welcome through a pull request or by submitting an issue. 

## Credits 
This repo is in collaboration with [TheCenturist](https://github.com/thecenturist).