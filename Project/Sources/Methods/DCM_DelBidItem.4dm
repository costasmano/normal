//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/10, 11:11:21
	// ----------------------------------------------------
	// Method: DCM_DelBidItem
	// Description
	// 
	// 
	// Parameters
	// $1 : $RowSel_L
	// ----------------------------------------------------
	
	Mods_2010_12
End if 
C_LONGINT:C283($RowSel_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$RowSel_L:=$1
Else 
	$RowSel_L:=ITMLB_ItemNos_as
End if 
If ($RowSel_L>0)
	If (Find in array:C230(ITMLB_AE_ItemNos_as; ITMLB_ItemNos_as{$RowSel_L})>0)
		ALERT:C41("You cannot Delete an Official Bid Item from the AE database!")  //just in case
	Else 
		//Check if there is a value in the Used array
		C_BOOLEAN:C305($Used_b)
		C_TEXT:C284($DataEntered_txt; $Msg_txt)
		$DataEntered_txt:=""
		If (ITMLB_ItemQEnt_ar{$RowSel_L}>0)
			$DataEntered_txt:=" Used Q ="+String:C10(ITMLB_ItemQEnt_ar{$RowSel_L}; "###,###,###,###.00")
		End if 
		If (ITMLB_ItemQOEst_ar{$RowSel_L}>0)
			$DataEntered_txt:=$DataEntered_txt+" Office Est ="+String:C10(ITMLB_ItemQOEst_ar{$RowSel_L}; "###,###,###,###.00")
		End if 
		If (ITMLB_ItemQCEst_ar{$RowSel_L}>0)
			$DataEntered_txt:=$DataEntered_txt+" Contractor Est ="+String:C10(ITMLB_ItemQCEst_ar{$RowSel_L}; "###,###,###,###.00")
		End if 
		$Msg_txt:="Remove Item "+ITMLB_ItemNos_as{$RowSel_L}+" "+<>sQU+ITMLB_ItemDesc_atxt{$RowSel_L}+<>sQU+" ?"
		If ($DataEntered_txt#"")
			$Msg_txt:=$Msg_txt+" It has the following data entered in Projects which will be lost: "+$DataEntered_txt
		End if 
		CONFIRM:C162($Msg_txt; "DELETE"; "Cancel")
		If (OK=1)
			
			DELETE FROM ARRAY:C228(ITMLB_ItemNos_as; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemQEnt_ar; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemQOEst_ar; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemQCEst_ar; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemQ_ar; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemUnit_as; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemDesc_atxt; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemPrice_ar; $RowSel_L)
			DELETE FROM ARRAY:C228(ITMLB_ItemQRem_ar; $RowSel_L)
			[DCM_Contracts:136]ActualSpent:18:=[DCM_Contracts:136]ActualSpent:18  //modify record
			
		End if 
	End if 
	
End if 