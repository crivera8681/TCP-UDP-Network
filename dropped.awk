BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;

   drpd_packets_flow0 = 0;
   drpd_packets_flow1 = 0;
   drpd_packets_flow2 = 0;
   drpd_packets_flow3 = 0;

}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {


       printf("%f \t %f \t %f \t %f \t %f\n", time2, drpd_packets_flow0, drpd_packets_flow1, drpd_packets_flow2, drpd_packets_flow3) > "dropped.xls";
      drpd_packets_flow0 = 0;
      drpd_packets_flow1 = 0;
      drpd_packets_flow2 = 0;
      drpd_packets_flow3 = 0;

      time1 = $2;

   }


   if ($1 == "d" && $3 == 8 && $8 == 4 && $5 == "tcp") {
      drpd_packets_flow0++;
   }

   if ($1 == "d" && $3 == 9 && $8 == 0 && $5 == "tcp") {
      drpd_packets_flow1++;
   }

   if ($1 == "d" && $3 == 8 && $8 == 6 && $5 == "tcp") {
      drpd_packets_flow2++;
   }

   if ($1 == "d" && $3 == 9 && $8 == 2 && $5 == "tcp") {
       drpd_packets_flow3++;
   }
}

END {
   print("****End of awk file****");
}

