//%attributes = {"shared":true}
//Method: QR_I43A_MajorGroups
//Description
//  ` Split the material from Item43a to major groups
// Parameters
// $0 : $MatGroup_txt
// $1 : $MaterialCode_txt (will use the 1st char)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12, 13:57:19
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
End if 
//
C_TEXT:C284($0; $MatGroup_txt)
C_TEXT:C284($1; $MaterialCode_txt)

$MaterialCode_txt:=$1
$MaterialCode_txt:=Substring:C12($MaterialCode_txt; 1; 1)
$MatGroup_txt:=""

Case of 
	: (($MaterialCode_txt="1") | ($MaterialCode_txt="2") | ($MaterialCode_txt="5") | ($MaterialCode_txt="6"))
		$MatGroup_txt:="Concrete"
	: (($MaterialCode_txt="3") | ($MaterialCode_txt="4"))
		$MatGroup_txt:="Steel"
	: ($MaterialCode_txt="7")
		$MatGroup_txt:="Timber"
	: ($MaterialCode_txt="8")
		$MatGroup_txt:="Masonry"
	: ($MaterialCode_txt="9")
		$MatGroup_txt:="Aluminum, Iron"
	: ($MaterialCode_txt="0")
		$MatGroup_txt:="Other"
End case 

$0:=$MatGroup_txt
//End QR_I43A_MajorGroups