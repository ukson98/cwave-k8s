# 연습문제 정답

## 2-1

아래 정보를 기반으로 POD를 생성 하세요.

| 항목     | 내용          |
| ------ | ----------- |
| 이미지    | nginx:1.8.1 |
| Pod 이름 | nginx-app   |
| Port   | 80          |

```{yaml}
apiVersion: v1
kind: Pod
metadata:
  name: nginx-app
  labels:
    name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.8.1
    resources:
      limits:
        memory: "128Mi"
        cpu: "500m"
    ports:
      - containerPort: 80
```

port-forward를 이용해서 로컬 8080 포트를 nginx 서비스 포트와 연결하세요

```{bash}
kubectl port-forward  nginx-app 8080:80
```

curl 명령어르 사용해서 nginx 서비스에 접속하세요

```{bash}
curl http://localhost:8080
```

nginx Pod 의 정보를 yaml 파일로 출력 하세요

```{bash}
kubectl get po nginx-app -o yaml
```

nginx Pod의 Bash 에 접속해서 nginx 의 설정파일을 확인하세요

```{bash}
kubectl exec -it nginx-app -- bash
```

nginx-app Pod 를 삭제 하세요

```{bash}
kubectl delete po nginx-app
```

## 4-1

bitnami/apache 이미지로 Pod 를 만들고 tier=FronEnd, app=apache 라벨 정보를 포함하세요

```{yaml}
apiVersion: v1
kind: Pod
metadata:
  name: apache
  labels:
    name: apache
    tier: frontend
    app: apache
spec:
  containers:
  - name: apache
    image: bitnami/apache
    resources:
      limits:
        memory: "128Mi"
        cpu: "500m"
    ports:
      - containerPort: 80
```

Pod 정보를 출력 할때 라벨을 함께 출력 하세요

```{bash}
kubectl get po --show-labels


kubectl get po -L tier -L app
```

app=apache 라벨틀 가진 Pod 만 조회 하세요

```{bash}
kubectl get po -l app=apache
```

만들어진 Pod에 env=dev 라는 라벨 정보를 추가 하세요

```{bash}
kubectl label po apache env=dev
```

created_by=kevin 이라는 Annotation을 추가 하세요

```{bash}
kubectl annotate po apache create_by=kevin
```

apache Pod를 삭제 하세요

```{bash}
kubectl delete po apache
```

## 5-1

쿠버네티스 클러스터에 몇개의 네임스페이가 존재 하나요?

```{bash}
kubectl get ns
```

my-dev 라는 네임스페이를 생성하고 nginx Pod를 배포 하세요

```{bash}
kubectl create ns my-dev
```

```{yaml}
apiVersion: v1
kind: Namespace
metadata:
  name: my-dev
```

현재 네임스페이스(Current Namespace)를 kube-system 으로 변경 하세요

```{bash}
kubens kube-system
```

```{bash}
kubectl config set-context --current --namespace=kube-system
```

모든 네임스페이스의 모든 리소스를 한번에 조회 하세요모든 네임스페이스의 모든 리소스를 한번에 조회 하세요

```{bash}
kubectl get all -A
```

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
