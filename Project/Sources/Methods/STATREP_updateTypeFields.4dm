//%attributes = {"invisible":true}
//Method: STATREP_updateTypeFields
//Description
// update the new type fields based on the text in the comments
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/15/18, 12:33:11
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
ALL RECORDS:C47([Status Report:69])
C_OBJECT:C1216($progress_o)
//start the bar
C_OBJECT:C1216($progress_o)
$progress_o:=ProgressNew("Scanning Status reports"; Records in selection:C76([Status Report:69]); False:C215; " Records"; 3)

CREATE EMPTY SET:C140([Status Report:69]; "StatRepUnknown")
FIRST RECORD:C50([Status Report:69])
While (Not:C34(End selection:C36([Status Report:69])))
	//update progress
	UpdateProgressNew($progress_o; Selected record number:C246([Status Report:69]))
	
	Case of 
		: ([Status Report:69]Comments:135="Transition to @")
			[Status Report:69]UseLegacyOwner_b:266:=False:C215
			[Status Report:69]DistrictMethod_L:267:=2
		: ([Status Report:69]Comments:135="6 District report@")
			[Status Report:69]UseLegacyOwner_b:266:=False:C215
			[Status Report:69]DistrictMethod_L:267:=4
		: ([Status Report:69]Comments:135="Report Generated@")
			[Status Report:69]UseLegacyOwner_b:266:=False:C215
			[Status Report:69]DistrictMethod_L:267:=3
		: ([Status Report:69]Comments:135="Legacy@")
			[Status Report:69]UseLegacyOwner_b:266:=True:C214
			[Status Report:69]DistrictMethod_L:267:=3
		: ([Status Report:69]Date_Created:1>=!2009-11-01!)
			[Status Report:69]UseLegacyOwner_b:266:=False:C215
			[Status Report:69]DistrictMethod_L:267:=2
		: ([Status Report:69]Date_Created:1<!2009-11-01!)
			[Status Report:69]UseLegacyOwner_b:266:=True:C214
			[Status Report:69]DistrictMethod_L:267:=3
			
		Else 
			ADD TO SET:C119([Status Report:69]; "StatRepUnknown")
	End case 
	
	SAVE RECORD:C53([Status Report:69])
	NEXT RECORD:C51([Status Report:69])
End while 
//quit progress
Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))

ALERT:C41("There are "+String:C10(Records in set:C195("StatRepUnknown"))+" Unknown types of reports")
USE SET:C118("StatRepUnknown")
CLEAR SET:C117("StatRepUnknown")

//End STATREP_updateTypeFields