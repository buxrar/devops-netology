# Домашнее задание к занятию «Хранение в K8s. Часть 1»

### Цель задания

В тестовой среде Kubernetes нужно обеспечить обмен файлами между контейнерам пода и доступ к логам ноды.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным GitHub-репозиторием.

------

### Дополнительные материалы для выполнения задания

1. [Инструкция по установке MicroK8S](https://microk8s.io/docs/getting-started).
2. [Описание Volumes](https://kubernetes.io/docs/concepts/storage/volumes/).
3. [Описание Multitool](https://github.com/wbitt/Network-MultiTool).

------

### Задание 1 

**Что нужно сделать**

Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
5. Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4.

### Ответ

```
oleg@MacBook-Air-oleg 06 % kubectl apply -f deployment.yaml -n hw
deployment.apps/busybox-multitool-deployment created
oleg@MacBook-Air-oleg 06 % kubectl get pods -n hw
NAME                                            READY   STATUS    RESTARTS   AGE
busybox-multitool-deployment-6ff69867cf-xw52z   2/2     Running   0          22s
oleg@MacBook-Air-oleg 06 % kubectl logs -f deployment/busybox-multitool-deployment -c multitool -n hw
Thu Dec 26 20:13:43 UTC 2024
Thu Dec 26 20:13:43 UTC 2024
Thu Dec 26 20:13:48 UTC 2024
Thu Dec 26 20:13:43 UTC 2024
Thu Dec 26 20:13:48 UTC 2024
Thu Dec 26 20:13:53 UTC 2024
Thu Dec 26 20:13:43 UTC 2024
Thu Dec 26 20:13:48 UTC 2024
```
------

### Задание 2

**Что нужно сделать**

Создать DaemonSet приложения, которое может прочитать логи ноды.

1. Создать DaemonSet приложения, состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера MicroK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2.

### Ответ 
syslog у меня отключен, так как развернуто в lxc контейнере, на примере другого лога

```
oleg@MacBook-Air-oleg 06 % kubectl apply -f daemonset.yaml -n hw2                                       
daemonset.apps/multitool-daemonset configured
oleg@MacBook-Air-oleg 06 % kubectl logs -f daemonset/multitool-daemonset -n hw2
2024-12-23 19:02:41,795 - main.py[DEBUG]: Ran 10 modules with 0 failures
2024-12-23 19:02:41,796 - util.py[DEBUG]: Reading from /proc/uptime (quiet=False)
2024-12-23 19:02:41,796 - util.py[DEBUG]: Read 12 bytes from /proc/uptime
2024-12-23 19:02:41,796 - atomic_helper.py[DEBUG]: Atomically writing to file /var/lib/cloud/data/status.json (via temporary file /var/lib/cloud/data/tmpq0ogpt9i) - w: [644] 497 bytes/chars
2024-12-23 19:02:41,796 - atomic_helper.py[DEBUG]: Atomically writing to file /var/lib/cloud/data/result.json (via temporary file /var/lib/cloud/data/tmp3ft_s9mg) - w: [644] 65 bytes/chars
2024-12-23 19:02:41,796 - util.py[DEBUG]: Creating symbolic link from '/run/cloud-init/result.json' => '../../var/lib/cloud/data/result.json'
2024-12-23 19:02:41,796 - util.py[DEBUG]: Reading from /proc/uptime (quiet=False)
2024-12-23 19:02:41,796 - util.py[DEBUG]: Read 12 bytes from /proc/uptime
2024-12-23 19:02:41,796 - util.py[DEBUG]: cloud-init mode 'modules' took 0.122 seconds (0.12)
2024-12-23 19:02:41,796 - handlers.py[DEBUG]: finish: modules-final: SUCCESS: running modules for final
```

------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------