//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/24/06, 14:51:03
	// ----------------------------------------------------
	// Method: INSP_UWDate_OM
	// Description
	// Code for the UW date object in routine Above water inspections.
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
End if 
C_POINTER:C301($1; $InspDateFld_ptr)
$InspDateFld_ptr:=$1
PushChange(1; $InspDateFld_ptr)
If (($InspDateFld_ptr->=!00-00-00!))
	SET QUERY DESTINATION:C396(Into set:K19:2; "NumElemtsWDiveRtg")
	QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2; *)
	QUERY:C277([ElementsSafety:29];  & ; [ElementsSafety:29]AltRating:21#"N"; *)
	QUERY:C277([ElementsSafety:29];  & ; [ElementsSafety:29]AltRating:21#"")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	C_LONGINT:C283($numRecs)
	$numRecs:=Records in set:C195("NumElemtsWDiveRtg")
	If ($numRecs>0)
		CONFIRM:C162("This inspection has "+String:C10($numRecs)+" Elements that have individual Dive ratings! Do you wish to cl"+"ear the Dive ratings for these Elements?"; "Clear"; "Leave as is")
		If (OK=1)
			SHORT_MESSAGE("Please Wait....")
			CUT NAMED SELECTION:C334([ElementsSafety:29]; "ElmtsBefDiveClean")
			USE SET:C118("NumElemtsWDiveRtg")
			FIRST RECORD:C50([ElementsSafety:29])
			While (Not:C34(End selection:C36([ElementsSafety:29])))
				[ElementsSafety:29]AltRating:21:="N"
				LogChanges(->[ElementsSafety:29]AltRating:21; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
				SAVE RECORD:C53([ElementsSafety:29])
				NEXT RECORD:C51([ElementsSafety:29])
			End while 
			USE NAMED SELECTION:C332("ElmtsBefDiveClean")
			CLOSE WINDOW:C154
		End if 
		
	End if 
	CLEAR SET:C117("NumElemtsWDiveRtg")
End if 
