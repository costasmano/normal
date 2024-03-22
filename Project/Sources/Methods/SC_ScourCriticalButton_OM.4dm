//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/12/13, 13:02:42
//----------------------------------------------------
//Method: SC_ScourCriticalButton_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 ` 
	//Modified by: Charles Miller (2/12/13 13:02:44)
	Mods_2013_02  //r001 `  Remove [BridgeInfoLink] updates as we are going to update data on add only
	//Modified by: Charles Miller (2/26/13 16:29:43)
End if 

C_TEXT:C284($CurrUser_txt)
$CurrUser_txt:=<>CurrentUser_Name
C_BOOLEAN:C305($EditScourCritical_b)

$EditScourCritical_b:=(User in group:C338($CurrUser_txt; "ScourCritical") | User in group:C338($CurrUser_txt; "Design Access Group"))

If ($EditScourCritical_b)
	
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
	READ ONLY:C145([Bridge MHD NBIS:1])
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	
	FORM SET INPUT:C55([ScourCriticalInfo:150]; "Input")
	
	QUERY:C277([ScourCriticalInfo:150]; [ScourCriticalInfo:150]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	FORM SET INPUT:C55([ScourCriticalInfo:150]; "Input")
	If (Records in selection:C76([ScourCriticalInfo:150])=1)
		C_LONGINT:C283($Return_l)
		
		$Return_l:=ut_LoadRecordInteractiveV2(->[ScourCriticalInfo:150])
		Case of 
				
			: ($Return_l=1)
				MODIFY RECORD:C57([ScourCriticalInfo:150])
				UNLOAD RECORD:C212([ScourCriticalInfo:150])
				READ ONLY:C145([ScourCriticalInfo:150])
				
			: ($Return_l=2)
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				UNLOAD RECORD:C212([Bridge MHD NBIS:1])
				UNLOAD RECORD:C212([ScourCriticalInfo:150])
				READ ONLY:C145([Bridge MHD NBIS:1])
				READ ONLY:C145([ScourCriticalInfo:150])
				LOAD RECORD:C52([ScourCriticalInfo:150])
				LOAD RECORD:C52([Bridge MHD NBIS:1])
				DIALOG:C40([ScourCriticalInfo:150]; "Input")
				
		End case 
		
	Else 
		
		READ WRITE:C146([ScourCriticalInfo:150])
		ADD RECORD:C56([ScourCriticalInfo:150])
		
	End if 
End if 
//End SC_ScourCriticalButton_OM

