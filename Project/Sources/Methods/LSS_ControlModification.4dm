//%attributes = {"invisible":true}
// Method: LSS_ControlModification
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 08/26/14, 17:16:59
	// ----------------------------------------------------
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	
End if 

C_POINTER:C301($1; $Table_ptr)
$Table_ptr:=$1
C_TEXT:C284($2; $FormName_txt)
$FormName_txt:=$2

C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
FORM GET PROPERTIES:C674($Table_ptr->; $FormName_txt; $Width_L; $Height_L)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )

If (Table name:C256($Table_ptr)="LSS_Inspection")
	
End if 
Case of 
	: (Table name:C256($Table_ptr)="LSS_Inventory")
		Repeat 
			LSS_PermissionModInventory
			
			If (User in group:C338(Current user:C182; "Design Access Group"))
				CONFIRM:C162("Do You "+Current user:C182+" want to edit this inventory item"; "Edit"; "Read Only")
				If (OK=1)
					LSS_AllowInventoryEdit_B:=True:C214
				Else 
					LSS_AllowInventoryEdit_B:=False:C215
				End if 
			End if 
			//ut_LSSSetInventoryEntry7
			If (LSS_AllowInventoryEdit_B)
				$Choice_L:=ut_LoadRecordInteractiveV2($Table_ptr)
				LSS_EditingInventory_B:=True:C214
			Else 
				$Choice_L:=2
			End if 
			
			Case of 
				: ($Choice_L=1)
					
					FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
					MODIFY RECORD:C57($Table_ptr->)
					
				: ($Choice_L=2)
					READ ONLY:C145($Table_ptr->)
					DIALOG:C40($Table_ptr->; $FormName_txt)
					
			End case 
			
		Until (Not:C34(LSS_MovingInvRecords_B))
	Else 
		
		If (LSS_AllowInspectionEdit_B)
			$Choice_L:=ut_LoadRecordInteractiveV2($Table_ptr)
		Else 
			$Choice_L:=2
		End if 
		Case of 
			: ($Choice_L=1)
				
				FORM SET INPUT:C55($Table_ptr->; $FormName_txt)
				MODIFY RECORD:C57($Table_ptr->)
				
			: ($Choice_L=2)
				READ ONLY:C145($Table_ptr->)
				DIALOG:C40($Table_ptr->; $FormName_txt)
				
		End case 
		
		
		If (LSS_DuplicateRecordError_B | LSS_Error_B)
			LSS_SetSaveandDelete
			//If (In transaction)
			//CANCEL TRANSACTION
			//End if 
			//CANCEL
		End if 
End case 

