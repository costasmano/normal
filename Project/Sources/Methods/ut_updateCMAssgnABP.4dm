//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/18/09, 10:42:31
	// ----------------------------------------------------
	// Method: ut_updateCMAssgnABP
	// Description
	// Update the ABP flag in the assignments for the Bridge Preservation module.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
	// Modified by: costasmanousakis-(Designer)-(4/14/09 13:05:09)
	Mods_2009_04
	//  `Modified to searching for "%ABP%" instead of "Accel%Bridge%"
	// Modified by: costasmanousakis-(Designer)-(12/21/09 16:04:19)
	Mods_2009_12
	//Changed the comparison to match the new description of the ABP attributes
	
End if 
ALL RECORDS:C47([Contract_Assignment_Maintenance:101])
FIRST RECORD:C50([Contract_Assignment_Maintenance:101])
C_LONGINT:C283($Pinfo_L; $FlagValue_L)
READ ONLY:C145([PRJ_ProjectFile:117])
READ ONLY:C145([PRJ_Attributes:130])
READ ONLY:C145([PRJ_ATTRFileNoXrefs:131])
ARRAY LONGINT:C221($pf_attrIDs_aL; 0)
ARRAY TEXT:C222($pf_attrNames_atxt; 0)
While (Not:C34(End selection:C36([Contract_Assignment_Maintenance:101])))
	If ([Contract_Assignment_Maintenance:101]ProjectIS:4#"")
		$FlagValue_L:=0
		$Pinfo_L:=Num:C11([Contract_Assignment_Maintenance:101]ProjectIS:4)
		QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=$Pinfo_L)
		If (Records in selection:C76([PRJ_ATTRFileNoXrefs:131])>0)
			SELECTION TO ARRAY:C260([PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; $pf_attrIDs_aL)
			QUERY WITH ARRAY:C644([PRJ_Attributes:130]ATTR_ID_l:1; $pf_attrIDs_aL)
			SELECTION TO ARRAY:C260([PRJ_Attributes:130]ATTR_Name_s:2; $pf_attrNames_atxt)
			If (Find in array:C230($pf_attrNames_atxt; "Pot@Accel@Bridge@")>0)
				$FlagValue_L:=2
			Else 
				If (Find in array:C230($pf_attrNames_atxt; "@ABP@")>0)
					$FlagValue_L:=1
				End if 
			End if 
			If (Find in array:C230($pf_attrNames_atxt; "Cand ABP@")>0)
				$FlagValue_L:=2
			Else 
				If (Find in array:C230($pf_attrNames_atxt; "ABP@")>0)
					$FlagValue_L:=1
				End if 
			End if 
			
		End if 
		If ($FlagValue_L#[Contract_Assignment_Maintenance:101]ABPFlag_L:38)
			If (ut_LoadRecordInteractive(->[Contract_Assignment_Maintenance:101]))
				[Contract_Assignment_Maintenance:101]ABPFlag_L:38:=$FlagValue_L
				SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
			End if 
			
		End if 
		
	End if 
	NEXT RECORD:C51([Contract_Assignment_Maintenance:101])
End while 
ARRAY LONGINT:C221($pf_attrIDs_aL; 0)
ARRAY TEXT:C222($pf_attrNames_atxt; 0)