// ----------------------------------------------------
// Object Method: PRJ_Button_l
// User name (OS): cjmiller
// Date and time: 03/30/06, 10:02:39
// ----------------------------------------------------
// Description
// This method will set up the many records on the summary page
//It will set a variable to identify which table we are in
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //10/19/06, 12:08:22`add double click to to button to move directly to report page
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($GotoPage_b)
		$GotoPage_b:=True:C214
		C_LONGINT:C283($Page_l)
		
		$Page_l:=0
		Case of 
			: (PRJ_Detail_s="Go to Reports")
				$Page_l:=3
			: (PRJ_Detail_s="Go to Type Study")
				$Page_l:=4
			: (PRJ_Detail_s="Go to Sketch Plans")
				$Page_l:=5
			: (PRJ_Detail_s="Go to Structural Review")
				$Page_l:=6
			Else 
				$GotoPage_b:=False:C215
		End case 
		If ($GotoPage_b)
			PRJProjectTabs_as:=$Page_l
			PRJ_ControlPageMovement
		End if 
End case 