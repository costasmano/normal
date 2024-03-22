//%attributes = {"invisible":true}
//Method: Mods_2015_11_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/04/15, 09:30:04
	// ----------------------------------------------------
	//Created : 
	
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(11/4/15)
// Modified Method(s) : 
//LSS_PermissionModInventory 

//LSS_PermissionDELInventory
//  remove check for current user-to delete inventory must be in a delete access group

//m_ListInventory
//Startup
//  `should not initialize ◊NextNumberArray_al ; done in "on Startup"

//```
//```   **** End of Release 6.4.1.a 11/04/2015
//```

//**********`Modified by: Costas Manousakis-(Designer)-(11/6/15)
// Modified Method(s) : 
//PON_ut_compareNBEs
//  `fix bug in the seraching for  $ServerInspID_L ;
//  `add a check to find first inspID and first ElemID in FileIDRes  to avoid errors in id matching

//**********`Modified by: Costas Manousakis-(Designer)-(11/9/15)
// Created Method(s) : 
//  `Method: INSP_FieldClr_OM
//Description
// object method for the field clearance values. ajusted to account for zero entered in one
// of the measurements

// Modified object methods in Forms : 
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//[Inspections];"RailRoutineInput"
//[Inspections];"TunnelInspection"
//[Inspections];"TunnelOverheadInspection"
//[Inspections];"TunnelDamageForm"
//[Inspections];"RoutineNewNBE"
//  `modified object methods in fileds 
//  `[Inspections]NEClrFldFT [Inspections]NEClrFldIN [Inspections]SWClrFldFT [Inspections]SWClrFldIN
//  `to use method INSP_FieldClr_OM


//```
//```   **** End of Release 6.4.1.b 11/09/2015
//```

//**********`Modified by: Costas Manousakis-(Designer)-(11/18/15)
// Modified Forms : 
//[PON_ELEM_INSP];"Input"
//  `Remove the Delete action from the Delete button. 


//**********`Modified by: Costas Manousakis-(Designer)-(11/19/15)
// Modified Method(s) : 
//LNextView 
//  `changed $1 to 31 length

//COMPILER
//  `changed some parameters of methods LSpawnProcess , LNextView, LProcessID to 31 chars

//**********`Modified by: Costas Manousakis-(Designer)-(11/23/15)
// Modified Method(s) : 
//PON_ELEMDAMLB_OM
//  `use method PON_ELEMINP_SAVE when saving current element.  this to make sure changes are recorded.

//**********`Modified by: Costas Manousakis-(Designer)-(11/30/15)
// Modified Form Method(s) : 
//[Inspections];"RailRoutine Culvert"
//  `fix accessibility  items - wrong variables were being filled.

//```
//```   **** End of Release 6.4.1.c 12/01/2015
//```

//End Mods_2015_11_bug