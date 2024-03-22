// ----------------------------------------------------

// Object Method: ◊SD_BYears_as

// User name (OS): cjmiller

// Date and time: 11/02/04, 10:28:40

// ----------------------------------------------------

// Description

// 

//

// Parameters

// ----------------------------------------------------

If (False:C215)
	Mods_2005_CJM01
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		<>SD_BeginYear_s:=<>SD_BYears_as{<>SD_BYears_as}
End case 
//End Object Method: ◊SD_BYears_as