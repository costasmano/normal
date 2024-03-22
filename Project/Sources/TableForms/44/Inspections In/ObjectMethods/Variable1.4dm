//SC bAddCU on layout [BMS Inspections];"Inspections In"
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//Add a Condition Unit to a Pontis inspection report.

//TRACE

FORM SET INPUT:C55([Cond Units:45]; "Cond Units In")
//While (OK=1)
ADD RECORD:C56([Cond Units:45]; *)
//End while 