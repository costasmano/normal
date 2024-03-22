//%attributes = {"invisible":true}
//Method: Mods_2015_07_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/06/15, 10:39:48
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(7/6/15)
// Modified Method(s) : 
//ut_executeMethod
//  `fixed error in the execute on client call - parameters were not getting passed correctly ; the stacksize was passed first (not needed)

// Add SHORT_MESSAGE ("Retrieving data. Please wait…") 
//m_ListInventory

//Fix bug where lss arrays reset to 0
//Method: Object Method: [LSS_Inventory].ListBoxOutput.bQuery

// Modified Object Methods : 
//Object Method: [LSS_Inventory].CustomSearch.LSS_StructureClass_atxt 
//Object Method: [LSS_Inventory].CustomSearch.LSS_RouteDirection_as 
//Object Method: [LSS_Inventory].CustomSearch.LSS_RouteDesignation_atxt 
//Object Method: [LSS_Inventory].New_InventoryItem.LSS_StructureClass_atxt
//Form Method: [LSS_Inventory]New_InventoryItem
//  `Workaround for bug in Choose command running compiled. First value(0) must be at least as long as any of the other values~ 


//```
//```   **** End of Release 6.4.0.a 07/08/2015
//```

// fix bug where [LSS_Photos]LSS_PhotoType_s when savedas blank does not display
//LSS_GetImages 
//Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
//Modified by: administrator (8/6/15 14:10:16)
//FM_InspectionInput
//FM_ElementInspection 
//FM_InventoryInput 


//End Mods_2015_07_bug