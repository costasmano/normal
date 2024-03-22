//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/13/05, 16:08:54
	// ----------------------------------------------------
	// Method: SRCP_LoadElmArrays
	// Description
	// Copied from Project method LOAD_aElem
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM17
	
End if 
C_BOOLEAN:C305($1; $Reset)
C_LONGINT:C283($NoElem; $i)
If (Count parameters:C259=1)
	$Reset:=$1
Else 
	$Reset:=False:C215
End if 
If ($Reset)
	ALL RECORDS:C47([BMS Elements:47])
End if 
SELECTION TO ARRAY:C260([BMS Elements:47]Element ID:1; cboPontisElemID; [BMS Elements:47]Element No:2; $aElemNo; [BMS Elements:47]Element Name:3; $aElemName; [BMS Categories:49]General Cat:2; $aGenCat; [BMS Categories:49]Subcategory:3; $aSubCat; [BMS Elements:47]Element Type:4; $aElemType)
$NoElem:=Size of array:C274(cboPontisElemID)
ARRAY TEXT:C222(cboPontisElem; $NoElem)  //Command Replaced was o_ARRAY string length was 106
REDUCE SELECTION:C351([BMS Elements:47]; 0)

For ($i; 1; $NoElem)
	//     Element Name (never blank)
	//     General Category (rarely blank (1 instance))
	//     Subcategory (sometimes blank)
	//     Element Type (usually blank)
	cboPontisElem{$i}:=String:C10($aElemNo{$i})+" - "+$aElemName{$i}  //This should never be blank.
	If ($aGenCat{$i}#"")
		cboPontisElem{$i}:=cboPontisElem{$i}+", "+$aGenCat{$i}
	End if 
	If ($aSubCat{$i}#"")
		cboPontisElem{$i}:=cboPontisElem{$i}+", "+$aSubCat{$i}
	End if 
	If ($aElemType{$i}#"")
		cboPontisElem{$i}:=cboPontisElem{$i}+", "+$aElemType{$i}
	End if 
End for 

SORT ARRAY:C229($aElemNo; cboPontisElemID; cboPontisElem)
