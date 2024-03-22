//%attributes = {"invisible":true}
//Method: NTI_ReviewList_FM
//Description
// Form Method for the TIN Inspection Review form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/12/16, 12:24:53
	// ----------------------------------------------------
	//Created : 
	Mods_2016_09
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		LB_Header2_l:=1
		InDoubleClick_B:=False:C215
		LB_Tasks("ADDTOLIST"; "TunnelInspections"; "Pending Inspections"; "Input"; ->[TIN_Inspections:184]InspectionID:2)
		LISTBOX SET STATIC COLUMNS:C1153(*; "TunnelInspections_LB"; 10)
	: (Form event code:C388=On Validate:K2:3)
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
End case 

//End NTI_ReviewList_FM