// Method: Object Method: [Inspections].TunnelReprtTemplate.INSP_TunnelStructType_txt
// Description
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 09/09/13, 13:45:26
	// ----------------------------------------------------
	// First Release
	Mods_2013_09
End if 
C_TEXT:C284(INSP_TunnelStructType_txt; $Constr_txt; $Str_txt)
INSP_TunnelStructType_txt:=""
$Constr_txt:=f_TrimStr([TunnelInfo:151]ConstructionType_s:3; True:C214; True:C214)
$Str_txt:=f_TrimStr([TunnelInfo:151]StructureType_s:4; True:C214; True:C214)
Case of 
	: ($Constr_txt#"") & ($Str_txt#"")
		INSP_TunnelStructType_txt:=$Constr_txt+"-"+$Str_txt
	: ($Constr_txt#"")
		INSP_TunnelStructType_txt:=$Constr_txt
	: ($Str_txt#"")
		INSP_TunnelStructType_txt:=$Str_txt
		
End case 



