path "sys/auth/*"
{
    capabilities = ["create", "update", "delete", "sudo"]
}

path "sys/auth"
{
    capabilities = ["read"]
}
