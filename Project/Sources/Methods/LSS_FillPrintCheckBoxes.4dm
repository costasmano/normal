//%attributes = {"invisible":true}
//Method: LSS_FillPrintCheckBoxes
//Description
// fill the checkboxes in LSS print inspection forms   - needed because boolean fields print with grey background in Windows
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/15/16, 10:37:32
	// ----------------------------------------------------
	//Created : 
	Mods_2016_01_bug
End if 
//
C_BOOLEAN:C305(v_164_011_b; v_164_028_b; v_164_029_b)
v_164_011_b:=[LSS_Inspection:164]LSS_Cracks_b:11
v_164_028_b:=[LSS_Inspection:164]LSS_Plans_b:28
v_164_029_b:=[LSS_Inspection:164]LSS_Photos_b:29

//End LSS_FillPrintCheckBoxes