//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_PreservReviewer_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/06/13, 10:08:40
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
End if 
//
POPUPMENUC(->PRV_PreservReviewer_atxt; ->PRV_PreservReviewer_ai; ->[Contract_Assignment_Maintenance:101]ProjectManagerID_L:39)

If (Find in array:C230(PRV_PreservReviewer_ai; [Contract_Assignment_Maintenance:101]ProjectManagerID_L:39)>0)
	PRV_PreservReviewer_txt:=PRV_PreservReviewer_atxt{Find in array:C230(PRV_PreservReviewer_ai; [Contract_Assignment_Maintenance:101]ProjectManagerID_L:39)}
Else 
	PRV_PreservReviewer_txt:=""
End if 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_PreservReviewer_atxt