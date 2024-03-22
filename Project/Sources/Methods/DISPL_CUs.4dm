//%attributes = {"invisible":true}
If (False:C215)
	//GP DISPL_CUs
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	//Select and sort Condition Units.
	
	Mods_2005_CM06
	
	//RELATE MANY([BMS Inspections])
	// Modified by: costasmanousakis-(Designer)-(2/11/11 09:11:34)
	Mods_2011_02
	//  `  `Do not search for [Cond Units] if [BMS Inspections]Inspection ID less than 1
End if 

If ([BMS Inspections:44]Inspection ID:1>0)
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=[BMS Inspections:44]Inspection ID:1)
	ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
Else 
	REDUCE SELECTION:C351([Cond Units:45]; 0)
End if 