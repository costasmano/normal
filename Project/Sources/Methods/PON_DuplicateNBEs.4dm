//%attributes = {"invisible":true}
//Method: PON_DuplicateNBEs
//Description
// copy the current selection of NBEs to a new inspection
// Parameters
// $1 : $vlNBISInspectionID - new inspection ID in [Inspections] table
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/16/15, 12:46:54
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//
C_LONGINT:C283($1; $2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($NormalCopy_b)
$NormalCopy_b:=$3
C_LONGINT:C283($NoNBEs_L; $vlNBISInspectionID; $loop_L; $tempElemID)
$vlNBISInspectionID:=$1
$NoNBEs_L:=Records in selection:C76([PON_ELEM_INSP:179])
C_TEXT:C284($NewInspKey_txt)
$NewInspKey_txt:=PON_INSPID2INSPKEY($vlNBISInspectionID)
If ($NoNBEs_L>0)
	MESSAGE:C88(<>sCR+"   Copying BrM "+String:C10($NoNBEs_L)+" NBEs...")
	//first sort them 
	ORDER BY FORMULA:C300([PON_ELEM_INSP:179]; PON_ElemSort)
	ARRAY LONGINT:C221($NewNBEids_aL; $NoNBEs_L)
	ARRAY LONGINT:C221($OldNBEids_aL; $NoNBEs_L)
	SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEMID:22; $OldNBEids_aL)
	For ($loop_L; 1; Size of array:C274($NewNBEids_aL))
		Inc_Sequence("PON_ELEM_INSP"; ->$tempElemID)
		$NewNBEids_aL{$loop_L}:=$tempElemID
	End for 
	
	C_LONGINT:C283($ancestorID_L; PON_ChangeStackLvl_L)
	PON_ChangeStackLvl_L:=$2
	FIRST RECORD:C50([PON_ELEM_INSP:179])
	COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "Copy_OldNBEs")
	
	For ($loop_L; 1; $NoNBEs_L)
		MESSAGE:C88(" ..."+String:C10($loop_L)+" of "+String:C10($NoNBEs_L))
		DUPLICATE RECORD:C225([PON_ELEM_INSP:179])
		[PON_ELEM_INSP:179]ELEMID:22:=$NewNBEids_aL{Find in array:C230($OldNBEids_aL; [PON_ELEM_INSP:179]ELEMID:22)}
		[PON_ELEM_INSP:179]INSPID:21:=$vlNBISInspectionID
		[PON_ELEM_INSP:179]INSPKEY:2:=$NewInspKey_txt
		If ($NormalCopy_b)
			[PON_ELEM_INSP:179]ELEM_MODTIME:18:=""
			[PON_ELEM_INSP:179]ELEM_MODUSERKEY:25:=""
			[PON_ELEM_INSP:179]ELEM_CREATEDATETIME:17:=ISODateTime(Current date:C33(*); Current time:C178(*))
			[PON_ELEM_INSP:179]ELEM_CREATEUSERKEY:24:=Current user:C182
		End if 
		
		If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
			$ancestorID_L:=Find in array:C230($OldNBEids_aL; [PON_ELEM_INSP:179]ELEM_PARENTID:27)
			If ($ancestorID_L>0)
				[PON_ELEM_INSP:179]ELEM_PARENTID:27:=$NewNBEids_aL{$ancestorID_L}
			Else 
				[PON_ELEM_INSP:179]ELEM_PARENTID:27:=0
			End if 
		End if 
		If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
			$ancestorID_L:=Find in array:C230($OldNBEids_aL; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
			If ($ancestorID_L>0)
				[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=$NewNBEids_aL{$ancestorID_L}
			Else 
				[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=0
			End if 
		End if 
		LogNewRecordChanges(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP"; PON_ChangeStackLvl_L)
		If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
			LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179]ELEMID:22)
		End if 
		
		SAVE RECORD:C53([PON_ELEM_INSP:179])
		
		USE NAMED SELECTION:C332("Copy_OldNBEs")
		NEXT RECORD:C51([PON_ELEM_INSP:179])
		COPY NAMED SELECTION:C331([PON_ELEM_INSP:179]; "Copy_OldNBEs")
	End for 
	CLEAR NAMED SELECTION:C333("Copy_OldNBEs")
	
	ARRAY LONGINT:C221($NewNBEids_aL; 0)
	ARRAY LONGINT:C221($OldNBEids_aL; 0)
	
End if 

//End PON_DuplicateNBEs