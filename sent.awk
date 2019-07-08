BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;

   sent_packets_flow0 = 0;
   sent_packets_flow1 = 0;
   sent_packets_flow2 = 0;
   sent_packets_flow3 = 0;

}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {


       printf("%f \t %f \t %f \t %f \t %f\n", time2, sent_packets_flow0, sent_packets_flow1, sent_packets_flow2, sent_packets_flow3) > "sent.xls";
      sent_packets_flow0 = 0;
      sent_packets_flow1 = 0;
      sent_packets_flow2 = 0;
      sent_packets_flow3 = 0;

      time1 = $2;

   }


   if ($1 == "-" && $3 == 8 && $8 == 4) {
      sent_packets_flow0++;
   }

   if ($1 == "-" && $3 == 9 && $8 == 0) {
      sent_packets_flow1++;
   }

   if ($1 == "-" && $3 == 8 && $8 == 6) {
      sent_packets_flow2++;
   }

   if ($1 == "-" && $3 == 9 && $8 == 2) {
       sent_packets_flow3++;
   }
}

END {
   print("****End of awk file****");
}

