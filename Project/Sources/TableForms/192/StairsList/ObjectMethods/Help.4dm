//Method: [BridgeStairs].StairsList.Help
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-18T00:00:00, 10:27:15
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
End if 
//
C_TEXT:C284($HelpMsg_txt)
$HelpMsg_txt:="Click the + button to add stair records\n"+\
"Click the - button to delete a selected stair record\n"+\
"Right-click on Owner to change; Double-click on Description to edit\n"+\
"Save button will save all changes made and close this window\n"+\
"Cancel will close the window without making any changes"
$HelpMsg_txt:=ut_GetSysParameter("SIA_StairsHelpMsg"; $HelpMsg_txt)

ALERT:C41($HelpMsg_txt)
//End [BridgeStairs].StairsList.Help