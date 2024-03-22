If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2022-12-27 17:49:15)
	Mods_2022_12_bug
	//  `fixed resizing of window after adding 
	//  `add the new record to current selection to the bottom and scroll to it after adding
	//  `moved code from duplicating group hidden button here- accessible if shift is down
	
End if 

ut_SetWindowSize("create"; Current method name:C684)
ARRAY LONGINT:C221($Records_aL; 0)
SELECTION TO ARRAY:C260(Current form table:C627->; $Records_aL)
C_TEXT:C284(GRP_NewUserGrpName)

If (Shift down:C543)
	//duplicate current record
	Case of 
			
		: (Records in set:C195("UserSet")=1)
			C_LONGINT:C283($col_L; $Recnum_L)
			
			LISTBOX GET CELL POSITION:C971(*; "PersonalGroup_LB"; $col_L; $Recnum_L)
			GOTO SELECTED RECORD:C245(Current form table:C627->; $Recnum_L)
			C_TEXT:C284(GRP_NewUserGrpName)
			GRP_NewUserGrpName:=[PERS_Groups:109]PERS_GroupName_s:2
			C_BOOLEAN:C305($Do_copy_b; $KeepTrying_b)
			$Do_copy_b:=False:C215
			$KeepTrying_b:=False:C215
			
			Repeat 
				GRP_NewUserGrpName:=Request:C163("Enter New Name for new group"; GRP_NewUserGrpName)
				
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
				UNLOAD RECORD:C212([PERS_Groups:109])
				ADD RECORD:C56([PERS_Groups:109])
				ARRAY INTEGER:C220(GRP_GrpMembIDs_aI; 0)
				
				If (Ok=1)
					ARRAY LONGINT:C221($NewRec_aL; 0)
					SELECTION TO ARRAY:C260(Current form table:C627->; $NewRec_aL)
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274($NewRec_aL))
						APPEND TO ARRAY:C911($Records_aL; $NewRec_aL{$loop_L})  // will add record at bottom
					End for 
					CREATE SELECTION FROM ARRAY:C640(Current form table:C627->; $Records_aL)
					OBJECT SET SCROLL POSITION:C906(*; "PersonalGroup_LB"; Size of array:C274($Records_aL))
					LISTBOX SELECT ROW:C912(*; "PersonalGroup_LB"; Size of array:C274($Records_aL); lk replace selection:K53:1)
					
					
					If (Records in selection:C76(Current form table:C627->)=Records in table:C83(Current form table:C627->))
						SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
							String:C10(Records in table:C83(Current form table:C627->))+\
							"]")
						
					Else 
						SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
							String:C10(Records in selection:C76(Current form table:C627->))+\
							" of "+String:C10(Records in table:C83(Current form table:C627->))+\
							"]")
						
					End if 
					
					
				End if   //if added ok
				
			End if 
			
			GRP_NewUserGrpName:=""
			
		: (Records in set:C195("UserSet")=0)
			
			ALERT:C41("No Personnel Group selected to duplicate!")
			
		: (Records in set:C195("UserSet")>1)
			
			ALERT:C41("Multiple Personnel Groups selected!")
			
	End case 
	
Else 
	//normal add
	ADD RECORD:C56(Current form table:C627->)
	If (Ok=1)
		ARRAY LONGINT:C221($NewRec_aL; 0)
		SELECTION TO ARRAY:C260(Current form table:C627->; $NewRec_aL)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($NewRec_aL))
			APPEND TO ARRAY:C911($Records_aL; $NewRec_aL{$loop_L})  // will add record at bottom
		End for 
		CREATE SELECTION FROM ARRAY:C640(Current form table:C627->; $Records_aL)
		OBJECT SET SCROLL POSITION:C906(*; "PersonalGroup_LB"; Size of array:C274($Records_aL))
		LISTBOX SELECT ROW:C912(*; "PersonalGroup_LB"; Size of array:C274($Records_aL); lk replace selection:K53:1)
		
		If (Records in selection:C76(Current form table:C627->)=Records in table:C83(Current form table:C627->))
			SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
				String:C10(Records in table:C83(Current form table:C627->))+\
				"]")
			
		Else 
			SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
				String:C10(Records in selection:C76(Current form table:C627->))+\
				" of "+String:C10(Records in table:C83(Current form table:C627->))+\
				"]")
			
		End if 
		
	End if   // if added ok
	
End if 

ut_SetWindowSize("Reset"; Current method name:C684)


If (Records in selection:C76(Current form table:C627->)=Records in table:C83(Current form table:C627->))
	SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
		String:C10(Records in table:C83(Current form table:C627->))+\
		"]")
	
Else 
	SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
		String:C10(Records in selection:C76(Current form table:C627->))+\
		" of "+String:C10(Records in table:C83(Current form table:C627->))+\
		"]")
	
End if 
C_TEXT:C284(vSearch)
vSearch:=""  //hack because on data change event is fired after clicking the Add button