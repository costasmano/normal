//%attributes = {"invisible":true}
// Method: ut_GetConsEmail
// Description
// Retrieve/Specify the email address for a consultant company.
// 
// Parameters
// $0 : $Email_txt
// $1 : $ConsName_txt
// $2 : $Function_txt ("DESIGN" | "INSPECTION"| "RATING")
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/07, 10:51:38
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2020_05_bug
	//  `use at least 3 chars from the consultant name when searching addresses
End if 
C_TEXT:C284($0; $Email_txt; $1; $ConsName_txt; $2; $Function_txt)
$ConsName_txt:=$1
$Function_txt:=$2
$Email_txt:=""
C_TEXT:C284($msg; $CancelMsg_txt; DummyField_txt)
$CancelMsg_txt:="Don't Send Email"
$msg:=<>sCR+"To specify multiple addresses for "+$ConsName_txt+",  enter them at the prompt separated by a comma (,)."
C_LONGINT:C283($I)
READ ONLY:C145([Conslt Address:77])
QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2=(Substring:C12($ConsName_txt; 1; \
MaxNum((Length:C16($ConsName_txt)\2); 3))\
+"@"))
Case of 
	: ($Function_txt="DESIGN")
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Design:21=True:C214)
	: ($Function_txt="INSPECTION")
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Insp:20=True:C214)
	: ($Function_txt="RATING")
		QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Rating:19=True:C214)
End case 
QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Email:18#"")
If (Records in selection:C76([Conslt Address:77])>=1)
	ARRAY TEXT:C222($ConsEmails_as; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222($ConsFName_as; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222($ConsLName_as; 0)  //Command Replaced was o_ARRAY string length was 80
	SELECTION TO ARRAY:C260([Conslt Address:77]Email:18; $ConsEmails_as; [Conslt Address:77]ContactFName:3; $ConsFName_as; [Conslt Address:77]ContactLName:4; $ConsLName_as)
	ARRAY TEXT:C222(ConsEmails_atxt; Size of array:C274($ConsLName_as))
	For ($i; 1; Size of array:C274(ConsEmails_atxt))
		ConsEmails_atxt{$i}:=$ConsFName_as{$i}+" "+$ConsLName_as{$i}+" <"+$ConsEmails_as{$i}+">"
	End for 
	If (ConsEmails_atxt{1}#$Email_txt)
		If ($Email_txt#"")
			$Email_txt:=ConsEmails_atxt{1}+","+$Email_txt
		Else 
			$Email_txt:=ConsEmails_atxt{1}
		End if 
	End if 
	
	If (Size of array:C274(ConsEmails_atxt)>1)
		$msg:="Verify the e-mail address for "+$ConsName_txt+". You can also select an email address from the dropdown."+$msg
		$Email_txt:=ut_Request($msg; ->ConsEmails_atxt; $Email_txt; ""; $CancelMsg_txt)
	Else 
		$msg:="Verify the e-mail address for "+$ConsName_txt+"."+$msg
		$Email_txt:=ut_Request($msg; ->DummyField_txt; $Email_txt; ""; $CancelMsg_txt)  //need a pointer to something not an array
	End if 
	ARRAY TEXT:C222(ConsEmails_atxt; 0)
	ARRAY TEXT:C222($ConsEmails_as; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222($ConsFName_as; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY TEXT:C222($ConsLName_as; 0)  //Command Replaced was o_ARRAY string length was 80
Else 
	$msg:="No Known Email addresses for "+$ConsName_txt+"."+<>sCR+"Please enter the e-mail address :"+$msg
	$Email_txt:=ut_Request($msg; ->DummyField_txt; $Email_txt; ""; $CancelMsg_txt)  //need a pointer to something not an array
End if 

If (OK#1)
	$Email_txt:=""
End if 

READ WRITE:C146([Conslt Address:77])
$0:=$Email_txt