Case of 
	: (Records in set:C195("UserSet")=1)
		USE SET:C118("UserSet")
		FIRST RECORD:C50([PERS_Groups:109])
		C_TEXT:C284(GRP_NewUserGrpName)
		C_BOOLEAN:C305($Do_copy_b; $KeepTrying_b)
		$Do_copy_b:=False:C215
		$KeepTrying_b:=False:C215
		Repeat 
			GRP_NewUserGrpName:=Request:C163("Enter New Name for new group")
			If (OK=1)
				C_LONGINT:C283($NameExist_L)
				SET QUERY DESTINATION:C396(Into variable:K19:4; $NameExist_L)
				QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=GRP_NewUserGrpName)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($NameExist_L>0)
					CONFIRM:C162("Group named "+GRP_NewUserGrpName+" already exists!"; "Try again"; "Cancel")
					If (Ok=1)
						$KeepTrying_b:=True:C214
					Else 
						$KeepTrying_b:=False:C215
					End if 
				Else 
					$KeepTrying_b:=False:C215
					$Do_copy_b:=True:C214
				End if 
				
			Else 
				$KeepTrying_b:=False:C215
				
			End if 
			
		Until (Not:C34($KeepTrying_b))
		If ($Do_copy_b)
			QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
			ARRAY INTEGER:C220(GRP_GrpMembIDs_aI; 0)
			SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; GRP_GrpMembIDs_aI)
			UNLOAD RECORD:C212([PERS_Groups:109])  //CANCEL
			ADD RECORD:C56([PERS_Groups:109])
			ALL RECORDS:C47([PERS_Groups:109])
			ARRAY INTEGER:C220(GRP_GrpMembIDs_aI; 0)
			//CANCEL
		End if 
		GRP_NewUserGrpName:=""
		
		
	: (Records in set:C195("UserSet")=0)
		ALERT:C41("No Group selected!")
	: (Records in set:C195("UserSet")>1)
		ALERT:C41("Multiple groups selected!")
End case 