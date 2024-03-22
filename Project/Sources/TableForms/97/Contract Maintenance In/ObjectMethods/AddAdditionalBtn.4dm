If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:58:15)
	Mods_2006_CM03
	Mods_2007_CJM_v5302  //r001 `10/02/07, 11:26:24
End if 

C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([AddFund_Maintenance:99]; "AddFun In")
ADD RECORD:C56([AddFund_Maintenance:99])
vbNewRec:=False:C215
RELATE MANY:C262([Contract_Maintenance:97])

CM_SetupRelated(FORM Get current page:C276)