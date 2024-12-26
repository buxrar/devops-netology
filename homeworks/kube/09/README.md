# Домашнее задание к занятию «Управление доступом»

### Цель задания

В тестовой среде Kubernetes нужно предоставить ограниченный доступ пользователю.

------

### Чеклист готовности к домашнему заданию

1. Установлено k8s-решение, например MicroK8S.
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключённым github-репозиторием.

------

### Инструменты / дополнительные материалы, которые пригодятся для выполнения задания

1. [Описание](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) RBAC.
2. [Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/).
3. [RBAC with Kubernetes in Minikube](https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b).

------

### Задание 1. Создайте конфигурацию для подключения пользователя

1. Создайте и подпишите SSL-сертификат для подключения к кластеру.
2. Настройте конфигурационный файл kubectl для подключения.
3. Создайте роли и все необходимые настройки для пользователя.
4. Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`).
5. Предоставьте манифесты и скриншоты и/или вывод необходимых команд.

### Ответ

роли и привязки роли
```
   apiVersion: rbac.authorization.k8s.io/v1
   kind: Role
   metadata:
     namespace: default
     name: pod-reader
   rules:
   - apiGroups: [""]
     resources: ["pods", "pods/log"]
     verbs: ["get", "list", "watch"]
```

```
   apiVersion: rbac.authorization.k8s.io/v1
   kind: RoleBinding
   metadata:
     name: read-pods
     namespace: default
   subjects:
   - kind: User
     name: oleg
     apiGroup: rbac.authorization.k8s.io
   roleRef:
     kind: Role
     name: pod-reader
     apiGroup: rbac.authorization.k8s.io
```

```
oleg@MacBook-Air-oleg 09 % kubectl apply -f role.yaml

role.rbac.authorization.k8s.io/pod-reader created
oleg@MacBook-Air-oleg 09 % kubectl apply -f rolebinding.yaml

rolebinding.rbac.authorization.k8s.io/read-pods created
```

Готовый конфиг 
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkakNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdGMyVnkKZG1WeUxXTmhRREUzTXpRNU9EQTJNek13SGhjTk1qUXhNakl6TVRrd016VXpXaGNOTXpReE1qSXhNVGt3TXpVegpXakFqTVNFd0h3WURWUVFEREJock0zTXRjMlZ5ZG1WeUxXTmhRREUzTXpRNU9EQTJNek13V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFSM1VtakNOczBtVnR5Q24xcXlteGFNdjRQZnduTGNhYWpCRHpsWWp2UmsKalFJczNTdEVmczJOSllYWUJwYk9JNkhQbUFLTmsxanFyaGQ1YmE4cXFGaFhvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVTloM0R6K1BaejZhaGNrTXB6dFVlCnZrdFF6OWd3Q2dZSUtvWkl6ajBFQXdJRFJ3QXdSQUlnZEtJVmNzMGMwM3FIc0g5V004dkt5ZmkwazgwNG9YT3AKcnFKb2JCVGhXK01DSUF6QUhBcDJHZDQzZlp6RU1ya0R1ZWN5OW83VUVxbUxJKzlzdENCNzZDSXoKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
    server: https://192.168.2.199:6443
  name: default
contexts:
- context:
    cluster: default
    user: oleg
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: oleg
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJrakNDQVRlZ0F3SUJBZ0lJZUw1OUNFaG1zb2t3Q2dZSUtvWkl6ajBFQXdJd0l6RWhNQjhHQTFVRUF3d1kKYXpOekxXTnNhV1Z1ZEMxallVQXhOek0wT1Rnd05qTXpNQjRYRFRJME1USXlNekU1TURNMU0xb1hEVEkxTVRJeQpNekU1TURNMU0xb3dNREVYTUJVR0ExVUVDaE1PYzNsemRHVnRPbTFoYzNSbGNuTXhGVEFUQmdOVkJBTVRESE41CmMzUmxiVHBoWkcxcGJqQlpNQk1HQnlxR1NNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJJNXFMNG5tWGR2Sm5OeFQKZDZNNWpudlAyUnhMRFM4bzlXbnhYRjBNZS9YMjd5MHlLaW8xMzFrVU9sOGZYMnIrY3lESW9MUVN2SERGcVdWLwp0d09sejB5alNEQkdNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBakFmCkJnTlZIU01FR0RBV2dCUTVvOXZJeS8rNDExakxNTWFhRUNPTFFnYThkREFLQmdncWhrak9QUVFEQWdOSkFEQkcKQWlFQWdFMHNoNENuWStib0FZd0U5T2hFREZ4dGpFL1FQTnJsUENBNVF4MVU2Q1FDSVFEbjBWZlE5VElzT1NYSApvYTdmN0Yrd1p2c2NjdUZDSW50d250aGNNVVBVaHc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCi0tLS0tQkVHSU4gQ0VSVElGSUNBVEUtLS0tLQpNSUlCZHpDQ0FSMmdBd0lCQWdJQkFEQUtCZ2dxaGtqT1BRUURBakFqTVNFd0h3WURWUVFEREJock0zTXRZMnhwClpXNTBMV05oUURFM016UTVPREEyTXpNd0hoY05NalF4TWpJek1Ua3dNelV6V2hjTk16UXhNakl4TVRrd016VXoKV2pBak1TRXdId1lEVlFRRERCaHJNM010WTJ4cFpXNTBMV05oUURFM016UTVPREEyTXpNd1dUQVRCZ2NxaGtqTwpQUUlCQmdncWhrak9QUU1CQndOQ0FBU0M1TE5pTTREamdVTGQxN3JXV0xWSURDajEyUVhCOGF3c3ZUbHp5TjJsCk5UWU96ZkFTSVdmOGtOSUE1MHYyU282UTdIcnIrWGV3MUJnZHNvUDhXSG9RbzBJd1FEQU9CZ05WSFE4QkFmOEUKQkFNQ0FxUXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QWRCZ05WSFE0RUZnUVVPYVBieU12L3VOZFl5ekRHbWhBagppMElHdkhRd0NnWUlLb1pJemowRUF3SURTQUF3UlFJZ2JXaVBTa1VteVYrSExvSHpSTmlGeVZ3NnJua3llZzNxCmQyQmlzMElnd0ZzQ0lRRG40ZFV6L2xpRDI2Y21ENXQ1MnNNYS9UVmVuVm5pNUt3aHcwZjRSUXRkbEE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    client-key-data: LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSU94V0N4ckdrcFhnSERKeVUyM3dWSUNMM01EYXkvSm9Nb2JnK2J1MS9TR1FvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFam1vdmllWmQyOG1jM0ZOM296bU9lOC9aSEVzTkx5ajFhZkZjWFF4NzlmYnZMVElxS2pYZgpXUlE2WHg5ZmF2NXpJTWlndEJLOGNNV3BaWCszQTZYUFRBPT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
```
------

### Правила приёма работы

1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.

------

