# Environment Setup 

## Recommended Environment
1. Master Node
    1. OS: RHEL8.5
    1. Memory: 2GB
    1. Ansible version 2.9 
1. Cloned Virtual Machines
    1. OS: CentOS Stream 8.5
    1. Memory: 1GB
    1. Quantity: 3x (or more)

## Install and configure Ansible Control Node 
Install required packages
To be able to run Ansible, some packages are required:
- OpenSSH-Server (should be installed by default)
- Python3 (should be installed by default)
- Ansible-Engine

**Installing Ansible-Engine on RHEL 8.5**

*🖥️ at the prompt:*
```
# these 3 commands maybe take a while to run 
sudo subscription-manager repos | grep -i ansible-2.9
sudo subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms
sudo dnf install ansible -y 

### Version check
ansible --version
ansible 2.9.27
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/ansible/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.6/site-packages/ansible
  executable location = /bin/ansible
  python version = 3.6.8 (default, Sep  9 2021, 07:49:02) [GCC 8.5.0 20210514 (Red Hat 8.5.0-3)]
``` 

## Configure Ansible User with Sudo Access on Managed Node 
1. On each node include the master node create an ansible user. 
    `sudo useradd ansible`
    `sudo passwd ansible` 
1. Create an ssh key on the master node and copy it to the managed nodes. Go through the defaults in the prompt by hitting 'enter'. No need to create a passphrase. 
    1. On the master note: `ssh-keygen` 
    1. Copy the key to managed nodes (provide node password): `ssh-copy-id ansible@nodename` 
1. Verify access through an ad hoc ping

    ```
    ansible all -m ping
    # Successful Output
    node1 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/libexec/platform-python"
        },
        "changed": false,
        "ping": "pong"
    }
    node3 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/libexec/platform-python"
        },
        "changed": false,
        "ping": "pong"
    }
    node2 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/libexec/platform-python"
        },
        "changed": false,
        "ping": "pong"
    }
    ``` 

## Configure Vim for YAML Indenting and Vim Caching 
This setup purely optional, but may improve your speed while taking the exam. YAML does not accept tabs, instead use 2 spaces. The best way to simplify this is to setup tabstops in your `~/.vimrc` file to make this automatic. 

*📃 ~/.vimrc* 
```autocmd FileType yaml setlocal ai ts=2 sw=2 et
set undofile 
set undodir="~/.vim/undo" 
```
Make sure to create the undo directory. 

*🖥️ at the prompt:* `mkdir -p ~/.vim/undo` 

### Alternative `.vimrc` Options 
- If you find the `autocmd` hard to remember you could specify instead: 
`set tabstop=2 softtabstop=2` 

- Ansible often gives line numbers in errors, so seeing them at a glance can help:
`set number` will enable line numbers in files you're working on. 