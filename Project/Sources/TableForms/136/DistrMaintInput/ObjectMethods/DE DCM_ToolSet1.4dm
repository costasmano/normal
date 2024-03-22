If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:44:38)
	Mods_2010_12
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		DCM_CompRates("INIT")
		DCM_CompRates("LOAD")
		Self:C308->:=1
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Choise_L)
		C_TEXT:C284($Choise_txt)
		$Choise_L:=Self:C308->
		$Choise_txt:=Self:C308->{$Choise_L}
		
		Case of 
			: ($Choise_txt="@Update Quantities@")
				SHORT_MESSAGE("Re Calculating....")
				DCM_ContrBidItems("SUMWOS")
				CLOSE WINDOW:C154
				
			: ($Choise_txt="@Add 999. Bid Item@")
				C_LONGINT:C283($newWin_L)
				C_REAL:C285(DCM_NewItemQ_r)
				C_TEXT:C284(DCM_NewItemPart_txt; DCM_NewItemDesc_txt)
				C_LONGINT:C283($WinW_L; $WinH_L)
				FORM GET PROPERTIES:C674([DCM_Contracts:136]; "AddItem999Dlg"; $WinW_L; $WinH_L)
				NewWindow($WinW_L; $WinH_L; 0; Plain window:K34:13; "New Bid Item Entry")
				//$newWin_L:=Open form window([DCM_Contracts];"AddItem999Dlg";Pop up form window )
				DIALOG:C40([DCM_Contracts:136]; "AddItem999Dlg")
				CLOSE WINDOW:C154
				SORT ARRAY:C229(ITMLB_ItemNos_as; ITMLB_ItemUnit_as; ITMLB_ItemDesc_atxt; ITMLB_ItemQ_ar; ITMLB_ItemPrice_ar; ITMLB_ItemQEnt_ar; ITMLB_ItemQOEst_ar; ITMLB_ItemQCEst_ar; ITMLB_ItemQRem_ar)
				REDRAW:C174(LineItems_lb)
				
			: ($Choise_txt="@Delete 999. Bid Item@")
				C_LONGINT:C283($RowSel_L)
				$RowSel_L:=ITMLB_ItemNos_as
				If ($RowSel_L>0)
					If (Find in array:C230(ITMLB_AE_ItemNos_as; ITMLB_ItemNos_as{$RowSel_L})>0)
						ALERT:C41("You cannot Delete an Official Bid Item from the AE database!")
					Else 
						DCM_DelBidItem($RowSel_L)
					End if 
					
				Else 
					ALERT:C41("You have not Selected a Bid Item to Delete! Reminder : It must be an Added Item!")
				End if 
				
			: ($Choise_txt="@Edit Compensation Rates@")
				DCM_CompRates("MODIFY")
				
		End case 
		Self:C308->:=1
End case 

