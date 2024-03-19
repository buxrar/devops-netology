# About
Install and configuring clickhouse and vector and lighthouse

## Get galaxy requirements

```
ansible-galaxy install --force -r requirements.yml
```

## galaxy requirements
```
---
  - src: https://github.com/buxrar/devops-netology.git
    scm: git
    version: clickhouse-role
    name: clickhouse 

  - src: https://github.com/buxrar/devops-netology.git
    scm: git
    version: vector-role
    name: vector 

  - src: https://github.com/buxrar/devops-netology.git
    scm: git
    version: lighthouse-role
    name: lighthouse
```

# Vars

 - group_vars/clickhouse/vars.yml
```
clickhouse_version: - version clickhouse
```
 - group_vars/vector/vars.yml
```
clickhouse_address:  - ip address clickhouse server
```
 - group_vars/lighthouse/vars.yml
```
nginx_path:  - set path to nginx
```