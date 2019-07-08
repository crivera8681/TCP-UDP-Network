set ns [new Simulator]
$ns rtproto DV

set tracefd [open test1.tr w]
$ns trace-all $tracefd

#---------------------------------------------------------------------------------------------------------

#Creating each node
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]

#---------------------------------------------------------------------------------------------------------

#purple duplex
$ns duplex-link $n0 $n2 2Mb 40ms DropTail
$ns duplex-link $n1 $n2 2Mb 40ms DropTail
$ns duplex-link $n3 $n5 2Mb 40ms DropTail
$ns duplex-link $n4 $n6 2Mb 40ms DropTail
$ns duplex-link $n4 $n7 2Mb 40ms DropTail

#orange duplex
$ns duplex-link $n8 $n0 1Mb 20ms DropTail
$ns duplex-link $n9 $n1 1Mb 20ms DropTail
$ns duplex-link $n5 $n10 1Mb 20ms DropTail
$ns duplex-link $n5 $n11 1Mb 20ms DropTail
$ns duplex-link $n5 $n12 1Mb 20ms DropTail
$ns duplex-link $n5 $n13 1Mb 20ms DropTail
$ns duplex-link $n6 $n14 1Mb 20ms DropTail
$ns duplex-link $n6 $n15 1Mb 20ms DropTail
$ns duplex-link $n7 $n16 1Mb 20ms DropTail
$ns duplex-link $n7 $n17 1Mb 20ms DropTail

#black duplex
$ns duplex-link $n2 $n3 8Mb 100ms DropTail
$ns duplex-link $n2 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n4 8Mb 100ms DropTail

#---------------------------------------------------------------------------------------------------------

#purple queue limit
$ns queue-limit $n0 $n2 25^M
$ns queue-limit $n1 $n2 25^M
$ns queue-limit $n3 $n5 25^M
$ns queue-limit $n4 $n6 25^M
$ns queue-limit $n4 $n7 25^M

#orange queue limit
$ns queue-limit $n8 $n0 20^M
$ns queue-limit $n9 $n1 20^M
$ns queue-limit $n5 $n10 20^M
$ns queue-limit $n5 $n11 20^M
$ns queue-limit $n5 $n12 20^M
$ns queue-limit $n5 $n13 20^M
$ns queue-limit $n6 $n14 20^M
$ns queue-limit $n6 $n15 20^M
$ns queue-limit $n7 $n16 20^M
$ns queue-limit $n7 $n17 20^M

#black queue limit
$ns queue-limit $n2 $n3 30^M
$ns queue-limit $n2 $n4 30^M
$ns queue-limit $n3 $n4 30^M

#---------------------------------------------------------------------------------------------------------

#TCP agents with the TCP sinks
set tcp0 [new Agent/TCP]
set tcp1 [new Agent/TCP]
set tcp2 [new Agent/TCP]
set tcp3 [new Agent/TCP]
$tcp0 set class_ 2
$tcp1 set class_ 2
$tcp2 set class_ 2
$tcp3 set class_ 2
$ns attach-agent $n8 $tcp0
$ns attach-agent $n8 $tcp1
$ns attach-agent $n8 $tcp2
$ns attach-agent $n8 $tcp3

#---------------------------------------------------------------------------------------------------------

#CBR traffic generators for TCP
#to node 10
set cbr4 [new Application/Traffic/CBR]
$cbr4 set packetSize_ 1000
$cbr4 set interval_ 0.005
$cbr4 set random_ 1
$cbr4 attach-agent $tcp0

#to node 11
set cbr5 [new Application/Traffic/CBR]
$cbr5 set packetSize_ 3000
$cbr5 set interval_ 0.005
$cbr5 set random_ 1
$cbr5 attach-agent $tcp1

#to node 14
set cbr6 [new Application/Traffic/CBR]
$cbr6 set packetSize_ 2000
$cbr6 set interval_ 0.005
$cbr6 set random_ 1
$cbr6 attach-agent $tcp2

#to node 16
set cbr7 [new Application/Traffic/CBR]
$cbr7 set packetSize_ 2000
$cbr7 set interval_ 0.005
$cbr7 set random_ 1
$cbr7 attach-agent $tcp3

#---------------------------------------------------------------------------------------------------------

#creating TCP sinks
set sink0 [new Agent/TCPSink]
set sink1 [new Agent/TCPSink]
set sink2 [new Agent/TCPSink]
set sink3 [new Agent/TCPSink]
$ns attach-agent $n10 $sink0
$ns attach-agent $n11 $sink1
$ns attach-agent $n14 $sink2
$ns attach-agent $n16 $sink3

$ns connect $tcp0 $sink0
$ns connect $tcp1 $sink1
$ns connect $tcp2 $sink2
$ns connect $tcp3 $sink3

#---------------------------------------------------------------------------------------------------------

#UDP agents at Node 9
set udp0 [new Agent/UDP]
set udp1 [new Agent/UDP]
set udp2 [new Agent/UDP]
set udp3 [new Agent/UDP]
$ns attach-agent $n9 $udp0
$ns attach-agent $n9 $udp1
$ns attach-agent $n9 $udp2
$ns attach-agent $n9 $udp3

#---------------------------------------------------------------------------------------------------------

#setting a flow id to each traffic
$udp0 set fid_ 0^M
$udp1 set fid_ 1^M
$udp2 set fid_ 2^M
$udp3 set fid_ 3^M
$tcp0 set fid_ 4^M
$tcp1 set fid_ 5^M
$tcp2 set fid_ 6^M
$tcp3 set fid_ 7^M

#---------------------------------------------------------------------------------------------------------

#CBR traffic generators for UDP
#to node 12
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.005
$cbr0 set random_ 1
$cbr0 attach-agent $udp0

#to node 13
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 3000
$cbr1 set interval_ 0.005
$cbr1 set random_ 1
$cbr1 attach-agent $udp1

#to node 15
set cbr2 [new Application/Traffic/CBR]
$cbr2 set packetSize_ 2000
$cbr2 set interval_ 0.005
$cbr2 set random_ 1
$cbr2 attach-agent $udp2

#to node 17
set cbr3 [new Application/Traffic/CBR]
$cbr3 set packetSize_ 2000
$cbr3 set interval_ 0.005
$cbr3 set random_ 1
$cbr3 attach-agent $udp3

#---------------------------------------------------------------------------------------------------------

#creating the traffic sinks for UDP
set sink0 [new Agent/LossMonitor]
set sink1 [new Agent/LossMonitor]
set sink2 [new Agent/LossMonitor]
set sink3 [new Agent/LossMonitor]
$ns attach-agent $n12 $sink0
$ns attach-agent $n13 $sink1
$ns attach-agent $n15 $sink2
$ns attach-agent $n17 $sink3

#connecting the sources to the sinks
$ns connect $udp0 $sink0
$ns connect $udp1 $sink1
$ns connect $udp2 $sink2
$ns connect $udp3 $sink3

#---------------------------------------------------------------------------------------------------------

#event scheduler for the CBR agent
$ns at 1 "$cbr4 start"
$ns at 1 "$cbr5 start"
$ns at 1 "$cbr6 start"
$ns at 1 "$cbr7 start"

$ns at 2 "$cbr0 start"
$ns at 2 "$cbr1 start"
$ns at 2 "$cbr2 start"
$ns at 2 "$cbr3 start"

$ns rtmodel-at 6 down $n2 $n3
$ns rtmodel-at 7 up $n2 $n3

$ns at 10 "$cbr0 stop"
$ns at 10 "$cbr1 stop"
$ns at 10 "$cbr2 stop"
$ns at 10 "$cbr3 stop"

$ns at 10 "$cbr4 stop"
$ns at 10 "$cbr5 stop"
$ns at 10 "$cbr6 stop"
$ns at 10 "$cbr7 stop"

$ns at 10 "exit 0"

#run the simulation
$ns run
