If (False:C215)
	Mods_2004_CJM02
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:58:15)
	Mods_2006_CM03
End if 

C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([FundTransfer_Maintenance:96]; "TransferFund In")
ADD RECORD:C56([FundTransfer_Maintenance:96])
vbNewRec:=False:C215
RELATE MANY:C262([Contract_Maintenance:97])

CM_SetupRelated(FORM Get current page:C276)