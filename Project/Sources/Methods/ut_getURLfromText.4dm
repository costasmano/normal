//%attributes = {"invisible":true}
//Method: ut_getURLfromText
//Description
//  ` Return the URL found in a text
// Parameters
// $0 : $Url_text
// $1 : $TextIn_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/07/14, 16:54:46
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//

C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($Url_text; $TextIn_txt)
$TextIn_txt:=$1
$Url_text:=""
C_TEXT:C284($urlpattern_txt; $NewString_txt)
C_BOOLEAN:C305($Found_b)
C_LONGINT:C283($start_L)
ARRAY LONGINT:C221($posFound_aL; 0)
ARRAY LONGINT:C221($LengthFound_aL; 0)
ARRAY TEXT:C222($URLs_atxt; 0)

$urlpattern_txt:="(http|https|ftp)"  // Patterns that contain http or https, or ftp protocols.
$urlpattern_txt:=$urlpattern_txt+"\\://"  // Adding :// to the pattern
$urlpattern_txt:=$urlpattern_txt+"[a-zA-Z0-9\\-\\.]+"  //Matches the first part of the domain
$urlpattern_txt:=$urlpattern_txt+"\\.[a-zA-Z]{2,4}"  //Match the second part of the domain
$urlpattern_txt:=$urlpattern_txt+"(:[a-zA-Z0-9]*)?/?"  //Match the port number and the slash
$urlpattern_txt:=$urlpattern_txt+"([a-zA-Z0-9\\-\\._?\\,'/\\+%\\$#\\=~\\:\\&])*"  //Reserved chars
$urlpattern_txt:=$urlpattern_txt+"[^\\.\\,\\)\\(\\s\\']"  //Excluded chars

$start_L:=1
$Found_b:=False:C215

Repeat 
	$Found_b:=Match regex:C1019($urlpattern_txt; $TextIn_txt; $start_L; $posFound_aL; $LengthFound_aL)
	$NewString_txt:=Substring:C12($TextIn_txt; $posFound_aL{0}; $LengthFound_aL{0})
	If ($Found_b)
		APPEND TO ARRAY:C911($URLs_atxt; $NewString_txt)
	End if 
	$start_L:=$posFound_aL{0}+$LengthFound_aL{0}
Until (Not:C34($Found_b))


If (Size of array:C274($URLs_atxt)>0)
	$Url_text:=$URLs_atxt{1}  //return the first url found
End if 

$0:=$Url_text
//End ut_getURLfromText