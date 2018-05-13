# Pachyderm-Terraform
pachyderm-terraform provides terraform config to deploy [pachyderm](https://github.com/pachyderm/pachyderm)

## Quickstart

Install forked terraform k8s provider
```bash
# Clone to GOPATH
git clone git@github.com:sl1pm4t/terraform-provider-kubernetes.git
cd terraform-provider-kubernetes && make build
```

Copy binary to .terraform.d/plugins
```bash
mv $GOPATH/bin/terraform-provider-kubernetes ~/.terraform.d/plugins
```

Kubernetes terraform provider does not support beta objects of the k8s api. These objects (role, rolebinding, serviceaccount) are currently deployed via kubectl.

Note these only need to be deployed once.
```bash
kubectl create -f pachd_rolebinding.yaml -f pachd_role.yaml -f pachd_sa.yaml
```

Deploy pachyd, etcd
```bash
terraform init
terraform apply
```