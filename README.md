wkcertbot
===========

This repository contains a wrapper script that makes it easier to use 
Electronic Frontier Foundation's (EFF's) Certbot with the WISeKey ACME server

Installation
------------

1. Install the operating system packages for `curl` and `certbot` 
2. Install the ZeroSSL wrapper script
   1. Quick: 
      1. run `bash <(curl -s https://tlsmanager.certifyid.com/get-wkcertbot.sh)`
      2. Done!
   2. Careful: 
      1. Run `curl -s https://tlsmanager.certifyid.com/get-wkcertbot.sh > get-wkcertbot.sh`
      2. Inspect the file to see that it does what it is supposed to do
      3. Run `source get-wkcertbot.sh`
      
Usage
-----

To use the WISeKey ACME server instead of running `certbot` run `wkcertbot`.

### Examples

```bash
sudo wkcertbot certonly --standalone -m anton@example.com -d mydomain.example.com
```

```bash
sudo wkcertbot --apache -m barbara@example.com -d myotherdomain.example.com
```

