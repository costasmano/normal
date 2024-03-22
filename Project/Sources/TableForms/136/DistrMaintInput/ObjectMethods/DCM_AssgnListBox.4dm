
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 07/17/17, 13:24:31
//----------------------------------------------------
//Method: [DCM_Contracts].DistrMaintInput.DCM_AssgnListBox
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/10/10 20:47:01)
	Mods_2010_12
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 

Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_LONGINT:C283($recNum_L)
			$recNum_L:=Self:C308->
			If ($recNum_L>0)
				GOTO SELECTED RECORD:C245([DCM_WorkOrders:137]; $recNum_L)
				If (ut_LoadRecordInteractive(->[DCM_WorkOrders:137]))
					FORM SET INPUT:C55([DCM_WorkOrders:137]; "DistrMaintInput")
					MODIFY RECORD:C57([DCM_WorkOrders:137])
					DCM_AssignControl("RELATE")
					DCM_AssignControl("INIT"; Records in selection:C76([DCM_WorkOrders:137]))
					DCM_AssignControl("LOAD")
					DCM_ContrBidItems("SUMWOS")
				End if 
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
End case 
//End [DCM_Contracts].DistrMaintInput.DCM_AssgnListBox

