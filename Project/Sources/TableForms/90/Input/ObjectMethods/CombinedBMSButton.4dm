If (False:C215)
	//[Combined Inspections];"Input"
	//bOpenBMS
	//Open the BMS record in combined inspection
	//Created April-2004
End if 

RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
FORM SET INPUT:C55([BMS Inspections:44]; "Inspections In")
MODIFY RECORD:C57([BMS Inspections:44])