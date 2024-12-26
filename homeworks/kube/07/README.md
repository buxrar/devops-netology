# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Цель задания

В тестовой среде Kubernetes нужно создать PV и продемострировать запись и хранение файлов.

------

### Чеклист готовности к домашнему заданию

1. Установленное K8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным GitHub-репозиторием.

------

### Дополнительные материалы для выполнения задания

1. [Инструкция по установке NFS в MicroK8S](https://microk8s.io/docs/nfs). 
2. [Описание Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/). 
3. [Описание динамического провижининга](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/). 
4. [Описание Multitool](https://github.com/wbitt/Network-MultiTool).

------

### Задание 1

**Что нужно сделать**

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории. 
4. Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.
5. Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


### Ответ

```
oleg@MacBook-Air-oleg 07 % kubectl apply -f pv-pvc.yaml -n hw
persistentvolume/local-pv created
persistentvolumeclaim/local-pvc created
oleg@MacBook-Air-oleg 07 % kubectl apply -f deployment.yaml -n hw
deployment.apps/busybox-multitool-deployment created
oleg@MacBook-Air-oleg 07 % kubectl logs -f deployment/busybox-multitool-deployment -c multitool -n hw
Hello from busybox
Hello from busybox
Hello from busybox

oleg@MacBook-Air-oleg 07 % kubectl delete deployment busybox-multitool-deployment -n hw
deployment.apps "busybox-multitool-deployment" deleted
oleg@MacBook-Air-oleg 07 % kubectl delete pvc local-pvc -n hw
persistentvolumeclaim "local-pvc" deleted
oleg@MacBook-Air-oleg 07 % kubectl get pv local-pv -n hw
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
local-pv   1Gi        RWX            Retain           Available                          <unset>                          7m8s
oleg@MacBook-Air-oleg 07 % kubectl delete pv local-pv -n hw
Warning: deleting cluster-scoped resources, not scoped to the provided namespace
persistentvolume "local-pv" deleted
oleg@MacBook-Air-oleg 07 % kubectl get pv local-pv -n hw   
Error from server (NotFound): persistentvolumes "local-pv" not found
```
------

### Задание 2

**Что нужно сделать**

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.


### Ответ

```
oleg@MacBook-Air-oleg 07 % kubectl apply -f nfs-pv-pvc.yaml -n hw
persistentvolume/nfs-pv created
persistentvolumeclaim/nfs-pvc created
oleg@MacBook-Air-oleg 07 % kubectl apply -f nfs-deployment.yaml -n hw
deployment.apps/multitool-deployment created
oleg@MacBook-Air-oleg 07 % kubectl get pv nfs-pvc -n hw              
Error from server (NotFound): persistentvolumes "nfs-pvc" not found
oleg@MacBook-Air-oleg 07 % kubectl get pv nfs-pv -n hw               
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
nfs-pv   1Gi        RWX            Retain           Available                          <unset>                          56s
oleg@MacBook-Air-oleg 07 % kubectl delete deployment multitool-deployment -n hw
deployment.apps "multitool-deployment" deleted
oleg@MacBook-Air-oleg 07 % kubectl delete pvc nfs-pvc -n hw
persistentvolumeclaim "nfs-pvc" deleted
oleg@MacBook-Air-oleg 07 % kubectl delete pv nfs-pv -n hw
Warning: deleting cluster-scoped resources, not scoped to the provided namespace
persistentvolume "nfs-pv" deleted
```
------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.