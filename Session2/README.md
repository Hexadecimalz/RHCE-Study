# Session 2

## Ansible Basics 

Using ad hoc commands will allow you to quickly manage a host using a variety of modules or commands you are already familiar with. 

It's important that you know how to find documentation about these modules, as well as required options that might explain why a command is failing. The documentation also serves as a quick copy-paste cheat sheet should you need it. 

The easiest way to view documentation is to type `ansible-doc MODULE` at the command line for example: 

```
# Get information about the yum module
ansible-doc yum
# Get info about the package module 
ansible-doc package
```

**Required Options**
```
# Add the -s option to show required options for a module
ansible-doc -s at
- name: Schedule the execution of a command or script file via the at command
  at:
      command:               # A command to be executed in the future.
      count:                 # (required) The count of units in the future to
                               execute the
                               command or script
                               file.
      script_file:           # An existing script file to be executed in the
                               future.
      state:                 # The state dictates if the command or script file
                               should be
                               evaluated as
                               present(added) or
                               absent(deleted).
      unique:                # If a matching job is present a new job will not
                               be added.
      units:                 # (required) The type of units in the future to
                               execute the
                               command or script
                               file.
```

**Escalating Privilege**
For ad hoc commands and playbooks it will often be necessary to specify that you want to escalate to root to perform the required action. This can be done in a few different ways: 

- In ad hoc commands specify the option: `-b` or `--become`
- In a playbook specify: `become: true` 

### Common Ansible Modules Using Ad Hoc commands 

Modules to be familiar with: 
- Service: Manage systemd services
- Firewalld: Manage Firewall rules using firewall-cmd
- Filesystem: Create or Remove filesystem on a volume
- Parted: Create or Remove a partition on a disk
- File: Manage files, create, delete, etc
- Lineinfile: Manage lines in a file
- Copy: Copy files to managed nodes
- Archive / Unarchive: Compress files using tar, gzip2, bzip
- At & Cron: Manage scheduled tasks
- User: Manage users
- Group: Manage users
- Hostname: Change a managed node's hostname

### Ad Hoc Command Examples 

In this section all commands are run *🖥️ at the prompt*

In the following commands we achieve a lot quickly by installing a package, enabling the service, and finally allowing it through the firewall. 
- `ansible node1 -m package -b -a "name=httpd state=latest"` 
- `ansible node1 -m service -a "name=httpd state=started"` 
- `ansible node1 -m firewalld -a "service=http state=enabled permanent=yes immediate=yes" --become`
- OR specify the port instead `ansible node1 -m firewalld -a "port=80/tcp state=enabled permanent=yes immediate=yes" -b`

#### 📁 File Module

Create a file in the ansible user's home directory: 
`ansible -m file -a "path=anstest state=touch"` 

Create a directory in the ansible user's home directory: 
`ansible node1 -m file -a "path=ansdir state=directory"` 

It would be worthwhile to remember octal values when setting permissions on file, as they are much quicker. Remembering octal values makes it easy to perform common tasks, although Ansible modules do accept permissions such as `mode: u=rw,g=r,o=r` it would be easier to use: `mode: '0644'` 

You should already be familiar with the values of the last 3 digits when setting an octal mode `4=read, 2=write, 1=execute` if you are not familiar with values for the first digit see the table below: 

| Permission    | Octal Value | Purpose                                                                                                                                         |
|---------------|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| UID Bit  u+s  | 4           | Runs a file with the same permissions as the user that created the file. Fore example `/usr/bin/passwd`                                         |
| Group ID  g+s | 2           | All files in a directory will inherit the same group as the group that owns the directory. Useful for shared directories between several users. |
| Sticky Bit +t | 1           | Prevents a user from deleting a file that they are not the owner of.                                                                            |

#### 🐑🐑 Copy Module

 Copy a file from the host to a managed node 
```
touch masterfile 
ansible node1 -m copy -a "src=masterfile dest=/home/ansible" 
```

`remote_src` is another option you may want to be familiar with when copying, as it specified to copy a file already located on the managed node.

#### 📜 LineIn File

- Create a file and add a line to it: 
`ansible node1 -m lineinfile -a "path=/home/ansible/nodefile line='Welcome to Nodefile2' create=yes"`

- Check the contents of the file you just created: `ansible node1 -m shell -a "cat nodefile"`

- Modify a line in a file based on a regular expression: `ansible node1 -m lineinfile -a "path=/home/ansible/nodefile regexp='Nodefile2' line='A new line'"`

- Check the contents: `ansible node1 -m shell -a "cat nodefile"`

#### 🗄️ Archive and Unarchive 

The default archival method of the archive module in Ansible is gzip. 

- Create an archive of the `/etc/` directory on the remote node: `ansible node1 -m archive -b -a "path=/etc/ dest=/home/ansible/etcarchive.gz remote_src=yes"`

- Create a bzip2 archive:  `ansible node1 -m archive -b -a "path=/etc/ dest=/home/ansible/etcarchive.bz2 remote_src=yes format=bz2"`

*Unzips must be made to an existing directory*
Unarchive the file: `ansible node1 -m unarchive -a "src=theetc.bz2 dest=/home/ansible/unzipdir remote_src=yes"` although this command is currently giving an error, you may choose to use an ad hoc shell command instead to perform this. 

#### ⏰ At and Cron

- Setup an at job: `ansible node1 -m at -a "count=3 state=present units=minutes command='echo Ansible is fun >>/home/ansible/myfile'"`
- Setup a cron job to run every minute: `ansible node1 -m cron -a "name='log something' job='logger This is Ansible' minute='*' state=present"`

#### 🥸 User and Group

- See users on the system: `ansible node1 -m shell -a "getent passwd | tail"`
- Create a user: `ansible node1 -m user -a "name=rhce state=present" -b`
- Create a user and specify groups and uid: `ansible node1 -m user -a "name=rhce state=present uid=2000 groups=wheel" -b` 
- Create a group:  `ansible node1 -m group -a "name=accounting state=present" -b`
- Remove a group: `ansible node1 -m group -a "name=accounting state=absent" -b `

#### 📛 Hostname Module 

- Show the hostname: `ansible node1 -m shell -a "cat /etc/hostname"`
- Change the hostname: `ansible node1 -m hostname -a "name=node1"`

### 🚧 Constructing a Basic Playbook 

- A playbook can be named with the following extensions `.yml` or `.yaml` either extension is allowed. 
- To begin a playbook start with 3 dashes at the beginning of the file: `---`. 

For the full playbook see: [playbook1.yml](playbook1.yml)


### 🐚 Shell Scripts to Run Ad Hoc commands 

See: 
