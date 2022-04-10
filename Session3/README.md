# Session 3 

## ⚗ Variables 

> [Variables](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html#term-Vars-Variables) As opposed to Facts, variables are names of values (they can be simple scalar values – integers, booleans, strings) or complex ones (dictionaries/hashes, lists) that can be used in templates and playbooks. They are declared things, not things that are inferred from the remote system’s current state or nature (which is what Facts are).

For example, see [using_vars.yml](using_vars.yaml) in this file we have several different ways that you can see to declare a variable in your playbook. You can declare separate files for variables, or set separate variables directly within the playbook. In each case, the variable declarations are at the top of the file. It makes sense for variables to be declared at the top of the playbook, just like when coding, since the playbook cannot find the value of something before it is referenced. 

Another feature that Ansible allows are encrypted variables, which may include password or other sensitive data. In this example we have included [encrypted_vars.yaml](encrypted_vars.yaml) its password is `session123`. 

Some example runs of this playbook: 
`ansible-playbook session3/using_vars.yml --vault-password-file session3/decryption_pass.txt`

While we haven't covered Ansible Vault just yet, you can view the contents of the vault file using this command: `ansible-vault edit encrypted_vars.yml` and supply the password `session123` 

### 🔭 Other Variable locations 

- Variables can also be specified in the `group_vars` folder, which would be variables applied to groups in an inventory. 

- Variables can also be specified in the `host_vars` folder, which would be specific to certain hosts, such as variables used only for `node1` in your lab cluster. 

### 🔢 Variable Precedence 

Variables are not a static declaration and are subject to change based on precedence. 

Let's list from LEAST to MOST precedence. 

1. Variables supplied in the `host_vars` or `group_vars` folders are applied first. 
1. Variables stated in the `vars_files` section of your playbook. The last file in the declaration takes precedence.
1. Variables specified directly in the playbook.
1. Variables specified at the command line with the option `-e` or `--extra-vars` 


## Use Ansible Galaxy to Create Roles

1. `ansible-galaxy role init nameoftherole` 
1. `ansible-galaxy init --offline offlinerole` 

While we aren't covering roles extensively just yet, you should know that you need at a minimum the tasks, vars, and defaults directories at a minimum for your roles. You can also create this structure manually. 

## [Facts](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html#term-Facts)

Ansible by default collects details about nodes it connections to. These are details about the system, such as OS, IP, DNS, etc. Fact gathering can be turned on or off. In some case, it may be preferred to turn off fact gathering to speed up plays. 

- 🖥️ at the prompt: `ansible all -m setup -a "filter=ansible_cmdline"`
- 🖥️ at the prompt: `ansible all -m setup -a "filter=ansible_devices"`
- 🖥️ at the prompt: `ansible node2 -m setup -a "filter=ansible_all_ipv4_addresses"`
- 🖥️ at the prompt: `ansible node2 -m setup -a "filter=ansible_hostname"`

## [⏭ Conditionals](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html#term-When)

Like any good script a conditional will help you decide *if* or *when* you should carry out a task. Ansible helps us carry this out using when. Conditionals can be paired with facts to make them run only when conditions on are system are met, such as have a specific hostname, ip address, or storage device. 

See: [using_conditionals.yaml](using_conditionals.yaml)

*📃 conditionals.yml snippet*
```
- name: Print IP Address
  debug:
    msg: 
   when: ansible_default_ipv4.address == 192.168.1.35 and ansible_hostname "node1" 


- name: Still Print 
 debug:    
   msg: Still shows! 
  when: ansible_default_ipv4.address == " crap" or ansible_hostname == "node1" 
```

*📃 conditionals.yml*
```
--- 
- hosts: all

  tasks: 
    - name: Run a command 
      shell: echo "Hello World" 
      register: runout
       
    - name: Print some info 
      debug: 
      var: runout 
      when: "'World' in runout.stdout" 

    - name: Print out is Disk exists 
      debug: 
        msg: "Storage exists!" 
       when: ansible_deviced['sda'] is defined
```

You can also put each condition in its own parentheses (ansible_hostname == "x") and (ansible_user_dir == "other"). You can also supply multiple levels of parentheses to have nested conditionals. 

You can also try `when: "'World' not in runout.stdout"` 

## 📇 Using Facts in Templates 

See: [var_template.j2](./var_template.j2) 

Ansible is using Jinja2 Templates to make files with specific files and configurations that can be pulled from Ansible facts or variables. 

Needs more detail... 

## ⁉️ Error Handling 

Ansible has several modules to handle errors. Ansible by default will stop running a playbook on the *first* error that it finds, unless another error handling method is defined. 

See: [error_handling.yaml](error_handling.yaml)

To prevent Ansible from failing due to an error using `ignore_errors: true` during a play. You can also choose to `ignore_unreachable: true` if the host cannot be connected to. Another key option is to specify a maximum fail percentage with `max_fail_percentage: 40` 

Similarly, you can also tell Ansible what it should expect by giving it key information about failure with `failed_when` or `changed_when` 