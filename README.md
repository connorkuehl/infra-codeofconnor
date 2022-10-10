## Quickstart

```console
$ cat > .envrc <<EOF
export TF_VAR_do_token=your_secret_DO_API_key
export TF_VAR_ssh_keys=[sshkey_id1,sshkey_id2]
export TF_VAR_region=sfo3
export TF_VAR_domain_name=codeofconnor.com
export TF_VAR_droplet_name=web
$ direnv allow
$ terraform init
$ terraform plan
$ terraform apply
```
