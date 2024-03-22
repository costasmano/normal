//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/22/16, 12:48:43
//----------------------------------------------------
//Method: LSS_RemoveDuplicateTeamMembers
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (2/22/16 12:48:46)
	
End if 
ALL RECORDS:C47([LSS_TeamMembers:173])
ARRAY TEXT:C222($LSSInpsectionIds_atxt; 0)
DISTINCT VALUES:C339([LSS_TeamMembers:173]LSS_InspectionId_s:1; $LSSInpsectionIds_atxt)

ARRAY LONGINT:C221($RecordNumbers_aL; 0)
ARRAY LONGINT:C221($ToDeleteRecordNumbers_aL; 0)


C_LONGINT:C283($Loop_L; $DeleteLoop_L)
For ($Loop_L; 1; Size of array:C274($LSSInpsectionIds_atxt))
	QUERY:C277([LSS_TeamMembers:173]; [LSS_TeamMembers:173]LSS_InspectionId_s:1=$LSSInpsectionIds_atxt{$Loop_L})
	ARRAY LONGINT:C221($TeamMembers_aL; 0)
	ARRAY BOOLEAN:C223($Found_aB; 0)
	If (Records in selection:C76([LSS_TeamMembers:173])>1)
		LONGINT ARRAY FROM SELECTION:C647([LSS_TeamMembers:173]; $RecordNumbers_aL)
		DISTINCT VALUES:C339([LSS_TeamMembers:173]LSS_TeamMemberId_L:2; $TeamMembers_aL)
		ARRAY LONGINT:C221($FoundMembers_aL; 0)
		
		For ($DeleteLoop_L; 1; Size of array:C274($RecordNumbers_aL))
			GOTO RECORD:C242([LSS_TeamMembers:173]; $RecordNumbers_aL{$DeleteLoop_L})
			If (Find in array:C230($FoundMembers_aL; [LSS_TeamMembers:173]LSS_TeamMemberId_L:2)>0)
				APPEND TO ARRAY:C911($ToDeleteRecordNumbers_aL; $RecordNumbers_aL{$DeleteLoop_L})
			Else 
				APPEND TO ARRAY:C911($FoundMembers_aL; [LSS_TeamMembers:173]LSS_TeamMemberId_L:2)
			End if 
		End for 
	End if 
End for 

If (Size of array:C274($ToDeleteRecordNumbers_aL)>0)
	UNLOAD RECORD:C212([LSS_TeamMembers:173])
	READ WRITE:C146([LSS_TeamMembers:173])
	CREATE SELECTION FROM ARRAY:C640([LSS_TeamMembers:173]; $ToDeleteRecordNumbers_aL)
	Repeat 
		DELETE SELECTION:C66([LSS_TeamMembers:173])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			DELAY PROCESS:C323(Current process:C322; 20)
			ALERT:C41("Some [LSS_TeamMembers] records locked")
			
		End if 
		
	Until (Records in set:C195("LockedSet")=0)
	
	
End if 
//End LSS_RemoveDuplicateTeamMembers