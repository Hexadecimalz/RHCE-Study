# Session 1

## Understand Core Components of Ansible 

### Inventories 
Ansible works against multiple managed nodes or “hosts” in your infrastructure at the same time, using a list or group of lists known as inventory. Once your inventory is defined, you use patterns to select the hosts or groups you want Ansible to run against.

An inventory can be specified manually in a file that you create, or using the default inventory located in `/etc/ansible/hosts`. 

**Example Inventory**
```
[groupname]
nodename
nodename

[groupname2]
nodename
nodename

[biggergroup_name:children]
groupname
groupname2
```

**👁️‍🗨 Inventory at a Glance**

*🖥️ at the prompt:*
```
ansible-inventory --graph
# Result
@all:
  |--@centos:
  |  |--node1
  |  |--node2
  |  |--node3
  |--@localhost:
  |  |--127.0.0.1
  |--@ungrouped:
```  

### Modules 
Ansible works against multiple managed nodes or “hosts” in your infrastructure at the same time, using a list or group of lists known as inventory. Once your inventory is defined, you use patterns to select the hosts or groups you want Ansible to run against.

**Example Module use in ad-hoc commands**
```
ansible <host(s)> -m <module> -a <module_options>

ansible all -m ping
ansible all -m user -a "name=bob state=present"
ansible dev -m shell -a "echo 'Hello world'"

ansible all -m command -a "cat /etc/hostname" 
```

### Variables 
Ansible uses variables to manage differences between systems. With Ansible, you can execute tasks and playbooks on multiple different systems with a single command. To represent the variations among those different systems, you can create variables with standard YAML syntax, including lists and dictionaries. You can define these variables in your playbooks, in your inventory, in re-usable files or roles, or at the command line. You can also create variables during a playbook run by registering the return value or values of a task as a new variable.

See also: [Ansible Special Variables](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html). Check the Ansible Special Variables page for information on variables names that are reserved by Ansible, and may not be used in your playbook. 

**Playbook with variables specified in the file**

*📃 playbook.yml* 
```
vars: 
  - username: Daniel 
  - shell: /bin/bash   
```

*🖥️ at the prompt:* `ansible-playbook playbook.yml`

**Specify variables while running the playbook**
You may use the options `--extra-vars` or `-e` 

*📃 playbook.yml* 
```
vars: 
  - username: "{{ myuser }}"
  - shell: "{{ usershell }}"
```

*🖥️ at the prompt:* 
`ansible-playbook playbook.yml --extra-vars "username=Bob" -e "usershell=/bin/zsh"`

### Facts
With Ansible you can retrieve or discover certain variables containing information about your remote systems or about Ansible itself. Variables related to remote systems are called facts. With facts, you can use the behavior or state of one system as configuration on other systems. For example, you can use the IP address of one system as a configuration value on another system. Variables related to Ansible are called magic variables.

*🖥️ at the prompt:* 
```
ansible <hostname> -m ansible.builtin.setup 
ansible <hostname> -m ansible.builtin.setup -a "filter=ansible_local"

# or you can just run setup for short

ansible <hostname> -m setup 

# find free memory if you don't know the keyword
ansible all -m setup | grep -A5 "memory" 
ansible all -m setup -a "filter=ansible_memory_mb"
```

### Plays & Playbooks 
An Ansible Play is a script or an instruction that defines a tasks to be carried out on a managed node. A collection of plays constitutes a playbook. Ansible Playbooks offer a repeatable, re-usable, simple configuration management and multi-machine deployment system, one that is well suited to deploying complex applications. If you need to execute a task with Ansible more than once, write a playbook and put it under source control.

*📃 playbook.yml* 
```
---
- name: Playbook with multiple plays 
  hosts: webservers
  remote_user: root

  tasks: 
  - name: Singular Play
    ansible.builtin.yum:
      name: httpd
      state: latest
  - name: Singular Play
    ansible.builtin.template: 
      src: /src/httpd.j2
      dest: /etc/httpd.conf 
```
You may also simply specify `template` and `yum` when running these plays, rather than `ansible.builtin.template` 

### Configuration Files 
Certain settings in Ansible are adjustable via a configuration file (ansible.cfg). The stock configuration should be sufficient for most users, but there may be reasons you would want to change them. For example, if you have different settings across clusters, or want to modify users, or change parallelism settings (forks). Your default configuration file is located in `/etc/ansible/ansible.cfg`. Ansible will look for a configuration file in the local folder first before using the configuration file stored in `/etc` 

*📃 ~/myproject/ansible.cfg* 
```
[defaults]
inventory = hosts
roles_path = roles
forks = 10

[privilege_escalation]
become = True
become_methopd = sudo
become_user = ansible
```

### Ansible Documentation 
- List all available modules: `ansible-doc -l` 
- Open module documentation: `ansible-doc <modulename>` 
- Show only the parameters used: `ansible-doc -s <modulename>` 

### 🍴 Manage parallelism
[Ansible Glossary: Forks/Parallelism](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html#term-Forks) 

*🖥️ at the prompt:* 
```
ansible all -m ping --forks 10
ansible all -m ping -f 10
```

*📃 ~/myproject/ansible.cfg* 
```
[defaults]
forks = 10
```