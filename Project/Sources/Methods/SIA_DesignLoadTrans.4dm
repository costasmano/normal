//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/08, 11:44:16
	// ----------------------------------------------------
	// Method: SIA_DesignLoadTrans
	// Description
	// Translate MHD to FHWA codings for Item 31
	// 
	// Parameters
	// $0 : $Trans_txt 
	// $1 : $Code_txt (optional)
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
End if 
C_TEXT:C284($Code_txt)
C_TEXT:C284($0; $Trans_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Code_txt:=$1
Else 
	$Code_txt:=[Bridge MHD NBIS:1]Item31:135
End if 
$Trans_txt:=" "
C_LONGINT:C283($MHDIndex_L)
$MHDIndex_L:=Find in array:C230(<>MHDItm31Codes_atxt; $Code_txt)
If (($MHDIndex_L>0) & ($MHDIndex_L<=Size of array:C274(<>FHWAItm31Codes_atxt)))
	$Trans_txt:=<>FHWAItm31Codes_atxt{$MHDIndex_L}
End if 

$0:=$Trans_txt