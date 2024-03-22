If (False:C215)
	// S. Hwang - April 2006
	//Mods_2006_SH01 
End if 

ScourReport_CreateRecord
MODIFY RECORD:C57([Scour Report:129])
ALL RECORDS:C47([Scour Report:129])
ORDER BY:C49([Scour Report:129]; [Scour Report:129]ReportDate:1; <)
WindowTitle

