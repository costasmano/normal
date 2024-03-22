If (False:C215)
	//June-2001  
	//Object Method: [Dialogs].Inspection.vDefElemts 
	//Create a default list of elements attached to this inspection.  
	//It will OVERWRITE any elements already selected.
	// Modified by: costasmanousakis-(Designer)-(1/19/11 09:51:51)
	Mods_2011_01
	//  `Removed code in an If(False) part.
End if 
C_LONGINT:C283($vTempHList)
$vTempHList:=G_DefInspElmts(True:C214)
If ((OK=1) & (Is a list:C621($vTempHList)))
	If (Is a list:C621(hList2))
		CLEAR LIST:C377(hList2; *)  //clear it first...
	End if 
	hList2:=ut_CopyList($vTempHList)  //..then re-assign it
Else 
	If (Is a list:C621($vTempHList))
		CLEAR LIST:C377($vTempHList; *)  //make sure the return list is cleared
	End if 
End if 
ut_ExpandList(->hList2)