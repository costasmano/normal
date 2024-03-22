//Method: [PON_ELEM_INSP];"Output_LB".Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/18/19, 13:04:26
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01_bug
End if 
//
If (Records in set:C195("$ListboxSet0")>0)
	C_LONGINT:C283($recs_L; $RecsList_L; $recNum_L)
	$recs_L:=Records in set:C195("$ListboxSet0")
	CUT NAMED SELECTION:C334([PON_ELEM_INSP:179]; "$originalSelection")
	USE SET:C118("$ListboxSet0")
	
	For ($recNum_L; 1; $recs_L)
		GOTO SELECTED RECORD:C245([PON_ELEM_INSP:179]; $recNum_L)
		If (ut_LoadRecordInteractive(->[PON_ELEM_INSP:179]))
			PON_FixParentLinks
			
		Else 
			
			ALERT:C41("Record ID "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+" was locked!")
			
		End if 
		
	End for 
	
	READ ONLY:C145([PON_ELEM_INSP:179])
	
	USE NAMED SELECTION:C332("$originalSelection")
	
Else 
	ALERT:C41("Must Select some records first!")
End if 
//End [PON_ELEM_INSP];"Output_LB".Button