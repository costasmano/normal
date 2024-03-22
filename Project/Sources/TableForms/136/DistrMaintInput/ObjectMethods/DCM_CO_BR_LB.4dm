
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 07/17/17, 13:24:50
//----------------------------------------------------
//Method: [DCM_Contracts].DistrMaintInput.DCM_CO_BR_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/13/10 10:43:05)
	Mods_2010_12
	//  `Fixes for Bid Item Recalculation
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 

Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		//ALERT("dbl click on "+String(Self->))
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($recNum_L)
			$recNum_L:=Self:C308->
			If ($recNum_L>0)
				GOTO SELECTED RECORD:C245([DCM_Project:138]; $recNum_L)
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				QUERY:C277([DCM_WorkOrders:137]; [DCM_WorkOrders:137]AssignID:3=[DCM_Project:138]AssignID:13)
				If (ut_LoadRecordInteractive(->[DCM_Project:138]))
					FORM SET INPUT:C55([DCM_Project:138]; "DistrWorkOrderInput")
					//Load Work Order arrays - work order record is loaded already?
					DCM_ControlWOBlobs("INIT")
					C_BOOLEAN:C305(DCM_HideProjNavBtns_b)
					DCM_HideProjNavBtns_b:=True:C214
					MODIFY RECORD:C57([DCM_Project:138])
					DCM_HideProjNavBtns_b:=False:C215
					DCM_PROJITEMS_CTRL("CALCALL")
					//  `Need to update work order costs and project costs
					
					C_BOOLEAN:C305(DCM_WO_ITEMQChange_b)
					If (DCM_WO_ITEMQChange_b)
						
						If (ut_LoadRecordInteractive(->[DCM_WorkOrders:137]))
							DCM_ControlWOBlobs("SAVE")
							SAVE RECORD:C53([DCM_WorkOrders:137])
							//update the contract items
							DCM_ContrBidItems("SUMWOS")
							[DCM_Contracts:136]ActualSpent:18:=[DCM_Contracts:136]ActualSpent:18
						Else 
							ALERT:C41("Change in Work Order Quantities could not be saved!")
						End if 
						
					Else 
					End if 
					
					DCM_ContrProjControl("RELATE")
					DCM_ContrProjControl("INIT"; Records in selection:C76([DCM_Project:138]))
					DCM_ContrProjControl("LOAD")
				End if 
				
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
End case 
//End [DCM_Contracts].DistrMaintInput.DCM_CO_BR_LB

