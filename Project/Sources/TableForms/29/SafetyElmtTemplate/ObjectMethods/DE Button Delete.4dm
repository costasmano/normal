If (False:C215)
	//procedure: ZZ5 on [ElementsSafety];"Safety ElmInput"
	//by: Albert Leung
	//created: 4/30/2001
	//modified:
	//purpose: log the deletion of a safety element
	//Copyright © 1995-2001,  Albert S. Leung, All Rights Reserved.
	//parameters:
End if 

C_TEXT:C284($Text)  //Alert message text.

// first ask for confirmation..
$Text:="Do you really want to delete this safety element record ?"
CONFIRM:C162($Text)
If (OK=1)
	CREATE SET:C116([ElementsSafety:29]; "InspElmtSetPreDel")
	REMOVE FROM SET:C561([ElementsSafety:29]; "InspElmtSetPreDel")
	LogDeletion(->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
	DELETE RECORD:C58([ElementsSafety:29])
	CANCEL:C270
	USE SET:C118("InspElmtSetPreDel")
	CLEAR SET:C117("InspElmtSetPreDel")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
	If ([Inspections:27]Insp Type:6="RTA")
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabelArch:14; >)
	Else 
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >)
	End if 
End if 