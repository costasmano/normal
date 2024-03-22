If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 15:04:14)
	Mods_2007_CM12_5301
End if 

C_TEXT:C284($menuChoise_txt)
C_BOOLEAN:C305($Exporting_b)

If (Shift down:C543)
	$menuChoise_txt:="Projis Update"
	$Exporting_b:=True:C214
Else 
	$menuChoise_txt:="Projis Update;Summary Page"
	$Exporting_b:=False:C215
End if 

C_LONGINT:C283($UserChoice_L)
If (Records in selection:C76([PRJ_ProjectDetails:115])>0)
	
	$UserChoice_L:=Pop up menu:C542($menuChoise_txt)
	Case of 
		: ($UserChoice_L=1)
			If ($Exporting_b)
				PRJ_ExpProjUpdate
			Else 
				PRJ_PrintProjisUpdate
			End if 
			
		: ($UserChoice_L=2)
			PRJ_PrintSummarySht
		Else 
	End case 
	
Else 
	ALERT:C41("There are no Projects Listed!")
End if 
