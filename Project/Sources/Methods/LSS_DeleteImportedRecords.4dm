//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/18/16, 16:30:48
//----------------------------------------------------
//Method: LSS_DeleteImportedRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug  // 
	//Modified by: administrator (2/18/16 16:30:52)
	Mods_2016_02_bug  // Fix it so you can import 05 rercords
	//Modified by: administrator (6/2/16 15:45:10)
	Mods_2017_11_bug
	//Added code to use new progress and to handle uuid fields
	//Modified by: Chuck Miller (11/2/17 15:07:33)
End if 
C_LONGINT:C283($Loop_L; $ImportNumber_L)
C_BOOLEAN:C305($Complete_B; $Proceed_B)
C_TEXT:C284($NextNum_txt; $ImportKey_txt)

$Proceed_B:=False:C215
$Complete_B:=False:C215
Repeat 
	$NextNum_txt:=Request:C163("Enter # for Import deletion or ALL from all import keys ")
	$ImportNumber_L:=Num:C11($NextNum_txt)
	Case of 
		: ($NextNum_txt="ALL")
			CONFIRM:C162("Are you sure you wish to Delete and re-import IMPORT00@")
			If (OK=1)
				$Complete_B:=True:C214
				$Proceed_B:=True:C214
			Else 
				$Complete_B:=True:C214
				$Proceed_B:=False:C215
			End if 
		: ($ImportNumber_L<1)
		: ($ImportNumber_L>10)
		Else 
			C_TEXT:C284($Zeros_txt)
			$Zeros_txt:="00"
			If ($NextNum_txt="ALL")
				$ImportKey_txt:="IMPORT00"
			Else 
				Repeat 
					$Zeros_txt:=Request:C163("Please enter number of zeroes in key mask"; $Zeros_txt)
					$ImportKey_txt:="IMPORT"+String:C10($ImportNumber_L; $Zeros_txt)
					
				Until (OK=1)
				CONFIRM:C162("Are you sure you wish to Delete and re-import "+$ImportKey_txt; "Yes"; "No")
				
			End if 
			
			
			If (OK=1)
				$Complete_B:=True:C214
				$Proceed_B:=True:C214
			Else 
				$Complete_B:=True:C214
				$Proceed_B:=False:C215
			End if 
	End case 
	
Until ($Complete_B)

If ($Proceed_B)
	
	READ WRITE:C146(*)
	QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=$ImportKey_txt+"@")
	CONFIRM:C162("Delete [LSS_Inspection] "+String:C10(Records in selection:C76([LSS_Inspection:164]))+" out of "+String:C10(Records in table:C83([LSS_Inspection:164]))+" records ")
	If (OK=1)
		Repeat 
			DELETE SELECTION:C66([LSS_Inspection:164])
			If (Records in set:C195("LockedSet")=0)
			Else 
				USE SET:C118("LockedSet")
				ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_Inspection] records")
			End if 
		Until (Records in set:C195("LockedSet")=0)
	End if 
	
	
	QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=$ImportKey_txt+"@")
	CONFIRM:C162("Delete [LSS_Inventory] "+String:C10(Records in selection:C76([LSS_Inventory:165]))+" out of "+String:C10(Records in table:C83([LSS_Inventory:165]))+" records ")
	If (OK=1)
		Repeat 
			DELETE SELECTION:C66([LSS_Inventory:165])
			If (Records in set:C195("LockedSet")=0)
			Else 
				USE SET:C118("LockedSet")
				ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_Inventory] records")
			End if 
		Until (Records in set:C195("LockedSet")=0)
	End if 
	QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_AccessibilityId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_Accessibility:159])>0)
		CONFIRM:C162("Delete [LSS_Accessibility] "+String:C10(Records in selection:C76([LSS_Accessibility:159]))+" out of "+String:C10(Records in table:C83([LSS_Accessibility:159]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_Accessibility:159])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_Accessibility] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_DMeterId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_DMeter:161])>0)
		CONFIRM:C162("Delete [LSS_DMeter] "+String:C10(Records in selection:C76([LSS_DMeter:161]))+" out of "+String:C10(Records in table:C83([LSS_DMeter:161]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_DMeter:161])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_DMeter] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_ElementInspectionId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_ElementInspection:163])>0)
		CONFIRM:C162("Delete [LSS_ElementInspection] "+String:C10(Records in selection:C76([LSS_ElementInspection:163]))+" out of "+String:C10(Records in table:C83([LSS_ElementInspection:163]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_ElementInspection:163])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_ElementInspection] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_Photos:166])>0)
		CONFIRM:C162("Delete [LSS_Photos] "+String:C10(Records in selection:C76([LSS_Photos:166]))+" out of "+String:C10(Records in table:C83([LSS_Photos:166]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_Photos:166])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_Photos] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_SignPanelId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_SignPanel:172])>0)
		CONFIRM:C162("Delete [LSS_SignPanel] "+String:C10(Records in selection:C76([LSS_SignPanel:172]))+" out of "+String:C10(Records in table:C83([LSS_SignPanel:172]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_SignPanel:172])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_SignPanel] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_TeamMembers:173]; [LSS_TeamMembers:173]LSS_InspectionId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_TeamMembers:173])>0)
		CONFIRM:C162("Delete [LSS_TeamMembers] "+String:C10(Records in selection:C76([LSS_TeamMembers:173]))+" out of "+String:C10(Records in table:C83([LSS_TeamMembers:173]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_TeamMembers:173])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_TeamMembers] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_TowerDistanceId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_TowerDistance:174])>0)
		CONFIRM:C162("Delete [LSS_TowerDistance] "+String:C10(Records in selection:C76([LSS_TowerDistance:174]))+" out of "+String:C10(Records in table:C83([LSS_TowerDistance:174]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_TowerDistance:174])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_TowerDistance] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_UTId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_UT:175])>0)
		CONFIRM:C162("Delete [LSS_UT] "+String:C10(Records in selection:C76([LSS_UT:175]))+" out of "+String:C10(Records in table:C83([LSS_UT:175]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_UT:175])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_UT] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_UtResult:176])>0)
		CONFIRM:C162("Delete [LSS_UtResult] "+String:C10(Records in selection:C76([LSS_UtResult:176]))+" out of "+String:C10(Records in table:C83([LSS_UtResult:176]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_UtResult:176])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_UtResult] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1=$ImportKey_txt+"@")
	If (Records in selection:C76([LSS_VerticalClearance:177])>0)
		CONFIRM:C162("Delete [LSS_VerticalClearance] "+String:C10(Records in selection:C76([LSS_VerticalClearance:177]))+" out of "+String:C10(Records in table:C83([LSS_VerticalClearance:177]))+" records ")
		If (OK=1)
			Repeat 
				DELETE SELECTION:C66([LSS_VerticalClearance:177])
				If (Records in set:C195("LockedSet")=0)
				Else 
					USE SET:C118("LockedSet")
					ALERT:C41("There are still "+String:C10(Records in set:C195("LockedSet"))+" [LSS_VerticalClearance] records")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
	End if 
	CONFIRM:C162("Do you want to perform re-import of "+$ImportKey_txt+" records ")
	If (OK=1)
		LSS_CloneFromImport
		
	End if 
End if 

//End LSS_DeleteImportedRecords