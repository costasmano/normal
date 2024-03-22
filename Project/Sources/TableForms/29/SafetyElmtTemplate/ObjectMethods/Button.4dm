//Object Method: [ElementsSafety].SafetyElmtTemplate.Button 
//Description
//  `For Designer users - to alow recreating of the entries in the activity log table
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/6/13
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		ALERT:C41("Current Record ID : "+String:C10([ElementsSafety:29]ElmSafetyID:7)+" Element Dict No "+String:C10([ElementsSafety:29]ElementNo:1))
		CONFIRM:C162("Launch Relog utility in a separate process?")
		If (OK=1)
			C_LONGINT:C283($Lpid)
			$Lpid:=LSpawnProcess("ut_RelogRecords"; <>LStackSize; "ReLogActivity"; True:C214; False:C215)
		End if 
End case 

//End Object Method: [Standard Photos].Standard Photos.Button