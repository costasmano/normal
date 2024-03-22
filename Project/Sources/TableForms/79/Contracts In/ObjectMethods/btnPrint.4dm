If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:34:34)
	Mods_2007_CM12_5301
End if 

vRptDate:=Current date:C33(*)
vRptTime:=Current time:C178(*)
vCurrPage:=1

G_PrintOptions
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 

If (Ok=1)  //check to see if canceled from Print Settings
	Print form:C5([Contracts:79]; "Contracts Print 2")
	M_ContractRpt_Assignment2
	PAGE BREAK:C6
End if 