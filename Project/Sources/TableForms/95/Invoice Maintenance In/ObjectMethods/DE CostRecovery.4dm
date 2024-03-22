If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(3/19/09 09:30:59)
	Mods_2009_CM_5404
	//Added this for cost recovery
End if 

If (Self:C308->=1)
	CONFIRM:C162("Add Cost Recovery in this Invoice?")
	If (OK=1)
		OBJECT SET ENTERABLE:C238([Invoice_Maintenance:95]CostRecovery:17; True:C214)
	Else 
		Self:C308->:=0
	End if 
	
Else 
	C_BOOLEAN:C305($continue)
	$continue:=True:C214
	If ([Invoice_Maintenance:95]CostRecovery:17>0)
		CONFIRM:C162("Clear the Cost Recovery for this assignment?")
		$continue:=(OK=1)
	End if 
	If ($continue)
		OBJECT SET ENTERABLE:C238([Invoice_Maintenance:95]CostRecovery:17; False:C215)
		[Invoice_Maintenance:95]CostRecovery:17:=0
	End if 
	
End if 