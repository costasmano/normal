// ----------------------------------------------------
// Object Method: RemoveFrGroupBtn
// User name (OS): charlesmiller
// Date and time: 03/06/09, 12:23:40
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/06/09, 12:23:41`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(5/19/11 07:03:08)
	Mods_2011_05
	//  `Use G_PickFromList to avoid errors in v11 where lists cannot be refered to outside the dialog they were displayed
	Mods_2011_06  // CJ Miller`06/20/11, 10:48:27      ` Type all local variables for v11
End if 

If (USGRP_UserListActive_b)
	C_LONGINT:C283($itemref; $nblogin; $i; $newwin; $newgrp; $retcode; $k; $SelectionHlist; $vlNmemberships; $J)
	C_TEXT:C284($itemTxt; $uname; $startup; $pw)
	C_DATE:C307($lastlogin)
	
	ARRAY LONGINT:C221($grparray; 0)
	GET LIST ITEM:C378(User_group_list; Selected list items:C379(User_group_list); $itemref; $itemTxt)
	If (Not:C34(Is user deleted:C616($ItemRef)))
		GET USER PROPERTIES:C611($itemref; $uname; $startup; $pw; $nblogin; $lastlogin; $grparray)
		If (Size of array:C274($grparray)>0)
			ARRAY TEXT:C222(SelectList_arr; 0)
			C_LONGINT:C283(SelectList_Hlist)
			If (Is a list:C621(SelectList_Hlist))
				CLEAR LIST:C377(SelectList_Hlist; *)
			End if 
			SelectList_Hlist:=New list:C375
			For ($i; 1; Size of array:C274($grparray))
				$k:=Find in array:C230(alGrIDS; $grparray{$i})
				APPEND TO ARRAY:C911(SelectList_arr; asGrNames{$k})
				APPEND TO LIST:C376(SelectList_Hlist; asGrNames{$k}; alGrIDS{$k})
			End for 
			$SelectionHlist:=G_PickFromList(->SelectList_arr; "Select Group To Remove")
			If ((OK=1) & ($SelectionHlist>0))
				$newgrp:=$grparray{$SelectionHlist}
				If (User in group:C338($uname; asGrNames{Find in array:C230(alGrIDS; $newgrp)}))
					DELETE FROM ARRAY:C228($grparray; $SelectionHlist; 1)
					$retcode:=Set user properties:C612($itemref; $uname; $startup; *; $nblogin; $lastlogin; $grparray)
					C_LONGINT:C283($UserSubList)
					C_BOOLEAN:C305($Expanded)
					GET LIST ITEM:C378(User_group_list; Selected list items:C379(User_group_list); $itemref; $itemTxt; $UserSubList; $Expanded)
					//SET LIST ITEM(User_group_list;Selected list item(User_group_list);$itemref;$itemTxt;0)
					If (Is a list:C621($UserSubList))
						CLEAR LIST:C377($UserSubList; *)
					End if 
					$vlNmemberships:=Size of array:C274($grparray)
					If ($vlNmemberships>0)
						$UserSubList:=New list:C375
						For ($j; 1; $vlNmemberships)
							G_Add_to_PList($grparray{$j}; $UserSubList)
						End for 
						SET LIST ITEM:C385(User_group_list; $itemref; $itemTxt; $itemref; $UserSubList; $Expanded)
					Else 
						
					End if 
					
					REDRAW:C174(User_group_list)  // Command Replaced was o_REDRAW LIST 
				Else 
					GET LIST ITEM:C378(SelectList_Hlist; Selected list items:C379(SelectList_Hlist); $itemref; $itemTxt; $UserSubList; $Expanded)
					ALERT:C41($uname+" Not member of "+$itemTxt+" ?????")
				End if 
				
			End if 
			
			If (Is a list:C621(SelectList_Hlist))
				CLEAR LIST:C377(SelectList_Hlist; *)
			End if 
		Else 
			ALERT:C41("User "+$uname+" is not a member of any groups!")
		End if 
		
	End if 
End if 
//End Object Method: RemoveFrGroupBtn