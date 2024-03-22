//%attributes = {"invisible":true}
// Method: SCPOA_POABtnCtrl
// Description
// Control appearance/behavior of Scour POA button on Bridge Input Form
// 
// Parameters
// $1 : $username_txt (optional)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/07/09, 11:05:12
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(12/10/09 09:12:05)
	Mods_2009_12  //Copied to Server on : 12/10/09, 16:34:49
	//Changes/Additions for new version of POA
	// Modified by: costasmanousakis-(Designer)-(12/16/09 11:43:34)
	Mods_2009_12
	//Allow creation of POAs only on Client connected to the MHD BMS server; also do
	//a check for Item113 and FHWARecord
	// Modified by: costasmanousakis-(Designer)-(12/17/09 13:22:32)
	Mods_2009_12
	//  `Use the system parameter SC_Item113Filter to come up with the item 113 filter
	// Modified by: costasmanousakis-(Designer)-(2/2/10 09:21:52)
	Mods_2010_02
	//  `add a check if the user is externaldesigner/inspector then check if the poa is assigned 
	//  `to his company and then allow edit
	// Modified by: costasmanousakis-(Designer)-(4/1/10 16:32:44)
	Mods_2010_04
	//Load and the unload scpoa record to find the consultant assigned to it.
	//Dont use the Query Destination option. Caused SCPOA button not to be enables in some cases.
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 09:14:03)
	Mods_2013_05
	//  `use variable ◊DatabaseStructureName_txt
	// Modified by: Costas Manousakis-(Designer)-(5/27/15 09:38:02)
	Mods_2015_05
	//  `remove M Nabulsi from the edit group 
	// Modified by: Costas Manousakis-(Designer)-(4/20/17 12:34:46)
	Mods_2017_04
	//  `For SCOURPOAEDIT users allow view option if  POA is not their company
End if 
C_TEXT:C284($username_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$username_txt:=$1
Else 
	$username_txt:=<>CurrentUser_Name
End if 

C_LONGINT:C283($ScourPOA_L)
READ ONLY:C145([ScourPOA:132])
//SET QUERY DESTINATION(Into variable ;$ScourPOA_L)
QUERY:C277([ScourPOA:132]; [ScourPOA:132]BIN:2=[Bridge MHD NBIS:1]BIN:3)
$ScourPOA_L:=Records in selection:C76([ScourPOA:132])
//SET QUERY DESTINATION(Into current selection )
C_LONGINT:C283(SCPOA_INPUTMODE_L)
SCPOA_INPUTMODE_L:=0
OBJECT SET TITLE:C194(*; "bScourPOA"; "Scour POA")

If ($ScourPOA_L>0)
	//There is a scour POA record
	FIRST RECORD:C50([ScourPOA:132])
	LOAD RECORD:C52([ScourPOA:132])
	Case of 
		: ($username_txt="Designer")
			SCPOA_INPUTMODE_L:=1  //edit
		: (User in group:C338($username_txt; "SCOURPOAINIT"))
			SCPOA_INPUTMODE_L:=1  //edit
		: (User in group:C338($username_txt; "SCOURPOAEDIT"))
			If (User in group:C338($username_txt; "ExternalDesigners") | User in group:C338($username_txt; "ExternalInspectors"))
				
				If (([ScourPOA:132]Consultant:26=<>PERS_MyCompany_txt) & ([ScourPOA:132]Consultant:26#""))
					SCPOA_INPUTMODE_L:=1  //edit
				Else 
					//SCPOA_INPUTMODE_L:=0  `not allowed
					//DISABLE BUTTON(*;"bScourPOA")
					SCPOA_INPUTMODE_L:=2  //view only
					//DISABLE BUTTON(*;"bScourPOA")
					
				End if 
			Else 
				SCPOA_INPUTMODE_L:=1  //edit
			End if 
		: (User in group:C338($username_txt; "SCOURPOAVIEW"))
			SCPOA_INPUTMODE_L:=2  //view only
		Else 
			OBJECT SET ENABLED:C1123(*; "bScourPOA"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End case 
	UNLOAD RECORD:C212([ScourPOA:132])
Else 
	Case of 
		: ($username_txt="Designer")
			OBJECT SET TITLE:C194(*; "bScourPOA"; "Init Scour POA")
			SCPOA_INPUTMODE_L:=1  //edit
		: (User in group:C338($username_txt; "SCOURPOAINIT"))
			OBJECT SET ENABLED:C1123(*; "bScourPOA"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			C_TEXT:C284($ITEM113Filter_txt; $ITEM113FilterExpl_txt)
			$ITEM113Filter_txt:=ut_GetSysParameter("SC_Item113Filter"; ",0,1,2,3,6,D,U,"; "VALUE")
			
			If ((Application type:C494=4D Remote mode:K5:5) & (Structure file:C489="MHD BMS.@"))
				If ((Position:C15((","+[Bridge MHD NBIS:1]Item113:151+","); $ITEM113Filter_txt)>0) & ([Bridge MHD NBIS:1]FHWARecord:174))
					OBJECT SET ENABLED:C1123(*; "bScourPOA"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					OBJECT SET TITLE:C194(*; "bScourPOA"; "Init Scour POA")
					SCPOA_INPUTMODE_L:=1  //edit
				End if 
			End if 
			//: ($username_txt="Mohammed Nabulsi")
			//SCPOA_INPUTMODE_L:=1  `edit
		Else 
			OBJECT SET ENABLED:C1123(*; "bScourPOA"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			//BUTTON TEXT(*;"bScourPOA";"N/A")
	End case 
	
End if 
READ WRITE:C146([ScourPOA:132])