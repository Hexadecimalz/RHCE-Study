# 🐧 RHCE-Study
Here are published notes for a private RHCE study group. You can find notes within the sub folders on this repo. This repository is not affiliated with RedHat in any way, it is an independent and private study project. 

## 🖥️ Recommended Environment
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

For more details see: [Environment-Setup.md](./Environment-Setup.md)

## ℹ Formatting Notes
Ansible relies on playbooks, which are files formatted in YAML, but those playbooks are run at the command line. 
In order to make it more clear which is which, we've tried to add the following indicators for files versus commands: 

- *📃 playbook.yml* = file with name and extension specified after (may also include a relative path)
- *🖥️ at the prompt:* = yup, you guessed it, run at the prompt 
- At certain points the disctinction should be obvious, so we'll omit this when it should be clear.

## 🎯 Exam Objectives
One of the best ways to know if you're prepared or not is to refer to the [Exam Objectives](https://www.redhat.com/en/services/training/ex294-red-hat-certified-engineer-rhce-exam-red-hat-enterprise-linux-8?section=Objectives)

## 🎪 Study Resources 
The Red Hat Certified Engineer exam reinforces topics from RHCSA while challenging examinees to use Ansible to automate core tasks using orchestration. 
- CSG's course: https://www.youtube.com/c/ComputersSecurityGadgets/playlists
- Sander Van Vugt's: https://www.sandervanvugt.com/course/red-hat-certified-engineer-rhce-ex294-video-course-red-hat-ansible-automation/ (try discount code `SANDER60`)
- A Cloud Guru: https://acloudguru.com/course/red-hat-certified-engineer-rhel-8-rhce
- Eddie Jennings' Practice Sessions: https://www.youtube.com/watch?v=SXla5WnQqLE&list=PLgYy5YCbiYbFCcYFiGKDJnXVnuXRjxq6Z
- Lisenet's Practice Exam: https://www.lisenet.com/2019/ansible-sample-exam-for-ex294/

## 🔌 Contributing 
Contributions are welcome through a pull request or by submitting an issue. 

## 📽 Credits 
This repo is in collaboration with [TheCenturist](https://github.com/thecenturist).