//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/04/07, 13:56:49
	// ----------------------------------------------------
	// Method: PRJ_LTR_MyInfo
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	//Mods_2007_CM12_5301
End if 
C_TEXT:C284(MyName_txt; MyPhone_txt; MyEmail_txt)

READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=<>CurrentUser_UID)
If (Records in selection:C76([Personnel:42])=1)
	LOAD RECORD:C52([Personnel:42])
	If ([Personnel:42]Middle Name:4="")
		MyName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
	Else 
		MyName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
	End if 
	MyPhone_txt:=[Personnel:42]Phone_s:13
	MyEmail_txt:=[Personnel:42]EmailAddress_s:14
	UNLOAD RECORD:C212([Personnel:42])
	
End if 
READ WRITE:C146([Personnel:42])