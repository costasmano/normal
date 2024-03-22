//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/08/10, 14:54:21
	// ----------------------------------------------------
	// Method: DCM_P_Input_FM
	// Description
	// Form method for [DCM_Project];"DistrWorkOrderInput"
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(11/29/10 16:45:49)
	Mods_2010_11
	//Bug fix for calc and saving
	// Modified by: costasmanousakis-(Designer)-(12/13/10 09:21:24)
	Mods_2010_12
	// `More Bug fix for calc and saving
	// Modified by: costasmanousakis-(Designer)-(4/11/11 12:25:00)
	Mods_2011_04
	//  `Define vDistrict:=String(Num(DCM_Project]District))
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
		
	: ($FormEvent_L=On Load:K2:1)
		InDoubleClick_B:=False:C215
		DCM_ControlCUs("INITCUS")
		DCM_ControlCUs("INITCUUsed")
		DCM_ControlCUs("LOADCUUsed")
		DCM_ControlCUs("INITLBOXES")
		
		DCM_LOADBrgInfo("INIT")
		DCM_SetBINInfo("INIT")
		If (Is new record:C668([DCM_Project:138]))
			If ([DCM_WorkOrders:137]AssignID:3=0)
				CANCEL:C270
			Else 
				Inc_Sequence("DCMProjMaint"; ->[DCM_Project:138]ProjectID:1)
				//initialize all variables
				[DCM_Project:138]ContractNo:2:=[DCM_Contracts:136]ContractNo:1
				[DCM_Project:138]AssignNo:9:=[DCM_WorkOrders:137]AssignNo:2
				[DCM_Project:138]AssignID:13:=[DCM_WorkOrders:137]AssignID:3
				[DCM_Project:138]Project Type:3:=""
				[DCM_Project:138]BIN:5:=""
			End if 
		Else 
			vBridgeNo:=[DCM_Project:138]BridgeNo:4
			vDistrict:=String:C10(Num:C11([DCM_Project:138]District:8))
			vTown:=[DCM_Project:138]Town:7
			vLocation:=[DCM_Project:138]Location:6
			READ ONLY:C145([Bridge MHD NBIS:1])
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[DCM_Project:138]BIN:5)
			If (Records in selection:C76([Bridge MHD NBIS:1])=1)
				DCM_ControlCUs("LOADAPPRINSP")
				DCM_LOADBrgInfo("LOAD")
			End if 
			
		End if 
		
		DCM_PROJITEMS_CTRL("LOAD")
		C_BOOLEAN:C305(DCM_HideProjNavBtns_b)
		OBJECT SET VISIBLE:C603(*; "DCM_P_Nav_@"; Not:C34(DCM_HideProjNavBtns_b))
		
		C_BOOLEAN:C305(DCM_ViewOnly_b)
		
		If (DCM_ViewOnly_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(asItemsOfSubList; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
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
				
				If (vDistrict="")
					CONFIRM:C162("Cannot save an undefined Bridge number!"; "Cancel"; "Try again")
					If (OK=1)
						CANCEL:C270
					End if 
				Else 
					[DCM_Project:138]BridgeNo:4:=vBridgeNo
					[DCM_Project:138]District:8:=vDistrict
					[DCM_Project:138]Town:7:=vTown
					[DCM_Project:138]Location:6:=vLocation
					[DCM_Project:138]Project Type:3:=[DCM_Project:138]Project Type:3
					DCM_ControlCUs("SAVEUSEDCUS")
					DCM_PROJITEMS_CTRL("SAVE")
					SAVE RECORD:C53([DCM_Project:138])
					ACCEPT:C269
				End if 
				
			: ($ClickTask_txt="DELETE")
				
				CONFIRM:C162("Are you sure you want to delete this Bridge Project record?"; "Yes"; "No")
				If (OK=1)
					DELETE RECORD:C58([DCM_Project:138])
					ACCEPT:C269
				End if 
		End case 
		
	: ($FormEvent_L=On Validate:K2:3)
		If (Modified record:C314([DCM_Project:138]))
			DCM_P_Input_FM(On Clicked:K2:4; "SAVE")
		End if 
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 