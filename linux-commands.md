
## virsh network commands

net-list - List the virtual networks libvirt is aware of, along with some basic status and autostart flag information. Used without parameters it shows active virtual networks only.
```
virsh net-list [--all] [--inactive].
```

net-start - Starts an inactive, previously defined virtual network.

```
virsh net-start [--network] <network-identifier>
```

net-destroy - Stops an active network and deallocates all resources used by it, e.g. stopping appropiate dnsmasq process, releasing the bridge. The virtual network being stopped can be persistent or transient.

```
virsh net-destroy [--network] <network-identifier>
```

net-undefine - Removes an inactive presistent virtual network from the libvirt configuration.

```
virsh net-undefine [--network] <network-identifier>
```

net-autostart - Marks or unmarks automatic startup of a persistent virtual network. Networks with the autostart flag enabled are started whenever libvirt daemon starts. To disable autostart use the --disable switch.

```
virsh net-autostart [--network] <network-identifier> [--disable]
```

net-name - Returns the network name corresponding to the given UUID.

```
virsh net-name [--network] <network-uuid>
```

net-uuid - Returns the UUID corresponding to the given network-name.

```
virsh net-uuid [--network] <network-name>
```

net-dumpxml - Outputs the XML configuration for a virtual network.

```
virsh net-dumpxml [--network] <network-identifier>
```
