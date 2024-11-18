# Creating and connecting VM using quickemu

https://github.com/quickemu-project/quickemu/wiki/02-Create-Linux-virtual-machines
```sh
quickget ubuntu 24.04           # download thing
quickemu --vm ubuntu-24.04.conf # enter vm
```

# Setting up remote connection

https://github.com/quickemu-project/quickemu/wiki/05-Advanced-quickemu-configuration
```sh
# (host)   start headless vm
quickemu --vm ubuntu-24.04.conf \
         --display none \
         --ssh-port 22220 \
         --spice-port 5930
cat ubuntu-24.04/ubuntu-24.04.ports            # (host)   check port

ssh -L 22220:localhost:22220 -N -f user@server # (client) create SSH tunnel
ssh -p 22220 vm_user@localhost                 # (client) ssh?

# (client) can also tunnel port 5930
spicy -h localhost -p 5930                     # (client) spicy client
```

We can set up the following in the client's ssh config.
```conf
Host vm
    HostName localhost
    User myuser
    Port 22220
    ProxyJump myserver

Host spice
    HostName myserver
    LocalForward 5930 localhost:5930
```
