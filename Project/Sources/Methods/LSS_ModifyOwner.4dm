//%attributes = {"invisible":true}
//Method: LSS_ModifyOwner
//Description
// modify the owner of selected records from the inventory list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/04/18, 17:32:52
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
End if 
//

//check
C_LONGINT:C283($NumRecords_L)
$NumRecords_L:=Records in set:C195("InventorySet")
C_TEXT:C284($NewOnwer_txt)
If ($NumRecords_L>0)
	
	ARRAY TEXT:C222($v_165_034_atxt; 0)
	
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="LSS_Owners")
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
	SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $v_165_034_atxt)
	INSERT IN ARRAY:C227($v_165_034_atxt; 1)
	$v_165_034_atxt{1}:="(blank)"  // blank space holder
	C_LONGINT:C283($Choice_L)
	$Choice_L:=G_PickFromList(->$v_165_034_atxt; "Select Owner to assign ...")
	If ($Choice_L>0)
		//save the set
		COPY SET:C600("InventorySet"; "LSSINVSAVESET")
		$NewOnwer_txt:=Replace string:C233($v_165_034_atxt{$Choice_L}; "(blank)"; "")  //replace the blank spaceholder with blank string
		
		If ($NewOnwer_txt="")
			CONFIRM:C162("You will be clearing the Owner from "+String:C10($NumRecords_L; "###,###,####")+" Ancillary structures! Do you want to continue? This cannot be undone!"; "Continue"; "Cancel")
			
		Else 
			CONFIRM:C162("Ready to change the Owner of "+String:C10($NumRecords_L; "###,###,####")+" Ancillary structures to "+$NewOnwer_txt+"? Do you want to continue? This cannot be undone!"; "Continue"; "Cancel")
			
		End if 
		
		If (OK=1)
			//save the current selection
			CUT NAMED SELECTION:C334([LSS_Inventory:165]; "LSSINVSaveSEL")
			USE SET:C118("LSSINVSAVESET")
			//start the bar
			C_OBJECT:C1216($progress_o)
			$progress_o:=ProgressNew("Updating Owner"; Records in selection:C76([LSS_Inventory:165]); True:C214; " Ancillary Records"; 3)
			C_LONGINT:C283($CountChanged_L; $CountSkipped_L; $CountScanned_L)
			$CountChanged_L:=0
			$CountSkipped_L:=0
			ARRAY TEXT:C222($StructuresSkipped_atxt; 0)
			ARRAY TEXT:C222($StructresNoPermission_atxt; 0)
			C_BOOLEAN:C305(LSS_AllowInventoryEdit_B)
			C_BOOLEAN:C305($RO_State_b)
			$RO_State_b:=Read only state:C362([LSS_Inventory:165])
			//loop thru records, make the change if needed and log it
			FIRST RECORD:C50([LSS_Inventory:165])
			While (Not:C34(End selection:C36([LSS_Inventory:165])))
				//update progress
				UpdateProgressNew($progress_o; Selected record number:C246([LSS_Inventory:165]))
				//make the change only if owner is not the same
				$CountScanned_L:=$CountScanned_L+1
				If ([LSS_Inventory:165]LSS_Owner_s:34#$NewOnwer_txt)
					//check if we have privileges to update this inventory record
					LSS_PermissionModInventory
					
					If (LSS_AllowInventoryEdit_B)
						//load the record to update
						If (ut_LoadRecord(->[LSS_Inventory:165]; 1))  // 1 : try only once
							
							[LSS_Inventory:165]LSS_Owner_s:34:=$NewOnwer_txt
							LogChanges(->[LSS_Inventory:165]LSS_Owner_s:34; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; ->[LSS_Inventory:165]LSS_InventoryId_s:1; 0)
							SAVE RECORD:C53([LSS_Inventory:165])
							$CountChanged_L:=$CountChanged_L+1
						Else 
							
							APPEND TO ARRAY:C911($StructuresSkipped_atxt; [LSS_Inventory:165]LSS_StructureNumber_s:6)
							
						End if 
						
					Else 
						APPEND TO ARRAY:C911($StructresNoPermission_atxt; [LSS_Inventory:165]LSS_StructureNumber_s:6)
						
					End if 
					
				End if 
				
				//check if progress stopped
				If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
					//abort loop
					LAST RECORD:C200([LSS_Inventory:165])
				End if 
				
				NEXT RECORD:C51([LSS_Inventory:165])
			End while 
			
			//quit progress
			Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
			
			//restore the starting seleection
			If ($RO_State_b)
				READ ONLY:C145([LSS_Inventory:165])
			End if 
			USE NAMED SELECTION:C332("LSSINVSaveSEL")
			//restore the highlight set
			HIGHLIGHT RECORDS:C656([LSS_Inventory:165]; "LSSINVSAVESET")
			CLEAR SET:C117("LSSINVSAVESET")
			//redraw the listbox
			REDRAW:C174(Inventory_LB)
			C_TEXT:C284($Message_txt)
			$Message_txt:=\
				"Scanned "+String:C10($CountScanned_L; "###,###,##0")+" Ancillary Structures\n"+\
				"Updated Owner for "+String:C10($CountChanged_L; "###,###,##0")+" Structures"
			If (Size of array:C274($StructuresSkipped_atxt)>0)
				$Message_txt:=$Message_txt+"\n\nThe following structures were skipped because they were locked by another user"
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($StructuresSkipped_atxt))
					$Message_txt:=$Message_txt+"\n"+$StructuresSkipped_atxt{$loop_L}
				End for 
				
			End if 
			If (Size of array:C274($StructresNoPermission_atxt)>0)
				$Message_txt:=$Message_txt+"\n\nThe following structures were skipped because you do not have permission to modify them!"
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($StructresNoPermission_atxt))
					$Message_txt:=$Message_txt+"\n"+$StructresNoPermission_atxt{$loop_L}
				End for 
				
			End if 
			ut_BigAlert($Message_txt; "Update Owner Results")
		End if 
		
	End if 
	
Else 
	ALERT:C41("No Records were selected!")
End if 
//End LSS_ModifyOwner