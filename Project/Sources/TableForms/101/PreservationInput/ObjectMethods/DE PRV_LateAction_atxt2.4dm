//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_ProjectStatus_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/01/13, 11:46:02
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
End if 
//
PRV_PopupMenuC(->PRV_LateAction_atxt; ->PRV_LateAction_atxt; ->[Contract_Assignment_Maintenance:101]LateAction_s:79; "Enter Action")

If (Form event code:C388=On Clicked:K2:4)
	If ([Contract_Assignment_Maintenance:101]LateAction_s:79="Other:")
		[Contract_Assignment_Maintenance:101]LateAction_s:79:="Enter Action"
		GOTO OBJECT:C206([Contract_Assignment_Maintenance:101]LateAction_s:79)
		POST KEY:C465(Tab key:K12:28)
		POST KEY:C465(Tab key:K12:28; Shift key bit:K16:4)
	End if 
	
End if 
//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_ProjectStatus_atxt