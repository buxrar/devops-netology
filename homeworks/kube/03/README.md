# Домашнее задание к занятию «Запуск приложений в K8S»

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым git-репозиторием.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
```
devops-netology % kubectl apply -f homeworks/kube/03/netology1.yml -n netology
deployment.apps/my-netology-1 configured
devops-netology % kubectl get pods -n netology                                
NAME                            READY   STATUS    RESTARTS   AGE
my-netology-1-76f8b9d88-vt7v8   2/2     Running   0          32s
devops-netology % kubectl scale deployment my-netology-1 --replicas=2 -n netology
deployment.apps/my-netology-1 scaled
devops-netology % kubectl get pods -n netology                                 
NAME                            READY   STATUS    RESTARTS   AGE
my-netology-1-76f8b9d88-vt7v8   2/2     Running   0          12m
my-netology-1-76f8b9d88-wqttj   2/2     Running   0          7s
```
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.
```
devops-netology % kubectl get pods -n netology                      
NAME                            READY   STATUS    RESTARTS   AGE
my-netology-1-c9f958c6c-rx8jg   2/2     Running   0          5m29s
multitool-pod                   1/1     Running   0          4m34s
devops-netology % kubectl exec -n netology -it multitool-pod bash
multitool-pod:/# curl my-netology-service:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
multitool-pod:/# curl my-netology-service:8080
WBITT Network MultiTool (with NGINX) - my-netology-1-c9f958c6c-rx8jg - 10.42.0.207 - HTTP: 1180 , HTTPS: 11443 . (Formerly praqma/network-multitool)
multitool-pod:/# 
```
------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
```
devops-netology % kubectl apply -f homeworks/kube/03/netology2.yml -n netology 
deployment.apps/nginx-deployment created
devops-netology % kubectl get pods -n netology                                
NAME                                READY   STATUS     RESTARTS   AGE
nginx-deployment-7c8cfbf947-2bt62   0/1     Init:0/1   0          3s
```
3. Создать и запустить Service. Убедиться, что Init запустился.
```
devops-netology % kubectl apply -f homeworks/kube/03/netology2-service.yml -n netology 
service/nginx-service created
```
4. Продемонстрировать состояние пода до и после запуска сервиса.
```
devops-netology % kubectl get pods -n netology
NAME                                READY   STATUS     RESTARTS   AGE
nginx-deployment-7c8cfbf947-2bt62   0/1     Init:0/1   0          39s
devops-netology % kubectl get pods -n netology                                        
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-7c8cfbf947-2bt62   1/1     Running   0          72s
```

------

### Правила приема работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов.
3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md.

------