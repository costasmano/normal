//Method: Object Method: WebAreaTest.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/06/13, 08:29:58
	// ----------------------------------------------------
	//Created : 
	//Mods_2013_11
End if 
//
C_TEXT:C284($latoutput_txt; $lngoutput_txt; $bdept_txt; $BIN_txt; $HTML_txt; $markerSum_txt)
//WA EXECUTE JAVASCRIPT FUNCTION(web area;"GetDocHTMLTo4D";$HTML_txt;"mapoutput")
//ALERT($HTML_txt)*
WA EXECUTE JAVASCRIPT FUNCTION:C1043(web area; "GetDocHTMLTo4D"; $latoutput_txt; "latoutput")
WA EXECUTE JAVASCRIPT FUNCTION:C1043(web area; "GetDocHTMLTo4D"; $lngoutput_txt; "lngoutput")
C_TEXT:C284($msg_txt)
$msg_txt:="latoutput :"+$latoutput_txt+Char:C90(13)+"lngoutput :"+$lngoutput_txt
WA EXECUTE JAVASCRIPT FUNCTION:C1043(web area; "GetMapDataTo4D"; $HTML_txt)
ALERT:C41("Map center at :"+$HTML_txt)
C_REAL:C285($lat_r; $long_R; $Sec_R)
$bdept_txt:=Substring:C12($latoutput_txt; 1; 6)
$BIN_txt:=Substring:C12($latoutput_txt; 10; 3)
$lat_r:=Num:C11(Substring:C12($latoutput_txt; Position:C15("Lat:"; $latoutput_txt)))
$long_R:=Num:C11($lngoutput_txt)
C_LONGINT:C283($Deg_L; $Min_L)
ut_degToDegMinSec($lat_r; ->$Deg_L; ->$Min_L; ->$Sec_R)
$msg_txt:=$msg_txt+Char:C90(13)+"for "+$bdept_txt+" ("+$BIN_txt+") Lat : "+String:C10($Deg_L)+"d - "+String:C10($Min_L)+"' - "+String:C10($Sec_R; "##.0000")+Char:C90(Double quote:K15:41)
ut_degToDegMinSec($long_R; ->$Deg_L; ->$Min_L; ->$Sec_R)
$msg_txt:=$msg_txt+Char:C90(13)+" Long : "+String:C10($Deg_L)+"d - "+String:C10($Min_L)+"' - "+String:C10($Sec_R; "##.0000")+Char:C90(Double quote:K15:41)

ALERT:C41($msg_txt)
WA EXECUTE JAVASCRIPT FUNCTION:C1043(web area; "GetMarkerSummary"; $markerSum_txt)
ALERT:C41("Summary : "+Replace string:C233($markerSum_txt; "<br>"; Char:C90(13)))
ARRAY TEXT:C222(LBGeneric_atxt; 0)
C_TEXT:C284(1_TXT)
1_TXT:="List Of Bridges"
ut_TextToArray($markerSum_txt; ->LBGeneric_atxt; "<br>")
C_LONGINT:C283($Width_l; $Height_l)
FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Old Users Not Updated"; "ut_CloseCancel")
DIALOG:C40("OneArrayLB")
CLOSE WINDOW:C154
//End Object Method: WebAreaTest.Button