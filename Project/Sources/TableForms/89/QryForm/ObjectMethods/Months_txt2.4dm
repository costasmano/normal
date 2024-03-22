// ----------------------------------------------------

// Object Method: ◊aMonths

// User name (OS): cjmiller

// Date and time: 11/02/04, 10:08:24

// ----------------------------------------------------

// Description

// This method will select ending month for query

//

// Parameters

// ----------------------------------------------------

If (False:C215)
	Mods_2005_CJM01
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		<>SD_EndMonth_s:=String:C10(aEndMonths; "00")
End case 
//End Object Method: ◊aMonths