//%attributes = {"invisible":true}
//Method: PON_Delete_Element
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/24/15, 15:57:07
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_TEXT:C284($msg_txt)
C_LONGINT:C283($DefectCount_L; $ProtsysCount_L)
C_LONGINT:C283($myinspID_L; $myElemID_L)
$myinspID_L:=[PON_ELEM_INSP:179]INSPID:21
$myElemID_L:=[PON_ELEM_INSP:179]ELEMID:22
//find if  element has defects  or protective systems
SET QUERY DESTINATION:C396(Into set:K19:2; "$ChildDefects")
QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=$myinspID_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_PARENTID:27=$myElemID_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
SET QUERY DESTINATION:C396(Into set:K19:2; "$ChildProtSys")
QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=$myinspID_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_PARENTID:27=$myElemID_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
SET QUERY DESTINATION:C396(Into set:K19:2; "$Alldescendants1")
QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=$myinspID_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_PARENTID:27=$myElemID_L)
SET QUERY DESTINATION:C396(Into set:K19:2; "$Alldescendants2")
QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]INSPID:21=$myinspID_L; *)
QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28=$myElemID_L)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$DefectCount_L:=Records in set:C195("$ChildDefects")
$ProtsysCount_L:=Records in set:C195("$ChildProtSys")
UNION:C120("$Alldescendants1"; "$Alldescendants2"; "$Alldescendants2")
CLEAR SET:C117("$ChildDefects")
CLEAR SET:C117("$ChildProtSys")
CLEAR SET:C117("$Alldescendants1")
$msg_txt:=""
If ($ProtsysCount_L>0)
	$msg_txt:=String:C10($ProtsysCount_L)+" Protective System(s)"
End if 

If ($DefectCount_L>0)
	
	If ($msg_txt="")
		$msg_txt:=String:C10($DefectCount_L)+" Defect(s)"
	Else 
		$msg_txt:=$msg_txt+"  and  "+String:C10($DefectCount_L)+" Defect(s)"
	End if 
	
End if 


If ($msg_txt="")
	$msg_txt:="Are you sure you want to delete this Element?"
Else 
	$msg_txt:="Are you sure you want to delete this Element?  It has"+$msg_txt
End if 

CONFIRM:C162($msg_txt; "Delete"; "Cancel")

If (OK=1)
	
	LogDeletion(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
	DELETE RECORD:C58([PON_ELEM_INSP:179])
	// now delete defects'
	If (Records in set:C195("$Alldescendants2")>0)
		USE SET:C118("$Alldescendants2")
		InitGrpDelete
		FIRST RECORD:C50([PON_ELEM_INSP:179])
		While (Not:C34(End selection:C36([PON_ELEM_INSP:179])))
			PushGrpDelete(->[PON_ELEM_INSP:179]ELEMID:22)
			NEXT RECORD:C51([PON_ELEM_INSP:179])
		End while 
		FlushGrpDeletions(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
		DELETE SELECTION:C66([PON_ELEM_INSP:179])
	End if 
	CANCEL:C270
	// must run update list  --- this done from on double click event of parent listbox
End if 

CLEAR SET:C117("$Alldescendants2")

//End PON_Delete_Element