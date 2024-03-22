//%attributes = {"invisible":true,"shared":true}
//Method: Temp_LogLinkPonElem
//Description
// create a loglnk act log entry for the selected Pon_elem_insp record, will 
// create LNK records for both parentID and grandparentID
// to be run as a formula from user mode and only from Boston Server because
// vsForward is NOT calculated - Method shared by component and host 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/05/20, 11:56:36
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03_bug
	
	//formula to be used in user mode
	//Temp_LogLinkPonElem 
	
End if 
//
READ ONLY:C145([Inspections:27])
C_BOOLEAN:C305($one_b; $many_b)
C_TEXT:C284(vsForward)
GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[PON_ELEM_INSP:179]INSPID:21)
If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
	LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
End if 

If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
	LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
End if 

SET AUTOMATIC RELATIONS:C310($one_b; $many_b)

//End Temp_LogLinkPonElem