//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/07, 10:53:41
	// ----------------------------------------------------
	// Method: PERS_GetMyInfo
	// Description
	// Load Personnel data for the current user
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(2/2/10 09:09:07)
	Mods_2010_02
	//Added ◊PERS_MyCompany_txt
	// Modified by: costasmanousakis-(Designer)-(12/1/10 10:05:15)
	Mods_2010_12
	//  `Added ◊PERS_MyJobCode_i; ◊PERS_MyDivision_txt; 
	// ` optional parameter 1 -mainly for to aid in debugging executed in the debugger window
	// Modified by: costasmanousakis-(Designer)-(6/9/11 15:46:15)
	Mods_2011_06
	//  `Added definition of  ◊PERS_MyFullName_txt; adjusted the ◊PERS_MyEmail_txt to include the name
	// Modified by: costasmanousakis-(Designer)-(10/18/11 10:38:19)
	Mods_2011_10
	//  `Use new global var ◊CurrentUser_Name instead of Current user
End if 
READ ONLY:C145([Personnel:42])
C_TEXT:C284(<>PERS_MyName_txt; <>PERS_MyPhone_txt; <>PERS_MyEmail_txt; <>PERS_MyFullName_txt; <>PERS_MyCompany_txt; <>PERS_MyDivision_txt)
C_LONGINT:C283(<>PERS_MyJobCode_i)  //Command Replaced was o_C_INTEGER
<>PERS_MyName_txt:=""
<>PERS_MyPhone_txt:=""
<>PERS_MyEmail_txt:=""
<>PERS_MyFullName_txt:=""
<>PERS_MyCompany_txt:=""
<>PERS_MyDivision_txt:=""
<>PERS_MyJobCode_i:=0
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$1)
Else 
	QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=<>CurrentUser_UID)
End if 

If (Records in selection:C76([Personnel:42])=1)
	LOAD RECORD:C52([Personnel:42])
	<>PERS_MyName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
	<>PERS_MyPhone_txt:=[Personnel:42]Phone_s:13
	<>PERS_MyCompany_txt:=[Personnel:42]Employer:9
	<>PERS_MyJobCode_i:=[Personnel:42]Job Code:8
	<>PERS_MyDivision_txt:=[Personnel:42]Division No:7
	If ([Personnel:42]Middle Name:4="")
		<>PERS_MyFullName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
	Else 
		<>PERS_MyFullName_txt:=[Personnel:42]First Name:3+" "+Replace string:C233([Personnel:42]Middle Name:4; " "; "")+" "+[Personnel:42]Last Name:5
	End if 
	
	If ([Personnel:42]EmailAddress_s:14#"")
		<>PERS_MyEmail_txt:=<>PERS_MyName_txt+" <"+[Personnel:42]EmailAddress_s:14+">"
	End if 
Else 
	<>PERS_MyName_txt:=<>CurrentUser_Name
End if 
READ WRITE:C146([Personnel:42])