# 연습문제 정답

## 

## 

## 9-1

- nginx:1.9.1 Pod 3개로 구성된 Replication Controller를 작성 하세요

```{yaml}
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-rc
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.9.1
          ports:
            - containerPort: 80
```

- Replication Controller 만 삭제 하세요 (Pod 는 유지)

```{bash}
kubectl delete rc nginx-rc --cascade=orphan
```



- 남겨진 nginx Pod를 관리하는 ReplicaSet 을 작성하된 replica 4개로 구성 하세요

```{yaml}
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.9.1
          ports:
            - containerPort: 80
```



- nginx Pod 를 6개로 Scale Out 하세요

```{bash}
kubectl scale rs nginx-rs --replicas=5
```



## 10-1

- 데몬셋은 어떤 용도로 사용되는지 생각해봅니다.
- 현재 쿠버네티스에서 DaemonSet 으로 실행중인 Pod를 찾아 봅니다



데몬셋의 용도 

- 노드와 관련되어 필요한 공통된 작업

- 모니터링 데몬 같이 노드에 떠서 여러 해당 노드의 여러 Pod들의 로그를 수집 하는 역할

- 보안 컨포넌트

- 오버레이 네트워크 컨포넌트



```{bash}
kubectl get all -n kube-system
```



## 11-1

```{yaml}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-dp
spec:
  selector:
    matchLabels:
      app: httpd
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 3
  replicas: 5
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
      - name: httpd
        image: httpd:2.3-alpine
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
        - containerPort: 80
```



```{bash}
kubectl set image deployment.apps/httpd-dp httpd:2.4-alpine
```



```{bash}
kubectl annotate deploy httpd-dp kubernetes.io/change-cause="updated image to httpd:2.4-alpine" 
```



```{bash}
kubectl rollout history deploy http-dp
```



```{bash}
kubectl scale deployment httpd-dp --replicas=5
```


