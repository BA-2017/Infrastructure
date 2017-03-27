
# Setup kubectl on a client
## 1. Generate key and signing request (on client)
* `openssl genrsa -out ~/.kube/srueg.zhaw.key 4096
openssl req -new -key ~/.kube/srueg.zhaw.key -out srueg.zhaw-csr.pem -subj "/CN=srueg/O=cluster-admin"`
* `scp srueg.zhaw-csr.pem linux1:`

## 2. Verify signign request and generate certificate (on master)
* `openssl x509 -req -in /home/srueg/srueg.zhaw-csr.pem -CA /etc/kubernetes/pki/ca.pem -CAkey /etc/kubernetes/pki/ca-key.pem -CAcreateserial -out srueg.zhaw.crt -days 365`

## 3. Setup kubectl (on client)
* `kubectl config set-credentials srueg --client-certificate users/srueg.zhaw.crt --client-key users/srueg.key`
* `kubectl config set-cluster zhaw --server https://master.zhaw.tk:6443 --certificate-authority zhaw.ca-cert.pem`
* `kubectl config set-context zhaw --user srueg --cluster zhaw`
* `kubectl config use-context zhaw`