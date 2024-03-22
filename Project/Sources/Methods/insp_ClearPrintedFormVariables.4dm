//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/13/12, 16:05:27
//----------------------------------------------------
//Method: insp_ClearPrintedFormVariables
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_12  //r001 ` 
	//Modified by: Charles Miller (12/13/12 16:05:28)
	
End if 

ARRAY TEXT:C222($Types_atxt; 6)
$Types_atxt{1}:="N58"
$Types_atxt{2}:="N59"
$Types_atxt{3}:="N60"
$Types_atxt{4}:="N61"
$Types_atxt{5}:="APP"
$Types_atxt{6}:="OVR"


C_LONGINT:C283($Loop_l; $AppType_l)
C_POINTER:C301($VTptr; $VDptr; $VRptr; $VrDptr)
C_TEXT:C284($ElementType_txt)
$AppType_l:=1
Repeat 
	$ElementType_txt:=$Types_atxt{$AppType_l}
	For ($Loop_l; 1; 40)
		
		$VTptr:=Get pointer:C304("VT"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VDptr:=Get pointer:C304("VD"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VRptr:=Get pointer:C304("VR"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VrDptr:=Get pointer:C304("VrD"+$ElementType_txt+"_"+String:C10($Loop_l))
		CLEAR VARIABLE:C89($VTptr->)
		CLEAR VARIABLE:C89($VDptr->)
		CLEAR VARIABLE:C89($VRptr->)
		CLEAR VARIABLE:C89($VrDptr->)
	End for 
	$AppType_l:=$AppType_l+1
Until ($AppType_l>Size of array:C274($Types_atxt))


//End insp_ClearPrintedFormVariables

