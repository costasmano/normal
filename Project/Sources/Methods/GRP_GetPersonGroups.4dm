//%attributes = {"invisible":true}
//Method: GRP_GetPersonGroups
//Description
// get list of all groups that a person belongs to.
// Parameters
// $1 : $parametersObject
//  // "grpIDsPtr" : $GrpIDs_ptr
//  // "grpNamesPtr" : $GrpNames_ptr
//  // "personID" : $PersonID (optional - pass 0 for current PID
//  // "getParents" : $getparentgroups_b :  (optional)
//  // "showlevel" : $Showgroplevel_b :  (optional only used if "getParents":true)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-04-01, 10:06:50
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
	
	C_OBJECT:C1216(GRP_GetPersonGroups; $1)
End if 
//

C_OBJECT:C1216($1)

C_POINTER:C301($GrpIDs_ptr; $GrpNames_ptr)
C_LONGINT:C283($PersonID)
C_BOOLEAN:C305($getparentgroups_b; $Showgroplevel_b)

$PersonID:=<>CURRENTUSER_PID
$getparentgroups_b:=False:C215
$Showgroplevel_b:=False:C215

If (OB Is defined:C1231($1; "personID"))
	If ($1.personID>0)
		$PersonID:=$1.personID
	End if 
End if 

If (OB Is defined:C1231($1; "getParents"))
	
	If ($1.getParents=True:C214)
		$getparentgroups_b:=True:C214
	End if 
	
End if 
If (OB Is defined:C1231($1; "showlevel"))
	
	If ($1.showlevel=True:C214)
		$Showgroplevel_b:=True:C214
	End if 
	
End if 

ARRAY INTEGER:C220($GrpIDS_ai; 0)
ARRAY TEXT:C222($grpNames_atxt; 0)

QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=$PersonID)
SELECTION TO ARRAY:C260([PERS_GroupMembers:110]GroupID_I:1; $GrpIDS_ai)
QUERY WITH ARRAY:C644([PERS_Groups:109]PERS_GroupID_I:1; $GrpIDS_ai)
SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupName_s:2; $grpNames_atxt)

If ($getparentgroups_b)
	
	ARRAY INTEGER:C220($grpstoSearch_ai; Size of array:C274($GrpIDS_ai))
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($GrpIDS_ai))
		$grpstoSearch_ai{$loop_L}:=(-1*$GrpIDS_ai{$loop_L})
	End for 
	
	QUERY WITH ARRAY:C644([PERS_GroupMembers:110]PersonID_I:2; $grpstoSearch_ai)
	
	ARRAY INTEGER:C220($ParentgrpIDs_ai; 0)
	SELECTION TO ARRAY:C260([PERS_GroupMembers:110]GroupID_I:1; $ParentgrpIDs_ai)
	
	C_TEXT:C284($LevelPrefix_txt)
	$LevelPrefix_txt:=""
	
	While (Size of array:C274($ParentgrpIDs_ai)>0)
		ARRAY INTEGER:C220($grpstoSearch_ai; 0)
		For ($loop_L; Size of array:C274($ParentgrpIDs_ai); 1; -1)
			If (Find in array:C230($GrpIDS_ai; $ParentgrpIDs_ai{$loop_L})>0)
				//already scanned this group
				DELETE FROM ARRAY:C228($ParentgrpIDs_ai; $loop_L; 1)
			Else 
				//add it
				APPEND TO ARRAY:C911($GrpIDS_ai; $ParentgrpIDs_ai{$loop_L})
				//change to negative for searching further
				APPEND TO ARRAY:C911($grpstoSearch_ai; (-1*$ParentgrpIDs_ai{$loop_L}))
			End if 
		End for 
		//get names of parents left
		QUERY WITH ARRAY:C644([PERS_Groups:109]PERS_GroupID_I:1; $ParentgrpIDs_ai)
		ARRAY TEXT:C222($parentNames_atxt; 0)
		SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupName_s:2; $parentNames_atxt)
		If ($Showgroplevel_b)
			$LevelPrefix_txt:=$LevelPrefix_txt+"-"
		End if 
		
		//add names to list
		For ($loop_L; 1; Size of array:C274($parentNames_atxt))
			APPEND TO ARRAY:C911($grpNames_atxt; $LevelPrefix_txt+$parentNames_atxt{$loop_L})
		End for 
		
		If (Size of array:C274($grpstoSearch_ai)>0)
			QUERY WITH ARRAY:C644([PERS_GroupMembers:110]PersonID_I:2; $grpstoSearch_ai)
			ARRAY INTEGER:C220($ParentgrpIDs_ai; 0)
			SELECTION TO ARRAY:C260([PERS_GroupMembers:110]GroupID_I:1; $ParentgrpIDs_ai)
			
		End if 
		
	End while 
	
End if 

If (OB Is defined:C1231($1; "grpIDsPtr"))
	$GrpIDs_ptr:=$1.grpIDsPtr
	COPY ARRAY:C226($GrpIDS_ai; $GrpIDs_ptr->)
End if 

If (OB Is defined:C1231($1; "grpNamesPtr"))
	$GrpNames_ptr:=$1.grpNamesPtr
	COPY ARRAY:C226($grpNames_atxt; $GrpNames_ptr->)
End if 

//End GRP_GetPersonGroups