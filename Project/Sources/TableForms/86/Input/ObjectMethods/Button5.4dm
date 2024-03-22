If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/27/07, 10:15:11
	// ----------------------------------------------------
	// Method: Object Method: ReferenceFlip
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(10/30/09 16:02:45)
	Mods_2009_10
	Mods_2011_06  // CJ Miller`06/20/11, 11:29:30      ` Type all local variables for v11
End if 
//C_REAL($WRUnit_r)
//$WRUnit_r:=WR Get doc property (WRT_Template;wr unit)
//C_LONGINT($numRefs_L;$RefLoop_L)
//$numRefs_L:=WR Count (WRT_Template;wr nb objects)
//C_LONGINT($info1_L;$info2_L;$type_L;$dateForm_L;$TimeForm_L;$StartSel_L;$EndSel_L)
//C_TEXT($refName_txt;$numForm_txt)
//ARRAY TEXT(arrTab;$numRefs_L)
//For ($RefLoop_L;1;$numRefs_L)
//WR SELECT (WRT_Template;1;$RefLoop_L;MAXLONG)
//WR GET SELECTION (WRT_Template;$StartSel_L;$EndSel_L)
//WR GET REFERENCE (WRT_Template;$info1_L;$info2_L;$refName_txt;$type_L;$numForm_txt;$dateForm_L;$TimeForm_L)
//arrTab{$RefLoop_L}:="Ref "+String($RefLoop_L)+" << "+$refName_txt+">> at   "+String($StartSel_L)+" - "+String($EndSel_L)
//End for 
//C_LONGINT($PickaRef)
//$PickaRef:=G_PickFromList 
