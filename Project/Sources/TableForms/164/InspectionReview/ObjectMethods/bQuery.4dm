
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/07/15, 13:09:50
//----------------------------------------------------
//Object Method: [LSS_Inspection].InspectionReview.bQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
QUERY SELECTION:C341(Current form table:C627->)

If (OK=1)
	Header1:=0
	Header2:=0
	Header3:=0
	Header4:=0
	Header5:=0
	Header6:=0
	Header7:=0
	If (False:C215)
		// Modified by: Costas Manousakis-(Designer)-(11/29/18 14:47:28)
		Mods_2018_11
		//  `hide the review and print buttons
	End if 
	
	//hide the review and print buttons
	OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
	OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
	
	LSS_SortInspReview
	WIN_SetWindowTitle(Current form table:C627)
End if 


//End Object Method: [LSS_Inventory].ListBoxOutput.bQuery

