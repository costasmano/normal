//%attributes = {"invisible":true}
//Method: NTI_DuplicateElements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/02/18, 11:14:13
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	
	C_LONGINT:C283(NTI_DuplicateElements; $1; $2; $3)
	C_OBJECT:C1216(NTI_DuplicateElements; $4)
	
	// Modified by: Costas Manousakis-(Designer)-(8/14/20 15:43:33)
	Mods_2020_08_bug
	//  `fixed bug [NTI_ELEM_TIN_INSP]ELEM_GRANDPARENT_ID were referencing as a parent table [Inspections] not [Tin_inspections] 
	//  `Call Reference #742
End if 
//
C_LONGINT:C283($1; $2; $3; $CurrentInspectionID_L; $NewInspectionID_L; $NoNTI_Elements_L; $loop_L; $tempElemID; $NumberProcessed_L; $progress_L)
$CurrentInspectionID_L:=$1
$NewInspectionID_L:=$2
$NumberProcessed_L:=$3
C_OBJECT:C1216($4; $progressObj_o)
$progressObj_o:=$4
QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=$CurrentInspectionID_L)
//
ORDER BY FORMULA:C300([NTI_ELEM_TIN_INSP:185]; NTI_ElemSort_TIN)

ARRAY LONGINT:C221($RecordNumbers_aL; 0)
$NoNTI_Elements_L:=Records in selection:C76([NTI_ELEM_TIN_INSP:185])
LONGINT ARRAY FROM SELECTION:C647([NTI_ELEM_TIN_INSP:185]; $RecordNumbers_aL)

If ($NoNTI_Elements_L>0)
	//first sort them 
	
	
	ARRAY LONGINT:C221($NewNTIids_aL; $NoNTI_Elements_L)
	ARRAY LONGINT:C221($OldNTIids_aL; $NoNTI_Elements_L)
	SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEMID:2; $OldNTIids_aL)
	For ($loop_L; 1; Size of array:C274($NewNTIids_aL))
		Inc_Sequence("NTI_ELEM_TIN_INSP"; ->$tempElemID)
		$NewNTIids_aL{$loop_L}:=$tempElemID
	End for 
	
	C_LONGINT:C283($ancestorID_L)
	
	
	For ($loop_L; 1; $NoNTI_Elements_L)
		$NumberProcessed_L:=$NumberProcessed_L+1
		UpdateProgressNew($progressObj_o; $NumberProcessed_L)
		
		GOTO RECORD:C242([NTI_ELEM_TIN_INSP:185]; $RecordNumbers_aL{$loop_L})
		
		DUPLICATE RECORD:C225([NTI_ELEM_TIN_INSP:185])
		[NTI_ELEM_TIN_INSP:185]ELEMID:2:=$NewNTIids_aL{Find in array:C230($OldNTIids_aL; [NTI_ELEM_TIN_INSP:185]ELEMID:2)}
		[NTI_ELEM_TIN_INSP:185]InspectionID:1:=$NewInspectionID_L
		
		
		If (DupInsp_CopyAsIS_L=1)
		Else 
			[NTI_ELEM_TIN_INSP:185]ELEM_CREATEDATETIME:4:=ISODateTime(Current date:C33(*); Current time:C178(*))
			[NTI_ELEM_TIN_INSP:185]ELEM_CREATEUSER:5:=Current user:C182
			[NTI_ELEM_TIN_INSP:185]ELEM_MODDATETIME:10:=""
			[NTI_ELEM_TIN_INSP:185]ELEM_MODUSER:11:=""
			
		End if 
		
		If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8>0)
			$ancestorID_L:=Find in array:C230($OldNTIids_aL; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8)
			If ($ancestorID_L>0)
				[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8:=$NewNTIids_aL{$ancestorID_L}
			Else 
				[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8:=0
			End if 
		End if 
		If ([NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26>0)
			$ancestorID_L:=Find in array:C230($OldNTIids_aL; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26)
			If ($ancestorID_L>0)
				[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26:=$NewNTIids_aL{$ancestorID_L}
			Else 
				[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26:=0
			End if 
		End if 
		LogNewRecordChanges(->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; "NTI_ELEM_TIN_INSP"; 1; ->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8)
		
		If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8>0)
			LogLink(->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2)
		End if 
		If ([NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26>0)
			LogLink(->[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2)
		End if 
		
		SAVE RECORD:C53([NTI_ELEM_TIN_INSP:185])
		UNLOAD RECORD:C212([NTI_ELEM_TIN_INSP:185])
		
	End for 
	
	ARRAY LONGINT:C221($NewNBEids_aL; 0)
	ARRAY LONGINT:C221($OldNBEids_aL; 0)
	
End if 
$progress_L:=OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6)
Progress QUIT($progress_L)

//End NTI_DuplicateElements