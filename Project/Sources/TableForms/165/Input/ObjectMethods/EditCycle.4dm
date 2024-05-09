//Method: [LSS_Inventory];"Input".EditCycle
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 15, 2024, 18:12:28
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
	: ($FormEvent_L=On Load:K2:1)
		//user has to be allowed to modify this inventory record and also be member of LSS_EditCycle
		If (User in group:C338(Current user:C182; "Design Access Group") | \
			(GRP_UserInGroup("LSS_EditCycle")=1)) & Not:C34(Read only state:C362([LSS_Inventory:165]))
			OBJECT SET VISIBLE:C603(*; "EditCycle"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "EditCycle"; False:C215)
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		
		//get new cycle
		C_LONGINT:C283($newcycle_L; $currcycle_L)
		If ([LSS_Inventory:165]LSS_Cycle_L:39>0)
			$currcycle_L:=[LSS_Inventory:165]LSS_Cycle_L:39
		Else 
			//$currcycle_L:=Num(ut_GetSysParameter ("LSS_DefaultCycle";"4"))
			$currcycle_L:=Storage:C1525.LSS_defaultcycle.value
		End if 
		$newcycle_L:=Num:C11(Request:C163("Enter new cycle in years"; String:C10($currcycle_L)))
		If (OK=1)
			
			If ($newcycle_L<0)
				ALERT:C41("Invalid cycle value entered! "+String:C10($newcycle_L))
			Else 
				CONFIRM:C162("Change cycle to "+String:C10($newcycle_L)+" yrs and update next Scheduled inspection date?"; "Change"; "Cancel")
				
				If (OK=1)
					[LSS_Inventory:165]LSS_Cycle_L:39:=$newcycle_L
					C_OBJECT:C1216($routineinsp_o; $damorspec_o)
					$routineinsp_o:=ds:C1482.LSS_Inspection.query("LSS_InventoryId_s = :1 & LSS_InspectionTypeId_s IN :2 & LSS_InspectionDate_d > :3"; \
						[LSS_Inventory:165]LSS_InventoryId_s:1; New collection:C1472("@1"; "@2"); !00-00-00!).orderBy("LSS_InspectionDate_d DESC")
					$damorspec_o:=ds:C1482.LSS_Inspection.query("LSS_InventoryId_s = :1 & LSS_InspectionTypeId_s IN :2 & LSS_InspectionDate_d > :3"; \
						[LSS_Inventory:165]LSS_InventoryId_s:1; New collection:C1472("@3"; "@4"); !00-00-00!).orderBy("LSS_InspectionDate_d DESC")
					
					Case of 
						: ($routineinsp_o.length>0)
							[LSS_Inventory:165]LSS_NextSchedInsp_d:40:=Add to date:C393($routineinsp_o.first().LSS_InspectionDate_d; $newcycle_L; 0; 0)
						: (Num:C11([LSS_Inventory:165]LSS_YearBuilt_s:11)>0)
							[LSS_Inventory:165]LSS_NextSchedInsp_d:40:=Date:C102("7/1/"+String:C10(Num:C11([LSS_Inventory:165]LSS_YearBuilt_s:11)))
						: ($damorspec_o.length>0)
							[LSS_Inventory:165]LSS_NextSchedInsp_d:40:=Add to date:C393($damorspec_o.first().LSS_InspectionDate_d; $newcycle_L; 0; 0)
						Else 
							ALERT:C41("No recent inspection found and no Year built. Next scheduled inspection date not updated!")
					End case 
					
				End if   // cycle value confirmed
				
			End if   // valid value
			
		End if   //ok in the request
		
		
End case 

//End [LSS_Inventory].Input.EditCycle   