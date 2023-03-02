# Lesson 49. Kubernetes 5

Создать Helm Chart для развертывания Wordpress в составе:
- mysql
- wordpress
- hpa (для mysql и wordpress)
- ingress
- NetworkPolicy, ограничивающий входящий трафик для mysql pods только с wordpress pods

В шаблонах манифестов не должно быть хардкода

Предварительно в кластере должны быть развернуты:
- CNI с поддержкой NetworkPolicy
- PVs
- Ingress-controller

Развернуть Helm Chart в namespace dev