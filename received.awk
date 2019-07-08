BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;

   gen_packets_flow0 = 0;
   gen_packets_flow1 = 0;
   gen_packets_flow2 = 0;
   gen_packets_flow3 = 0;

}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {


       printf("%f \t %f \t %f \t %f\n", time2, gen_packets_flow0, gen_packets_flow1, gen_packets_flow2, gen_packets_flow3) > "generator.xls";
      gen_packets_flow0 = 0;
      gen_packets_flow1 = 0;
      gen_packets_flow2 = 0;
      gen_packets_flow3 = 0;

      time1 = $2;

   }


   if ($1 == "+" && $3 == 10 && $8 == 4) {
      gen_packets_flow0++;
   }

   if ($1 == "+" && $3 == 12 && $8 == 0) {
      gen_packets_flow1++;
   }

   if ($1 == "+" && $3 == 14 && $8 == 6) {
      gen_packets_flow2++;
   }

   if ($1 == "+" && $3 == 15 && $8 == 2) {
       gen_packets_flow3++;
   }
}

END {
   print("****End of awk file****");
}

