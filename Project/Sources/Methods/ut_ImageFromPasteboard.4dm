//%attributes = {"invisible":true}
//Method: ut_ImageFromPasteboard
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/28/14, 12:08:41
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//

ARRAY TEXT:C222($sigs_atxt; 0)
ARRAY TEXT:C222($types_atxt; 0)
ARRAY TEXT:C222($names_atxt; 0)

GET PASTEBOARD DATA TYPE:C958($sigs_atxt; $types_atxt; $names_atxt)
C_LONGINT:C283($loop_L)
C_TEXT:C284($docname; $ext)
C_BLOB:C604($pastData_blb)
C_TIME:C306($pdata_t)
C_LONGINT:C283($typePick_L)
$typePick_L:=G_PickFromList(->$sigs_atxt; "Select Type")

C_PICTURE:C286($0)

C_PICTURE:C286($pict_p)
$pict_p:=$pict_p*0
If ($typePick_L>0)
	
	If ($sigs_atxt{$typePick_L}#"")
		C_BLOB:C604($pasteData_blb)
		GET PASTEBOARD DATA:C401($sigs_atxt{$typePick_L}; $pasteData_blb)
		ARRAY TEXT:C222($sigparts_atxt; 0)
		ut_TextToArray($sigs_atxt{$typePick_L}; ->$sigparts_atxt; ".")
		$ext:=$sigparts_atxt{Size of array:C274($sigparts_atxt)}
		BLOB TO PICTURE:C682($pasteData_blb; $pict_p; "."+$ext)
	End if 
	
End if 

$0:=$pict_p

//End ut_ImageFromPasteboard