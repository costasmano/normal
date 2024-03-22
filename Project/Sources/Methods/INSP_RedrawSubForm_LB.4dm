//%attributes = {"invisible":true}
//Method: INSP_RedrawSubForm_LB
//Description
// Redraw the listboxes in included subforms in the current page.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/10/20, 11:34:50
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02
End if 
//

ARRAY TEXT:C222($objects_atxt; 0)
ARRAY POINTER:C280($objectVars_aptr; 0)
ARRAY LONGINT:C221($pages_aL; 0)
C_POINTER:C301($Table_ptr)
C_TEXT:C284($detailForm_txt; $listForm_txt)
FORM GET OBJECTS:C898($objects_atxt; $objectVars_aptr; $pages_aL; Form current page:K67:6)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($objects_atxt))
	
	OBJECT GET SUBFORM:C1139(*; $objects_atxt{$loop_L}; $Table_ptr; $detailForm_txt; $listForm_txt)
	
	Case of 
		: ($objects_atxt{$loop_L}="ListOfImages")
			EXECUTE METHOD IN SUBFORM:C1085($objects_atxt{$loop_L}; "INSP_ImageSubForm_FM"; *; On Resize:K2:27)
		: ($objects_atxt{$loop_L}="ListOfElements")
			EXECUTE METHOD IN SUBFORM:C1085($objects_atxt{$loop_L}; "INSP_ElemSftySUB_FM"; *; On Resize:K2:27)
		: ($objects_atxt{$loop_L}="PON_Subform")
			EXECUTE METHOD IN SUBFORM:C1085($objects_atxt{$loop_L}; "PON_PonElemInspSubForm_FM"; *; On Resize:K2:27)
		: ($objects_atxt{$loop_L}="subFormPontisCU")
			EXECUTE METHOD IN SUBFORM:C1085($objects_atxt{$loop_L}; "CU_CondUnitsSubForm_FM"; *; On Resize:K2:27)
	End case 
	
End for 

//End INSP_RedrawSubForm_LB