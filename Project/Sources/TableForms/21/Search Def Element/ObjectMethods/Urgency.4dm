//Method: [Dialogs];"Search Def Element".Hierarchical Popup Menu
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/03/19, 12:05:34
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($selected_txt; $Partext_txt; $Param_txt; $currObjName_txt; $DescObjName_txt)
		C_LONGINT:C283($ItemRefpos_L; $parrefL; $par_pos_L)
		C_POINTER:C301($HL_ptr)
		$currObjName_txt:=OBJECT Get name:C1087(Object current:K67:2)
		$DescObjName_txt:=$currObjName_txt+"Desc"
		$HL_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
		$ItemRefpos_L:=Selected list items:C379($HL_ptr->)
		GET LIST ITEM:C378($HL_ptr->; $ItemRefpos_L; $ItemRef_L; $selected_txt)
		$parrefL:=List item parent:C633($HL_ptr->; $ItemRef_L)
		SELECT LIST ITEMS BY REFERENCE:C630($HL_ptr->; $parrefL)
		//$par_pos_L:=List item position(*;"HLUrgency";$parrefL)
		GET LIST ITEM:C378($HL_ptr->; *; $parrefL; $Partext_txt)
		
		GET LIST ITEM PARAMETER:C985($HL_ptr->; $ItemRef_L; "Param1"; $Param_txt)
		OBJECT SET TITLE:C194(*; $DescObjName_txt; $Param_txt)
		GET LIST ITEM PARAMETER:C985($HL_ptr->; $ItemRef_L; "Param2"; vUrgOp)
		GET LIST ITEM PARAMETER:C985($HL_ptr->; $ItemRef_L; "Param3"; vUrg)
		
End case 

//End [Dialogs].Search Def Element.Hierarchical Popup Menu