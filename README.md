dyn-update-bind
===============

Update a hostname into a dynamic BIND9 zone.

Requirements:
--
On the host: install 'nsupdate'

On the server: configure a dynamically updatable zone, you can google for instructions, or check this page (in Spanish only sorry): http://cagnazzo.me/drupal/node/53

Configuring the script:
--
Edit the top-level variables:

```
SERVER=<your DNS server>
ZONE=<your dynamically updateable zone>
HOSTNAME=<set your hostname>|$(hostname)
```

Running the script:
--
./dyn-update-bind.sh 

Checking the results:
--
dig $SERVER <your hostname>
