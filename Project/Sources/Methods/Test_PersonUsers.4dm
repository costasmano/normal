//%attributes = {"invisible":true}
// ----------------------------------------------------
// Test_PersonUsers
// User name (OS): charlesmiller
// Date and time: 03/06/09, 14:10:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/06/09, 14:10:21`Upgrade from open form window to open window
End if 

C_LONGINT:C283($numpersons; $k; $j)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($personFname; $PersonLName)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($UID)
$numpersons:=Size of array:C274(aPeople)
C_TEXT:C284(msg)
msg:=""
For ($k; 1; $numpersons)
	$j:=Position:C15(" "; aPeople{$k})
	$PersonFname:=Substring:C12(aPeople{$k}; 1; $j)
	$PersonLName:=Substring:C12(aPeople{$k}; ($j+1); 80)
	$j:=Position:C15(" "; $PersonLName)
	If ($j>0)
		$PersonLName:=Substring:C12($PersonLName; ($j+1); 80)
	End if 
	$UID:=f_GetUserID(($PersonFName+$PersonLName))
	msg:=msg+aPeople{$k}+" = "+$PersonFName+$PersonLName+" = "+String:C10($UID)+<>sCR
End for 

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "Stats"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$newin:=Open form window([Dialogs];"Stats")
DIALOG:C40([Dialogs:21]; "Stats")
CLOSE WINDOW:C154



//End Test_PersonUsers