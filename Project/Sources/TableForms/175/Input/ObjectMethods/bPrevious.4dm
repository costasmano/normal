
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 10:27:28
//----------------------------------------------------
//Method: Object Method: [LSS_UT].Input.bPrevious
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 10:27:29)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($Tip_txt)
		$Tip_txt:="Previous Ultrasonic Test (PgUp)"
		
		If (<>PL_LPlatfrm=Mac OS:K25:2)
		Else 
			$Tip_txt:=Replace string:C233($Tip_txt; "Cmd"; "CTRL")
		End if 
		OBJECT SET HELP TIP:C1181(Self:C308->; $Tip_txt)
		OBJECT SET SHORTCUT:C1185(Self:C308->; Shortcut with Page up:K75:25; 0)
		
	: (Form event code:C388=On Clicked:K2:4)
		LSS_UTRow_L:=LSS_UTRow_L-1
		FM_SaveUT
		
		GOTO SELECTED RECORD:C245([LSS_UT:175]; LSS_UTRow_L)
		
		FM_UTInput(On Load:K2:1)
		
End case 
//End Object Method: [LSS_UT].Input.bPrevious