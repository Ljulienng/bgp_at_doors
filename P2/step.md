### Static network configuration with Console commands

#### Host config

Open the auxiliary console.

From the subject our interface must be "eth1" and not eth0.

Let's check:
```sh
ip a
```

if the interface is named eth0 instead of eth1 then let's rename:
```sh
ip link set eth0 down # stop the interface before renaming it
ip link set eth0 name eth1
ip link set eth1 up # restarting it
```

Let's set the ip adresses:
```sh
ip addr add 30.1.1.1/24 dev eth1 # for host_1
ip addr add 30.1.1.2/24 dev eth1 # for host_2
```
#### Router config

```sh
ip addr add 10.1.1.1/24 dev eth0 # for router_1
ip addr add 10.1.1.2/24 dev eth0 # for router_2
```

### Bridges and VxLan

For each router we have to configure a VxLan interface.

Router_1:
```sh
ip link add vxlan10 type vxlan id 10 remote 10.1.1.2/24 dstport 4789 dev eth0
ip link set vxlan10 up
```

Router_2:
```sh
ip link add vxlan10 type vxlan id 10 remote 10.1.1.1/24 dstport 4789 dev eth0
ip link set vxlan10 up
```

VxLan is used to make our hosts thinks their on the same LAN network. we'll have to make a bridge for the interface eth1 and vxlan10

### Bridge config

```sh
ip link add name br0 type bridge
ip link set br0 up
ip link set vxlan10 master br0 # adding vxlan10 to the bridge (or brctl addif br0 eth1)
ip link set eth1 master br0 # adding eth1 (or brctl addif br0 vxlan10)
```

#### Show macs:

brctl showmacs br0