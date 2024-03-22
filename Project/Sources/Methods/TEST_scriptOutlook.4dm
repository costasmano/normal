//%attributes = {"invisible":true}
//Method: TEST_scriptOutlook
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/18/15, 16:13:54
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11
End if 
//
ARRAY TEXT:C222($Toaddr_atxt; 0)
ARRAY TEXT:C222($CCaddr_atxt; 0)
ARRAY TEXT:C222($attach_atxt; 0)
C_TEXT:C284($Subj_txt; $body_txt)
APPEND TO ARRAY:C911($Toaddr_atxt; "Costas.manousakis@dot.state.ma.us")
APPEND TO ARRAY:C911($Toaddr_atxt; "lucy.manousakis@dot.state.ma.us")
APPEND TO ARRAY:C911($CCaddr_atxt; "lori.peterson@dot.state.ma.us")
$Subj_txt:="This is a test email"
$body_txt:=""
$body_txt:=$body_txt+"Line 1"+Char:C90(13)
$body_txt:=$body_txt+"Line 2"+Char:C90(13)
$body_txt:=$body_txt+"Line 3"+Char:C90(13)
$body_txt:=$body_txt+"Line 4"+Char:C90(13)
$body_txt:=$body_txt+Char:C90(13)
$body_txt:=$body_txt+Char:C90(13)
$body_txt:=$body_txt+("-"*30)+Char:C90(13)
$body_txt:=$body_txt+"Automated email"+Char:C90(13)
C_TEXT:C284($file_txt)
$file_txt:=Select document:C905(""; "*"; "Pick it"; Multiple files:K24:7; $attach_atxt)

MAIL_scriptOutlook(->$Toaddr_atxt; ->$CCaddr_atxt; $Subj_txt; $body_txt; ->$attach_atxt)

//End TEST_scriptOutlook