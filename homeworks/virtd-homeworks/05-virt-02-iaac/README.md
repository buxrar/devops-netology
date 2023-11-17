## Задача 1

- Опишите основные преимущества применения на практике IaaC-паттернов.
    - Автоматизация упрощает и ускоряет процессы развертывания инфраструктуры и ее конфигурирования. Позволяет легко масштабироваться. Снижает влияние человеческого фактора. Повышает надежность. Повышает безопасность. Снижает затраты.
- Какой из принципов IaaC является основополагающим?
    - Идемпотентность. Автоматизация и повторяемость всех процессов взаимодействия человека с инфраструктурой. 

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
 -  Пуш система, не требующая установки на хост дополнительных агентов. Свободно распространяемая. Имеет большое комьюнити и хорошую поддержку.
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?
 - push - так как имеет меньше точек поломки, не надо содержать и тратить ресурсы для агента на конечных узлах. Можно сохранить репозиторий и запускать прокатки с любой точки.

## Задача 3

Установите на личный linux-компьютер(или учебную ВМ с linux):

- [VirtualBox](https://www.virtualbox.org/),
- [Vagrant](https://github.com/netology-code/devops-materials), рекомендуем версию 2.3.4(в более старших версиях могут возникать проблемы интеграции с ansible)
- [Terraform](https://github.com/netology-code/devops-materials/blob/master/README.md)  версии 1.5.Х (1.6.х может вызывать проблемы с яндекс-облаком),
- Ansible.

*Приложите вывод команд установленных версий каждой из программ, оформленный в Markdown.*

```
Package: virtualbox
Architecture: amd64
Version: 6.1.38-dfsg-3~ubuntu1.22.04.1
```
```
Vagrant 2.4.0
```
```
Terraform v1.6.4
```
```
ansible [core 2.15.6]
  config file = None
  configured module search path = ['/home/user/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.10/dist-packages/ansible
  ansible collection location = /home/user/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```
## Задача 4 

Воспроизведите практическую часть лекции самостоятельно.

- Создайте виртуальную машину.
- Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды
```
docker ps,
```
Vagrantfile из лекции и код ansible находятся в [папке](https://github.com/netology-code/virt-homeworks/tree/virt-11/05-virt-02-iaac/src).

Примечание. Если Vagrant выдаёт ошибку:
```
URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]     
Error: The requested URL returned error: 404:
```

выполните следующие действия:

1. Скачайте с [сайта](https://app.vagrantup.com/bento/boxes/ubuntu-20.04) файл-образ "bento/ubuntu-20.04".
2. Добавьте его в список образов Vagrant: "vagrant box add bento/ubuntu-20.04 <путь к файлу>".

Важно!: Если ваша хостовая рабочая станция - это windows ОС, то у вас могут возникнуть проблемы со вложенной виртуализацией.  [способы решения](https://www.comss.ru/page.php?id=7726)  . Если вы устанавливали hyper-v или docker desktop то  все равно может возникать ошибка: Stderr: VBoxManage: error: AMD-V VT-X is not available (VERR_SVM_NO_SVM) . Попробуйте в этом случае выполнить в windows от администратора команду: "bcdedit /set hypervisorlaunchtype off" и перезагрузиться

***Приложите скриншоты в качестве решения на эту задачу. Допускается неполное выполнение данного задания если не сможете совладать с Windows.*** 
