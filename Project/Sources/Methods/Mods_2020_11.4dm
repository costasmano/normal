//%attributes = {"invisible":true}
//Method: Mods_2020_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 11/05/20, 13:01:08
	// ----------------------------------------------------
	//Created : 
	Mods_2020_11
End if 
//
//Continue coding upgrade to listboxes

//[PRJ_DesignContracts];"Output_LB"
//[PRJ_ProjectDetails];"ProjectDetails_LB"
//LB_DesignContractSort 
//LB_BridgeProgramSort
//LB_ProjectDetailSort 
//PRJ_SetUpDetailList 
//PRJ_PrintFromOutput_LB 
//PRJ_LB_ReturnBridgeNo 
//PRJ_DisplayProjects 
//PRJ_DisplayDesignContr 
//PRJ_DetailLBSetUpDisplayEvent 
//PRJ_DesignContractLBReturnName
//Printing design contract list box is done through a quick report
//New record created in templates named QRT_ProjectDesign


// Write code to print table based list boxes
//Note that to print variable data, each column that is a variable must have a method that reurns the data
//PrintListBox


//End Mods_2020_11