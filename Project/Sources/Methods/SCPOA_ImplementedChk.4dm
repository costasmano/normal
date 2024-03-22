//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/29/09, 01:11:21
	// ----------------------------------------------------
	// Method: SCPOA_ImplementedChk
	// Description
	// Handle the check boxes for the Implemented part in the Flood monitoring plan summary
	// 
	// Parameters
	// $1 : $ChkBox_ptr
	// ----------------------------------------------------
	
	Mods_2009_11
End if 
C_POINTER:C301($1; $ChkBox_ptr)
$ChkBox_ptr:=$1

[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2  //do this to mark a change
C_TEXT:C284($varName_txt; $YorN_txt)
C_LONGINT:C283($tbl_L; $fld_L)
RESOLVE POINTER:C394($ChkBox_ptr; $varName_txt; $tbl_L; $fld_L)
C_POINTER:C301($OtherChk_ptr)
$YorN_txt:=Substring:C12($varName_txt; (Length:C16($varName_txt)-2); 1)
If ($YorN_txt="Y")
	$YorN_txt:="N"
Else 
	$YorN_txt:="Y"
End if 
$OtherChk_ptr:=Get pointer:C304(Substring:C12($varName_txt; 1; (Length:C16($varName_txt)-3))+$YorN_txt+"_L")
If ($ChkBox_ptr->=1)
	$OtherChk_ptr->:=0
Else 
	$OtherChk_ptr->:=1
End if 