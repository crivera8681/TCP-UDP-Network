BEGIN{
    time1 = 0.0;
    time2 = 0.0;
    timeInterval = 0.0;
    bytes_counter_flow0 = 0;
    bytes_counter_flow1 = 0;
    bytes_counter_flow2 = 0;
    bytes_counter_flow3 = 0;
}

{
    time2 = $2;

    timeInterval = time2 - time1;

    if(timeInterval > 0.5)
    {
	throughput_flow0 = bytes_counter_flow0 / timeInterval;
	throughput_flow1 = bytes_counter_flow1 / timeInterval;
	throughput_flow2 = bytes_counter_flow2 / timeInterval;
	throughput_flow3 = bytes_counter_flow3 / timeInterval;

	printf("%f \t %f \t %f \t %f \t %f\n", time2, throughput_flow0, throughput_flow1, throughput_flow2, throughput_flow3) > "test1_thro\
ughput.xls";

	bytes_counter_flow0 = 0;
	bytes_counter_flow1 = 0;
	bytes_counter_flow2 = 0;
	bytes_counter_flow3 = 0;

	time1 = $2;
    }

    if ($1 == "r" && $4 == 10 && $8 == 4) {
	bytes_counter_flow0 += $6;
    }
    if ($1 == "r" && $4 == 12 && $8 == 0) {
	bytes_counter_flow1 += $6;
    }
    if ($1 == "r" && $4 == 14 && $8 == 6) {
	bytes_counter_flow2 += $6;
    }
    if ($1 == "r" && $4 == 15 && $8 == 2) {
        bytes_counter_flow3 += $6;
    }
}

END {
    print("END");
}