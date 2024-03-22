//%attributes = {"invisible":true}
//Method: PON_ELEMINP_SAVE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 17:07:35
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(9/25/15 16:59:14)
	Mods_2015_09_bug
	//  `Check also if the parent or grandparent key of children is still the same; 
	//  `Search again for all inspection elements- dont use set "PON_LISTINSPELEMS". set gets updated when back to the list.
	//  `If actions occur while in input form, the set does not get updated.
	//  `do the check only if the element is not a smart flag (defect)
End if 
//
C_BOOLEAN:C305($0)
$0:=False:C215
If (PON_ValidateElemInput)
	// check if env changed
	PON_RecordAllChanges
	SAVE RECORD:C53([PON_ELEM_INSP:179])
	// check if elem key and Enviroment of children is same - only needed if element is not a defect
	If ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4#"Y")
		C_LONGINT:C283($ChildNotsaneEnv_L; $grandChildNotsaneEnv_L; $CurrEnvKey_L; $CurrElemKey_L; $currElemID_L)
		$CurrEnvKey_L:=[PON_ELEM_INSP:179]ENVKEY:5
		$CurrElemKey_L:=[PON_ELEM_INSP:179]ELEM_KEY:3
		$currElemID_L:=[PON_ELEM_INSP:179]ELEMID:22
		COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "$TempEleminspSel")
		
		QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=[Inspections:27]InspID:2)
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "PON_CHILD_BADENV")
		QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_PARENTID:27=$currElemID_L; *)
		QUERY SELECTION:C341([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ENVKEY:5#$CurrEnvKey_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "PON_GRANDCHILD_BADENV")
		QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28=$currElemID_L; *)
		QUERY SELECTION:C341([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ENVKEY:5#$CurrEnvKey_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		UNION:C120("PON_CHILD_BADENV"; "PON_GRANDCHILD_BADENV"; "PON_CHILD_BADENV")
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "PON_CHILD_BADKEY")
		QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_PARENTID:27=$currElemID_L; *)
		QUERY SELECTION:C341([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4#$CurrElemKey_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		UNION:C120("PON_CHILD_BADENV"; "PON_CHILD_BADKEY"; "PON_CHILD_BADENV")
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "PON_GRANDCHILD_BADKEY")
		QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28=$currElemID_L; *)
		QUERY SELECTION:C341([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19#$CurrElemKey_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		UNION:C120("PON_CHILD_BADENV"; "PON_GRANDCHILD_BADKEY"; "PON_CHILD_BADENV")
		
		If (Records in set:C195("PON_CHILD_BADENV")>0)
			ALERT:C41("Adjusting Parent/Grandparent and/or Enviroment of Children Elements!")
			If (Records in set:C195("PON_CHILD_BADENV")>0)
				USE SET:C118("PON_CHILD_BADENV")
				FIRST RECORD:C50([PON_ELEM_INSP:179])
				While (Not:C34(End selection:C36([PON_ELEM_INSP:179])))
					InitChangeStack(PON_ChangeStackLvl_L)
					If ([PON_ELEM_INSP:179]ENVKEY:5#$CurrEnvKey_L)
						[PON_ELEM_INSP:179]ENVKEY:5:=$CurrEnvKey_L
						PushChange(PON_ChangeStackLvl_L; ->[PON_ELEM_INSP:179]ENVKEY:5)
					End if 
					If (Is in set:C273("PON_CHILD_BADKEY"))
						[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4:=$CurrElemKey_L
						PushChange(PON_ChangeStackLvl_L; ->[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)
					End if 
					If (Is in set:C273("PON_GRANDCHILD_BADKEY"))
						[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19:=$CurrElemKey_L
						PushChange(PON_ChangeStackLvl_L; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)
					End if 
					FlushGrpChgs(PON_ChangeStackLvl_L; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
					SAVE RECORD:C53([PON_ELEM_INSP:179])
					NEXT RECORD:C51([PON_ELEM_INSP:179])
				End while 
			End if 
			
		End if 
		
		CLEAR SET:C117("PON_CHILD_BADENV")
		CLEAR SET:C117("PON_GRANDCHILD_BADENV")
		CLEAR SET:C117("PON_CHILD_BADKEY")
		CLEAR SET:C117("PON_GRANDCHILD_BADKEY")
		USE NAMED SELECTION:C332("$TempEleminspSel")
		CLEAR NAMED SELECTION:C333("$TempEleminspSel")
		
	End if 
	
	$0:=True:C214
	
End if 

//End PON_ELEMINP_SAVE