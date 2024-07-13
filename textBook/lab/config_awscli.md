# AWS 환경 설정

## awscli 설치

- Window 설치
  
  ```{bahs}
  choco install awscli
  ```

- Mac 설치
  
  다운로드 및 GUI 설치 URL : https://awscli.amazonaws.com/AWSCLIV2.pkg
  
  Command 설치
  
  ```{bash}
  $ curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  $ sudo installer -pkg AWSCLIV2.pkg -target /
  ```
  
  

- Linux 설치
  
  ```{bash}
  $ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  $ unzip awscliv2.zip
  $ sudo ./aws/install
  ```

## 

## AWS Console 에서 사용자 생성 및 Access Key 생성 하기

IAM > 사용자 > 사용자 생성

![Screenshot 2024-07-13 at 12.24.11 PM.png](/Users/dangtongbyun/Desktop/Screenshot%202024-07-13%20at%2012.24.11 PM.png)



IAM > 사용자 > 사용자 계정 > 권한추가 > 직접정책연결 > AdministratorAccess 추가

![Screenshot 2024-07-13 at 12.26.22 PM.png](/Users/dangtongbyun/Desktop/Screenshot%202024-07-13%20at%2012.26.22 PM.png)

IAM > 사용자 > 사용자 계정 > 보안 자격 증명 > 엑세스 키 > 엑세스 키 만들기 > CLI > 엑세스키 만들기



![22.png](/Users/dangtongbyun/Downloads/22.png)

 

## awscli 인증 정보 생성하기

```{bash}
$ aws configure list


$ aws congiure --profile cwave
AWS Access Key ID [None]: XXXXXXXXXXXXXXXXXXXXXXXXX
AWS Secret Access Key [None]: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Default region name [None]: ap-northeast-2
Default output format [None]: json
```



## Terraform profile 연동

```{bash}
$ terraform init

$ terraform workspace list
* default

$ terraform workspace new cwave

$ terraform plan

```




