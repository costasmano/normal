If (False:C215)
	//SC tbEnglish on layout [BMS Inspections];"Inspections In".
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	//2004-06-04 ASL
	//Restore current [BMS Inspections] record!
	Mods_2005_CM06
	
End if 

If (Not:C34(Is record loaded:C669([BMS Inspections:44])))
	USE NAMED SELECTION:C332("curCombinedInspection")
	RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
	RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
	LOAD RECORD:C52([BMS Inspections:44])
End if 
[BMS Inspections:44]Metric:14:=False:C215
PushChange(3; ->[BMS Inspections:44]Metric:14)
SAVE RECORD:C53([BMS Inspections:44])
DISPL_CUs
REDRAW WINDOW:C456