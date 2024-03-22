//Method: Object Method: [LSS_Inspection];"InspectionReview".LSS_Print_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 15:06:34
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
End if 
//

C_BOOLEAN:C305($DoPrint_b)
$DoPrint_b:=True:C214
If (Records in set:C195("InspReviewSelect")>1)
	CONFIRM:C162("Multiple Inspections selected!  Are you sure you want to print "+String:C10(Records in set:C195("InspReviewSelect"))+" reports?")
	$DoPrint_b:=(OK=1)
End if 
C_LONGINT:C283($LBCol_L; $LBRow_L)
If ($DoPrint_b)
	
	If (Records in set:C195("InspReviewSelect")>0)
		LSS_PrintMultipleInspections
		
	Else 
		ALERT:C41("You have not selected any records!")
	End if 
	
Else 
	//GET LISTBOX CELL POSITION(*;"Inspection_LB";$LBCol_L;$LBRow_L)
	//If ($LBRow_L>0)
	//GOTO SELECTED RECORD([LSS_Inspection];$LBRow_L)
	//If (Is in set("InspReviewSelect"))
	//LOAD RECORD([LSS_Inspection])
	//QUERY([LSS_Inventory];[LSS_Inventory]LSS_InventoryId_s=[LSS_Inspection]LSS_InventoryId_s)
	//LSS_LoadArraysForInputForm 
	//
	//LSS_PrintInspection 
	//
	//End if 
	//
	//End if 
	
End if 

//End Object Method: [LSS_Inspection].InspectionReview.LSS_Print_L