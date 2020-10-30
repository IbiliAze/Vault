#!/bin/bash



[ Vault ]

vault login

vault status

vault operator unseal

echo "export VAULT_TOKEN={root.token}" >> ~/.bashrc #for client token authentication

vault auth list #all enabled authentication methods



[ Secrets ]

vault secrets list



[ KV ]

vault secrets enable -path=my_secrets-kv kv

vault secrets disable my_secrets-kv/

vault kv put my_secrets/first mykey=myvalue #adding a Key Value pair secret

vault kv get my_secrets/first #get

vault kv put my_secrets/first mykey2=myvalue2 #updating a KV secret

vault kv delete my_secrets/first #deleting a KV secret



[ Token ]

vault token create

vault token revoke s.vH60Sn7k3a4rv0AAnuQyKYBX



[ Username Password ]

vault auth list

vault auth enable userpass

vault auth disable userpass

vault write auth/userpass/users/our_user password=cisco

vault login -method=userpass username=our_user password=cisco



[ GitHub ]

vault auth enable github

vault auth disable github

vault write auth/github/config/ organization=IbiliAzeOrganization

vault write auth/github/map/teams/development value=dev-policy

vault write auth/github/map/users/IbiliAzeOrg value=user-policy


