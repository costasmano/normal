If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/19/09 10:41:09)
	Mods_2009_CM_5404
	//  `Added the object method to adjust the ABP status display variable.
	// Modified by: costasmanousakis-(Designer)-(12/21/09 16:00:11)
	Mods_2009_12
	//Changed the comparison to match the new description of the ABP attributes
End if 

Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($Pinfo_L; $FlagValue_L)
		$FlagValue_L:=0
		$Pinfo_L:=Num:C11([Contract_Assignment_Maintenance:101]ProjectIS:4)
		READ ONLY:C145([PRJ_ATTRFileNoXrefs:131])
		READ ONLY:C145([PRJ_Attributes:130])
		QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=$Pinfo_L)
		If (Records in selection:C76([PRJ_ATTRFileNoXrefs:131])>0)
			SELECTION TO ARRAY:C260([PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; $pf_attrIDs_aL)
			QUERY WITH ARRAY:C644([PRJ_Attributes:130]ATTR_ID_l:1; $pf_attrIDs_aL)
			SELECTION TO ARRAY:C260([PRJ_Attributes:130]ATTR_Name_s:2; $pf_attrNames_atxt)
			If (Find in array:C230($pf_attrNames_atxt; "Pot@Accel@Bridge@")>0)
				$FlagValue_L:=2
			Else 
				If (Find in array:C230($pf_attrNames_atxt; "@Accel@Bridge@")>0)
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
			[Contract_Assignment_Maintenance:101]ABPFlag_L:38:=$FlagValue_L
			Case of 
				: ([Contract_Assignment_Maintenance:101]ABPFlag_L:38=1)
					CM_ABPStatus_txt:="Accelerated Bridge"
				: ([Contract_Assignment_Maintenance:101]ABPFlag_L:38=2)
					CM_ABPStatus_txt:="Potential Accelerated Bridge"
				Else 
					CM_ABPStatus_txt:="Non ABP"
			End case 
		End if 
		READ WRITE:C146([PRJ_ATTRFileNoXrefs:131])
		READ WRITE:C146([PRJ_Attributes:130])
		
End case 
