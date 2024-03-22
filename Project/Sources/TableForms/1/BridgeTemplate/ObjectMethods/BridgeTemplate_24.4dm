//SC vTown on layout [Bridge MHD NBIS];"Bridge Input".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284(vTown)  // Command Replaced was o_C_STRING length was 26

If (Form event code:C388=On Load:K2:1)
	vTown:=[Bridge MHD NBIS:1]Town Name:175
	vTown:=vTown+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
End if 