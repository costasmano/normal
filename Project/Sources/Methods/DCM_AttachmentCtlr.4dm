//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/14/09, 08:19:10
	// ----------------------------------------------------
	// Method: DCM_AttachmentCtlr
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt ("ADD" | "EDIT" | "DELETE")
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(10/28/10 08:18:28)
	Mods_2010_10
	//  `In the INIT phase check if the LB boolean array has been defined
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="iNIT")
		C_LONGINT:C283($loop_L)
		If (Type:C295(DCM_AttachmentList)=Boolean array:K8:21)
			For ($loop_L; 1; Size of array:C274(DCM_AttachmentList))
				DCM_AttachmentList{$loop_L}:=False:C215
			End for 
		End if 
		
	: ($Task_txt="ADD")
		APPEND TO ARRAY:C911(DCM_AttachmentList_atxt; "Enter new Attachment")
		OBJECT SET SCROLL POSITION:C906(DCM_AttachmentList; Size of array:C274(DCM_AttachmentList_atxt))
		EDIT ITEM:C870(DCM_AttachmentList_atxt; Size of array:C274(DCM_AttachmentList_atxt))
	: ($Task_txt="EDIT")
		If (DCM_attachmentList_atxt>0)
			C_LONGINT:C283($rowSelect_L)
			$rowSelect_L:=DCM_attachmentList_atxt
			EDIT ITEM:C870(DCM_attachmentList_atxt; $rowSelect_L)
		End if 
	: ($Task_txt="DELETE")
		If (DCM_attachmentList_atxt>0)
			C_LONGINT:C283($rowSelect_L)
			$rowSelect_L:=DCM_attachmentList_atxt
			CONFIRM:C162("Remove attachment : <"+Substring:C12(DCM_attachmentList_atxt{$rowSelect_L}; 1; 150)+"> ?")
			If (OK=1)
				DELETE FROM ARRAY:C228(DCM_attachmentList_atxt; $rowSelect_L)
			End if 
		End if 
End case 
