If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:45:33)
	Mods_2010_12
End if 

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($TestNo_txt)
		$TestNo_txt:="999."+DCM_NewItemPart_txt
		If (Find in array:C230(ITMLB_ItemNos_as; $TestNo_txt)>0)
			
			ALERT:C41("Item "+$TestNo_txt+" : "+ITMLB_ItemDesc_atxt{Find in array:C230(ITMLB_ItemNos_as; $TestNo_txt)}+" Exists Already")
			GOTO OBJECT:C206(DCM_NewItemPart_txt)
			POST KEY:C465(Tab key:K12:28)
			POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
			
		End if 
		
End case 