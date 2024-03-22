//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/16/12, 14:30:05
//----------------------------------------------------
//Method: [Bridge MHD NBIS];"Bridge Input".RatingReports
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/16/12 14:30:06)
	Mods_2018_02  //add group MoveRatingReports to [PERS_Groups] and walter gustafson to that group
	// Modified by: Costas Manousakis-(Designer)-(5/9/18 13:59:52)
	Mods_2018_05
	//  `add on display detail
	// Modified by: Costas Manousakis-(Designer)-(12/4/19 14:24:57)
	Mods_2019_12
	//  `fix logic check to set visible the move button  
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		SIA_OnDisplayDetail
		
	: (Form event code:C388=On Double Clicked:K2:5)
		SIA_ControlDoubleClick
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($column_l; $row_l)
		OBJECT SET VISIBLE:C603(*; "MoveRatingReport@"; False:C215)
		LISTBOX GET CELL POSITION:C971(*; "RatingReports"; $column_l; $row_l)
		If ($row_l>=1) & ($row_l<=Records in selection:C76([RatingReports:65]))
			GOTO SELECTED RECORD:C245([RatingReports:65]; $Row_L)
			If (GRP_4DUIDinGroup(<>CurrentUser_UID; "MoveRatingReports")=1) | (<>CurrentUser_Name="Designer")
				
				OBJECT SET VISIBLE:C603(*; "MoveRatingReport@"; True:C214)
			End if 
		End if 
End case 
//End Object Method: 