If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/14/2006 14:58:15)
	Mods_2006_CM03
End if 

C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([Invoice_Maintenance:95]; "Invoice Maintenance In")
ADD RECORD:C56([Invoice_Maintenance:95])
vbNewRec:=False:C215
QUERY:C277([Invoice_Maintenance:95]; [Invoice_Maintenance:95]ContractNo:3=[Contract_Maintenance:97]ContractNo:1)

CM_SetupRelated(FORM Get current page:C276)