
### ansible-mesos

A basic playbook to stand up a 3-node mesos + marathon + zookeeper cluster.

**How to run**

A sample terraform file is included (`example.tf`), it utilizes EC2 spot instances because they are cheap.

```bash
# See what you are going to deploy
terraform plan

# Deploy in AWS
terraform apply
```

Then populate your Ansible inventory file, `hosts`, with the hostnames and run:

```bash
# validate connectivity
ansible -i hosts mesos -u ubuntu --private-key ~/.ssh/adamkeys -m ping

# run the playbook
ansible-playbook -i hosts site.yml -u ubuntu --private-key ~/.ssh/adamkeys
```

Note: The `-u` and `--private-key` options might not be necessary depending on your `ansible.cfg` setup)

Then hit mesos or marathon via web browser on any of the nodes (it should redirect you to the currently elected master):

>Mesos:
`http://host1:5050`

> Marathon:
`http://host1:8080`
