//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/23/11, 11:23:34
	// ----------------------------------------------------
	// Method: Method: TEMP_SwitchtoD6
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_02
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="DIST4"; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item2:60="06"; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]FHWARecord:174=False:C215)
	C_LONGINT:C283($Recs_L)
	C_TEXT:C284($Recs_txt)
	$Recs_txt:=String:C10(Records in selection:C76([Bridge MHD NBIS:1]))
	If ($Recs_txt="0")
		ALERT:C41("No Bridge records found!")
	Else 
		START TRANSACTION:C239
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		SHORT_MESSAGE(String:C10(Selected record number:C246([Bridge MHD NBIS:1]))+"/"+$Recs_txt+(60*" ")+Char:C90(13))
		While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
			ut_LoadRecordInteractive(->[Bridge MHD NBIS:1])
			[Bridge MHD NBIS:1]InspResp:173:="DIST6"
			MESSAGE:C88(String:C10(Selected record number:C246([Bridge MHD NBIS:1]))+"/"+$Recs_txt+":"+[Bridge MHD NBIS:1]BIN:3+"-"+[Bridge MHD NBIS:1]Item8:206+" "+[Bridge MHD NBIS:1]Item7:65+Char:C90(13))
			LogChanges(->[Bridge MHD NBIS:1]InspResp:173; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			SAVE RECORD:C53([Bridge MHD NBIS:1])
			NEXT RECORD:C51([Bridge MHD NBIS:1])
		End while 
		CLOSE WINDOW:C154
		CONFIRM:C162("Save Changes?"; "SAVE"; "CANCEL")
		If (OK=1)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
	End if 
End if 