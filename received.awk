BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;

   rcvd_packets_flow0 = 0;
   rcvd_packets_flow1 = 0;
   rcvd_packets_flow2 = 0;
   rcvd_packets_flow3 = 0;

}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {


       printf("%f \t %f \t %f \t %f \t %f\n", time2, rcvd_packets_flow0, rcvd_packets_flow1, rcvd_packets_flow2, rcvd_packets_flow3) > "received.xls";
      rcvd_packets_flow0 = 0;
      rcvd_packets_flow1 = 0;
      rcvd_packets_flow2 = 0;
      rcvd_packets_flow3 = 0;

      time1 = $2;

   }


   if ($1 == "r" && $3 == 10 && $8 == 4) {
      rcvd_packets_flow0++;
   }

   if ($1 == "r" && $3 == 12 && $8 == 0) {
      rcvd_packets_flow1++;
   }

   if ($1 == "r" && $3 == 14 && $8 == 6) {
      rcvd_packets_flow2++;
   }

   if ($1 == "r" && $3 == 15 && $8 == 2) {
       rcvd_packets_flow3++;
   }
}

END {
   print("****End of awk file****");
}

