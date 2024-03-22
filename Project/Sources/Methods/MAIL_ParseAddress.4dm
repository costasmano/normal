//%attributes = {"invisible":true}
//Method: MAIL_ParseAddress
//Description
// parse a text containign email address into the email address and the display name.
// Parameters
//$1 : $address_txt
//$2 : $EmailAddr_ptr
//$3 : $Name_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/09/16, 15:07:04
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	C_TEXT:C284(MAIL_ParseAddress; $1)
	C_POINTER:C301(MAIL_ParseAddress; $2)
	C_POINTER:C301(MAIL_ParseAddress; $3)
	
End if 
//
C_TEXT:C284($address_txt; $1)
C_POINTER:C301($EmailAddr_ptr; $2)
C_POINTER:C301($Name_ptr; $3)

$address_txt:=$1
$EmailAddr_ptr:=$2
$Name_ptr:=$3

C_TEXT:C284($name_txt; $emailAddr_txt)
$name_txt:=""
C_BOOLEAN:C305($match_b)
ARRAY LONGINT:C221($start_aL; 0)
ARRAY LONGINT:C221($Len_aL; 0)
$match_b:=Match regex:C1019("[<]([a-z,A-Z,0-9,.]+[@][a-z,A-Z,0-9,.]+)[>]"; $address_txt; 1; $start_aL; $Len_aL)
If ($match_b)
	$emailAddr_txt:=Substring:C12($address_txt; $start_aL{1}; $Len_aL{1})
	$match_b:=Match regex:C1019("[\"]*(.*)[\", ]*[<]"; $address_txt; 1; $start_aL; $Len_aL)
	If ($match_b)
		$name_txt:=Substring:C12($address_txt; $start_aL{1}; $Len_aL{1})
		$name_txt:=Replace string:C233($name_txt; "\""; "")
		$name_txt:=f_TrimStr($name_txt; True:C214; True:C214)
	End if 
Else 
	$emailAddr_txt:=$address_txt
End if 


$EmailAddr_ptr->:=$emailAddr_txt
$Name_ptr->:=$name_txt
//End MAIL_ParseAddress