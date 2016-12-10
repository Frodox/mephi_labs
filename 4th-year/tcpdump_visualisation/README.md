# tcp2graphviz

`tcp2graphviz` converts simple tcpdump into graphviz-dot-format file
for visualisation of network communications.

It takes source IP and destination IP from tcpdump's log
and save relations-graph into .dot file, so you could draw it with Graphviz or Gephi.

See also [my blog post](http://bitthinker.com/blog/en/research/how-to-visualize-tcpdump-with-graphviz)
for more information about this script.


Again, works for simple tcpdumps only:

```bash
# tcpdump -nS -i enp3s0
18:01:06.871576 IP 192.168.1.36.47054 > 176.15.9.185.3817: UDP, length 3
18:01:07.425390 IP 192.168.1.36.58846 > 91.213.196.95.80: Flags [.], ack 1331604578, win 600, options [nop,nop,TS val 106250810 ecr 615747493], length 0
18:01:07.428521 IP 91.213.196.95.80 > 192.168.1.36.58846: Flags [.], seq 1331604578:1331606026, ack 2715406339, win 514, options [nop,nop,TS val 615749583 ecr 106250810], length 1448: HTTP
...
```

i.e.:
* 3rd column: `source IP.port`
* 5th columnt: `destination IP.port`

### NOTE: ! If you **already have** text-dump in **another format**, you would need to edit script a bit.


## Usage example

```bash
# catch 1000 packets on enp3s0 interface to file
$ sudo tcpdump -c 1000 -i enp3s0 -w dump.pcap
# extract needed information (IPs) in simple for parsing format
$ sudo tcpdump -nS -r dump.pcap  > dump.txt
# convert text-dump into .dot format
$ ./tcp2graphviz.sh dump.txt mynetwork
# draw graphs
$ neato -K circo -Tpdf -o mynetwork.pdf mynetwork.ip4.dot
```

you may need to play a bit with `dot`/`neato` to get desired node-placement,
or try to load your `.dot` graph in [Gephi](https://gephi.org/) now.

IPv4 and IPv6 will be saved into different files automatically,
since most of time there is no sense to draw them together.
