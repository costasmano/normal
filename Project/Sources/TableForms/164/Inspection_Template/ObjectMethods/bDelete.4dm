
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/26/15, 14:04:52
//----------------------------------------------------
//Method: Object Method: [LSS_Inspection].Inspection_Template.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/26/15 14:04:58)
	// Modified by: Costas Manousakis-(Designer)-(5/27/16 09:11:40)
	Mods_2016_05_bug
	//  `added missing SET QUERY DESTINATION(Into current selection)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 

C_TEXT:C284($Confirm_txt; $Remainder_txt)
ARRAY LONGINT:C221($Counts_AL; 0)
ARRAY TEXT:C222($Tables_atxt; 0)
C_LONGINT:C283($Count_L)

If (([LSS_Inspection:164]LSS_Approved_L:43#BMS Not Reviewed) | ([LSS_Inspection:164]LSS_Approved_L:43#BMS Not Reviewed))
	$Confirm_txt:="Do you "+Current user:C182+" really want to delete this Inspection record, "
	$Confirm_txt:=$Confirm_txt+"which is in the Review process,"
Else 
	$Confirm_txt:="Do you "+Current user:C182+" really want to delete this inspection record "
End if 

SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
Case of 
	: ($Count_L>1)
		$Remainder_txt:=" its "+String:C10($Count_L)+" elements"
	: ($Count_L=1)
		$Remainder_txt:=" its element "
	Else 
		
End case 

SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
Case of 
	: ($Count_L>1)
		If ($Remainder_txt="")
			$Remainder_txt:=" its "+String:C10($Count_L)+" photo"
		Else 
			$Remainder_txt:=$Remainder_txt+" and its "+String:C10($Count_L)+" photos"
		End if 
	: ($Count_L=1)
		If ($Remainder_txt="")
			$Remainder_txt:="its "+String:C10($Count_L)+" photo"
		Else 
			$Remainder_txt:=$Remainder_txt+" and its photos"
		End if 
		
	Else 
		
End case 
CONFIRM:C162($Confirm_txt+$Remainder_txt+" ?"; "DELETE"; "Skip")
If (OK=1)
	C_LONGINT:C283($passwordErr_L)
	$Confirm_txt:="! ! ! WARNING : To Delete the entire Inspection, your password is required ! ! !"+<>sCR+"Enter your password to Delete the entire inspection or Cancel to abort the deleti"+"on!!"
	$Confirm_txt:=Uppercase:C13($Confirm_txt)
	$passwordErr_L:=OP_GetPassword($Confirm_txt)
	
	If ($passwordErr_L=0)
		C_TEXT:C284($ErrorMethodCalled_txt)
		$ErrorMethodCalled_txt:=Method called on error:C704
		ON ERR CALL:C155("LSS_ErrorMethod")
		ONE RECORD SELECT:C189([LSS_Inspection:164])
		LogDeletion(->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; 1)
		C_BOOLEAN:C305($Skip_B)
		
		$Skip_B:=LSS_ControlDeleteOfInspection
		If (LSS_DuplicateRecordError_B | LSS_Error_B)
			CANCEL TRANSACTION:C241
			ALERT:C41("Inspection record not deleted")
		Else 
			If ($Skip_B)
				CANCEL TRANSACTION:C241
				ALERT:C41("Inspection record not deleted")
			Else 
				VALIDATE TRANSACTION:C240
			End if 
			CANCEL:C270
		End if 
	End if 
	ON ERR CALL:C155($ErrorMethodCalled_txt)
	LSS_SelectInspectionsForInvItem
	
	START TRANSACTION:C239
End if 

//End Object Method: [LSS_Inspection].Inspection_Template.bDelete