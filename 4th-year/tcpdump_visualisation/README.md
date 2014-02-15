# tcp2graphviz

tcp2graphviz : v0.1 : convert tcpdump into graphviz-dot-format file
  for visualisation of network communication.

## Description:
tcp2graphviz takes source IP(4/6) and destination IP(4/6) from tcpdump
and output them into file with graphviz-dot-syntax to draw a graph.

works for simple tcpdumps, like,
  `tcpdump -nS -i eth0`    (on tcpdump v 4.1.1)

i.e.:

* 3rd column : source IP
* 5th columnt: destination IP

### NOTE: ! If you have another log format, you need to edit script by yourself.

## Usage
`tcp2graphviz <args>`

args:

* first:  path/to/tcpdump file (not raw/binary one)
* second: path/to/output file. IPV4 and IPV6 will be in different files automatically,
      like: <path/to/output/file>.ip4.dot and <path/to/output/file>.ip6.dot
      since it makes no sense to draw them on the same graph.

and draw graph, like:
`cat file.ip4.dot | dot -Tsvg -o file.ip4.svg`

