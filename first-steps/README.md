# First steps

## Finding images

```
az vm image list --architecture x64 --location eastus --publisher Canonical --all --sku 22_04-lts-gen2
az vm image list -p "Microsoft"
```

## Known issues

If the public IP is not retrieved after the first `terraform apply`, just hit
`terraform refresh` in order to retrieve it and get the appropriate output.

