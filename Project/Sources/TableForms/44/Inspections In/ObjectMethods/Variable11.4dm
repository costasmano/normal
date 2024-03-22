//SC bPrint on layout [Cond Units];"Cond Units Prt".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
Mods_2004_VN01

ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)

CONFIRM:C162("Please select either field form or final form button for print out."; "Final Form"; "Field Form")

If (OK=1)
	FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt 2")
Else 
	FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt")
End if 

//Print out the selected form
PRINT SELECTION:C60([Cond Units:45])