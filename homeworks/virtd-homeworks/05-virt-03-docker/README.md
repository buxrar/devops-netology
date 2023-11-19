## Задача 1

Сценарий выполнения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберите любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

Опубликуйте созданный fork в своём репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

```
https://hub.docker.com/r/buxrar/netology_nginx
```

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
«Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- высоконагруженное монолитное Java веб-приложение;
    - Монолит на виртуалке или железе.
- Nodejs веб-приложение;
    - можно в контейнереили или виртуалке
- мобильное приложение c версиями для Android и iOS;
    - виртуальная среда эмулирующая андроид или железо
- шина данных на базе Apache Kafka;
    - виртуальные машины
- Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;
    - виртуальные машины или железо
- мониторинг-стек на базе Prometheus и Grafana;
    - В зависимости от требований к производительности, виртуалки или железо
- MongoDB как основное хранилище данных для Java-приложения;
    - контейнеры или виртуалки, в зависимости от требований
- Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.
    - Виртуальная машина. При необходимости можно масштабировать
## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
- Добавьте ещё один файл в папку ```/data``` на хостовой машине.
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

```
user@ub22:~$ docker run -d -it -v /data:/data centos:latest
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
cf3ef3eb7d13d9650b666896ae88b620951d27c4a31f01d26897e1f992c28e2b
user@ub22:~$ docker run -d -it -v /data:/data debian:latest
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
8457fd5474e7: Pull complete 
Digest: sha256:fab22df37377621693c68650b06680c0d8f7c6bf816ec92637944778db3ca2c0
Status: Downloaded newer image for debian:latest
f895594cc8d1417e1e3ccff94483a7457156371ded36586d4dff03a40f9921a3
user@ub22:~$ docker ps
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS     NAMES
f895594cc8d1   debian:latest           "bash"                   7 seconds ago    Up 7 seconds              relaxed_bardeen
cf3ef3eb7d13   centos:latest           "/bin/bash"              33 seconds ago   Up 32 seconds             pedantic_keller
user@ub22:~$ docker exec pedantic_keller touch /data/file
user@ub22:~$ sudo touch /data/file2
user@ub22:~$ docker exec relaxed_bardeen ls -l /data
total 2
-rw-r--r-- 1 root root 0 Nov 19 05:14 file
-rw-r--r-- 1 root root 0 Nov 19 05:17 file2


```


## Задача 4 (*)

Воспроизведите практическую часть лекции самостоятельно.

Соберите Docker-образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.


