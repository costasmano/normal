// ----------------------------------------------------
// Object Method: AddToGroupBtn
// User name (OS): charlesmiller
// Date and time: 03/06/09, 12:21:52
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/06/09, 12:21:54`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(5/19/11 07:04:30)
	Mods_2011_05
	//  `Use G_PickFromList to avoid errors in v11 where lists cannot be refered to outside the dialog they were displayed
	Mods_2011_06  // CJ Miller`06/20/11, 10:49:19      ` Type all local variables for v11
End if 

C_LONGINT:C283($itemref; $nblogin; $i; $newwin; $newgrp; $retcode; $grpOwnerID; $SelectionHlist)
C_TEXT:C284($itemTxt; $uname; $startup; $pw)
C_DATE:C307($lastlogin)

ARRAY LONGINT:C221($grparray; 0)
GET LIST ITEM:C378(User_group_list; Selected list items:C379(User_group_list); $itemref; $itemTxt)
$SelectionHlist:=G_PickFromList(->asGrNames; "Select User Group")
If ($SelectionHlist>0)
	$newgrp:=alGrIDS{$SelectionHlist}
	If (USGRP_UserListActive_b)
		If (Not:C34(Is user deleted:C616($ItemRef)))
			GET USER PROPERTIES:C611($itemref; $uname; $startup; $pw; $nblogin; $lastlogin; $grparray)
			ARRAY TEXT:C222(SelectList_arr; 0)
			If ((OK=1) & ($SelectionHlist>0))
				If (User in group:C338($uname; asGrNames{$SelectionHlist}))
					ALERT:C41($uname+" Already member of "+asGrNames{$SelectionHlist})
				Else 
					INSERT IN ARRAY:C227($grparray; 1)
					$grparray{1}:=$newgrp
					$retcode:=Set user properties:C612($itemref; $uname; $startup; *; $nblogin; $lastlogin; $grparray)
					C_LONGINT:C283($UserSubList)
					C_BOOLEAN:C305($Expanded)
					GET LIST ITEM:C378(User_group_list; Selected list items:C379(User_group_list); $itemref; $itemTxt; $UserSubList; $Expanded)
					If (Is a list:C621($UserSubList))
						G_Add_to_PList($newgrp; $UserSubList)
					Else 
						$UserSubList:=New list:C375
						G_Add_to_PList($newgrp; $UserSubList)
						SET LIST ITEM:C385(User_group_list; $itemref; $itemTxt; $itemref; $UserSubList; $Expanded)
					End if 
					
					REDRAW:C174(User_group_list)  // Command Replaced was o_REDRAW LIST 
				End if 
			End if 
			
			If (Is a list:C621(SelectList_Hlist))
				CLEAR LIST:C377(SelectList_Hlist; *)
			End if 
		Else 
			ALERT:C41("Will not Add Deleted Users!")
		End if 
	Else 
		GET GROUP PROPERTIES:C613($newgrp; $uname; $grpOwnerID; $grparray)
	End if 
	
End if 
//End Object Method: AddToGroupBtn