#!/bin/bash


echo step 1
wget https://releases.hashicorp.com/consul/1.8.5/consul_1.8.5_linux_amd64.zip

echo step 2
unzip consul_1.8.5_linux_amd64.zip

echo step 3
sudo mv consul /usr/bin/

echo step 4
consul -v

echo step 5
sudo echo '''[Unit]
Description=Consul
Documentation=https://www.consul.io
[Service]
ExecStart=/usr/bin/consul agent -server -ui -data-dir=/temp/cosul -bootstrap-expect=1 -node=vault-bind=192.168.0.64 -config-dir=/etc/consul.d/
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target''' > /etc/systemd/system/consul.service

echo step 6
sudo mkdir /etc/consul.d/

echo step 7
sudo echo '''{
        "addresses": {
                "http": "0.0.0.0"
        },
        "advertise_addr": "192.168.0.64"
}''' > /etc/consul.d/ui.json

echo step 8
sudo systemctl daemon-reload

echo step 9
sudo systemctl start consul

echo step 10
sudo systemctl status consul

echo step 11
sudo systemctl enable consul

echo step 12
sudo journalctl -r -n 10 -u consul

echo step 13
sudo apt update -y
sudo apt-add-repository universe

echo step 14
sudo apt install -y certbot

echo step 15
sudo ll /etc/letsencrypt

echo step 16
echo STEPS ABOVE WILL NO WORK 14,15

echo step 17
wget https://releases.hashicorp.com/vault/1.5.5/vault_1.5.5_linux_amd64.zip

echo step 18
unzip vault_1.5.5_linux_amd64.zip

echo step 19
sudo mv vault /usr/bin/

echo step 20
rm consul_1.8.5_linux_amd64.zip
rm vault_1.5.5_linux_amd64.zip

echo step 21
sudo mkdir /etc/vault
sudo touch /etc/vault/config.hcl

echo step 22
sudo echo '''storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}

listener "tcp" {
  address     = "0.0.0.0:443"
  tls_disable = 1 #for the time being
  tls_cert_file = "/home/ibi/Documents/Git/Vault/Installation/TLS/test.cert"
  tls_key_file = "/home/ibi/Documents/Git/Vault/Installation/TLS/test.key"
}

telemetry {
  statsite_address = "127.0.0.1:8125"
  disable_hostname = true
}
ui = true''' > /etc/vault/config.hcl

echo step 23
sudo touch /etc/systemd/system/vault.service

echo step 24
sudo echo '''[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/

[Service]
ExecStart=/usr/bin/vault server -config=/etc/vault/config.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target''' > /etc/systemd/system/vault.service

echo step 25
sudo systemctl daemon-reload

echo step 26
export VAULT_ADDR="http://192.168.0.64:8200"
echo "export VAULT_ADDR=http://192.168.0.64:8200" >> ~/.bashrc

echo step 27
vault -autocomplete-install

echo step 28
complete -C /usr/bin/vault vault

echo step 29
sudo systemctl start vault

echo step 30
sudo systemctl status vault

echo step 31
sudo systemctl enable vault

echo step 33
vault operator init > SAFE.txt

echo step 34
vault operator unseal i912IssjJCSsFYoXetpUfNh2YB18a7I5RxxBcrzU1Jp0
vault operator unseal pQDEIaSVeTq3KHkiX7hmftZP9s7fdb7/Kui8qHxx3XG5
vault operator unseal Y1I5AVW9TdGON961JWjthVoNO/cuSNm2zg3XEzVb5D8w

echo step 35
export VAULT_TOKEN=s.uB8U4KZHYrcF15WqjyqiRA24
echo "export VAULT_TOKEN=s.uB8U4KZHYrcF15WqjyqiRA24" >> ~/.bashrc




