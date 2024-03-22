If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:42:02)
	Mods_2010_12
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($OKToSave_b)
		$OKToSave_b:=False:C215
		DCM_NewItemPart_txt:=Replace string:C233(DCM_NewItemPart_txt; "_"; "")
		$OKToSave_b:=(DCM_NewItemPart_txt#"")
		$OKToSave_b:=$OKToSave_b & (DCM_NewItemDesc_txt#"")
		$OKToSave_b:=$OKToSave_b & (DCM_NewItemQ_r>0)
		If ($OKToSave_b)
			C_TEXT:C284($ConfMsg_txt)
			$ConfMsg_txt:="999."+DCM_NewItemPart_txt+" Description: "+<>sQU+DCM_NewItemDesc_txt+<>sQU+" Quantity: "+String:C10(DCM_NewItemQ_r; "###,###,###,###.000")
			CONFIRM:C162("Save Item "+$ConfMsg_txt+" ?"; "Save"; "No")
			If (OK=1)
				APPEND TO ARRAY:C911(ITMLB_ItemNos_as; ("999."+DCM_NewItemPart_txt))
				APPEND TO ARRAY:C911(ITMLB_ItemQEnt_ar; 0)
				APPEND TO ARRAY:C911(ITMLB_ItemQOEst_ar; 0)
				APPEND TO ARRAY:C911(ITMLB_ItemQCEst_ar; 0)
				APPEND TO ARRAY:C911(ITMLB_ItemQ_ar; DCM_NewItemQ_r)
				APPEND TO ARRAY:C911(ITMLB_ItemUnit_as; "$")
				APPEND TO ARRAY:C911(ITMLB_ItemDesc_atxt; DCM_NewItemDesc_txt)
				APPEND TO ARRAY:C911(ITMLB_ItemPrice_ar; 1)
				APPEND TO ARRAY:C911(ITMLB_ItemQRem_ar; DCM_NewItemQ_r)
				[DCM_Contracts:136]ActualSpent:18:=[DCM_Contracts:136]ActualSpent:18  //modify record
				
				DCM_NewItemPart_txt:=""
				DCM_NewItemDesc_txt:=""
				DCM_NewItemQ_r:=0
				GOTO OBJECT:C206(DCM_NewItemPart_txt)
			Else 
				
			End if 
			
		Else 
			ALERT:C41("There is missing information !! Please Complete all items!")
			Case of 
				: (DCM_NewItemPart_txt="")
					GOTO OBJECT:C206(DCM_NewItemPart_txt)
				: (DCM_NewItemDesc_txt="")
					GOTO OBJECT:C206(DCM_NewItemDesc_txt)
				: (DCM_NewItemQ_r<=0)
					GOTO OBJECT:C206(DCM_NewItemQ_r)
			End case 
			
		End if 
End case 
