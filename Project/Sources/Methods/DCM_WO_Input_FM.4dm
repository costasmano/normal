//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/08/10, 14:35:19
	// ----------------------------------------------------
	// Method: DCM_WO_Input_FM
	// Description
	//  ` form method for [DCM_WorkOrders];"DistrMaintInput"
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(10/26/10 08:59:20)
	Mods_2010_10
	//  `Added code in the case of not a new record to catch any changes or omissions.
	//  `Use new method fn_MaxElement_L to get the max current assignment number.
	// Modified by: costasmanousakis-(Designer)-(11/15/10 10:53:43)
	Mods_2010_11
	//  `Added call to DCM_WO_DistrAreaCtrl on the on load event
	// Modified by: costasmanousakis-(Designer)-(12/13/10 09:11:03)
	Mods_2010_12
	//Bug Fixes for Recalculation of item quantities
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		DCM_WO_PrjLB_Control("LOAD")
		
	: ($FormEvent_L=On Load:K2:1)
		InDoubleClick_B:=False:C215
		//InitChangeStack (1)
		//set form sizes
		C_LONGINT:C283($Width; $Height; $TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		FORM GET PROPERTIES:C674([DCM_WorkOrders:137]; "DistrMaintInput"; $Width; $Height)
		GET WINDOW RECT:C443($TopLeftX; $TopLeftY; $BottomRightX; $BottomRightY)
		SET WINDOW RECT:C444($TopLeftX; $TopLeftY; $TopLeftX+$Width; $TopLeftY+$Height)
		DCM_WO_DistrAreaCtrl("LOAD")
		POPUPMENUC(->DCM_DistrAreas_as; ->DCM_DistrAreas_as; ->[DCM_WorkOrders:137]DistrictArea_s:40)
		DCM_ControlWOBlobs("INIT")
		C_BOOLEAN:C305(DCM_WO_ITEMQChange_b)
		DCM_WO_ITEMQChange_b:=False:C215
		If (Is new record:C668([DCM_WorkOrders:137]))
			Inc_Sequence("DCMAssignMaint"; ->[DCM_WorkOrders:137]AssignID:3)
			[DCM_WorkOrders:137]ContractNo:1:=[DCM_Contracts:136]ContractNo:1
			[DCM_WorkOrders:137]AssignNo:2:=DCM_WONo_al{fn_MaxElement_L(->DCM_WONo_al)}+1
			[DCM_WorkOrders:137]ProjectIS:4:=String:C10(DCM_ProjFileNo_L)
			[DCM_WorkOrders:137]ABPFlag_L:38:=DCM_ABPStatus_L
		Else 
			If ([DCM_WorkOrders:137]AssignID:3=0)
				Inc_Sequence("DCMAssignMaint"; ->[DCM_WorkOrders:137]AssignID:3)
			End if 
			If ([DCM_WorkOrders:137]AssignNo:2=0)
				[DCM_WorkOrders:137]AssignNo:2:=DCM_WONo_al{fn_MaxElement_L(->DCM_WONo_al)}+1
			End if 
			If ([DCM_WorkOrders:137]ContractNo:1#[DCM_Contracts:136]ContractNo:1)
				[DCM_WorkOrders:137]ContractNo:1:=[DCM_Contracts:136]ContractNo:1
			End if 
			If ([DCM_WorkOrders:137]ProjectIS:4#String:C10(DCM_ProjFileNo_L))
				[DCM_WorkOrders:137]ProjectIS:4:=String:C10(DCM_ProjFileNo_L)
			End if 
			
			If ([DCM_WorkOrders:137]ABPFlag_L:38#DCM_ABPStatus_L)
				[DCM_WorkOrders:137]ABPFlag_L:38:=DCM_ABPStatus_L
			End if 
			
		End if 
		
		ARRAY REAL:C219(DCM_WO_ITMLB_ItemU_ar; Size of array:C274(ITMLB_ItemQ_ar))
		C_REAL:C285(DCM_WO_ItemSum_r)
		
		RELATE MANY:C262([DCM_WorkOrders:137])
		ORDER BY:C49([DCM_Project:138]; [DCM_Project:138]BIN:5)
		DCM_WO_PrjLB_Control("INIT")
		DCM_WO_PrjLB_Control("LOAD")
		C_BOOLEAN:C305(DCM_ViewOnly_b)
		If (DCM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "rdo@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(AddProjectBtn; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		C_TEXT:C284(DCM_ABPStatus_txt)
		If (Num:C11([DCM_WorkOrders:137]ProjectIS:4)#DCM_ProjFileNo_L)
			[DCM_WorkOrders:137]ProjectIS:4:=String:C10(DCM_ProjFileNo_L)
		End if 
		
		Case of 
			: ([DCM_WorkOrders:137]ABPFlag_L:38=1)
				DCM_ABPStatus_txt:="Accelerated Bridge"
			: ([DCM_WorkOrders:137]ABPFlag_L:38=2)
				DCM_ABPStatus_txt:="Potential Accelerated Bridge"
			Else 
				DCM_ABPStatus_txt:="Non ABP"
		End case 
		
	: ($FormEvent_L=On Clicked:K2:4)
		C_TEXT:C284($ClickTask_txt)
		$ClickTask_txt:=""
		If (Count parameters:C259>1)
			C_TEXT:C284($2)
			$ClickTask_txt:=$2
		Else 
		End if 
		Case of 
			: ($ClickTask_txt="SAVE")
				//check for unique assignment number before saving it
				C_LONGINT:C283($vlRecCount)
				SET QUERY DESTINATION:C396(Into variable:K19:4; $vlRecCount)
				QUERY:C277([DCM_WorkOrders:137]; [DCM_WorkOrders:137]ContractNo:1=[DCM_Contracts:136]ContractNo:1; *)
				QUERY:C277([DCM_WorkOrders:137];  & ; [DCM_WorkOrders:137]AssignNo:2=[DCM_WorkOrders:137]AssignNo:2)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If (($vlRecCount>0) & (Is new record:C668([DCM_WorkOrders:137])))
					ALERT:C41("This assignment number is already being used. Please enter a different one!")
				Else 
					C_LONGINT:C283($numWkHrs; $i; $NumProjects_L)
					C_BOOLEAN:C305($DoTheSave_b)
					$DoTheSave_b:=True:C214
					If ($DoTheSave_b)
						DCM_ControlWOBlobs("SAVE")
						SAVE RECORD:C53([DCM_WorkOrders:137])
						ACCEPT:C269
					End if 
				End if 
				
			: ($ClickTask_txt="DELETE")
				
				C_TEXT:C284($Msg_txt)
				$Msg_txt:="Are you sure you want to delete this Work Order?"
				
				CONFIRM:C162($Msg_txt; "Delete"; "Cancel")
				If (OK=1)
					C_BOOLEAN:C305($OKtoDelete_b)
					$OKtoDelete_b:=True:C214
					
					If ($OKtoDelete_b)
						DELETE RECORD:C58([DCM_WorkOrders:137])
						ACCEPT:C269
					Else 
						ALERT:C41("Could not get access to delete the Work Hour Proposal!  Deletion of this Assignme"+"nt Canceled!")
					End if 
					
				End if 
				
			: ($ClickTask_txt="CANCEL")
				
				If (DCM_WO_ITEMQChange_b | Modified record:C314([DCM_WorkOrders:137]))
					C_TEXT:C284($msg_txt)
					$msg_txt:="Changes have been made to this Work Order and possibly Bridge Projects!"
					$msg_txt:=$msg_txt+" If you Cancel, your changes to the work order will be lost, and/or "
					$msg_txt:=$msg_txt+"the quantities will be out of sync!"
					$msg_txt:=$msg_txt+" Do you still wish to Exit without Saving ?"
					G_MyConfirm($msg_txt; "Exit without Saving"; "Cancel")
					If (OK=1)
						CANCEL:C270
					End if 
				Else 
					CANCEL:C270
				End if 
				
		End case 
		
End case 