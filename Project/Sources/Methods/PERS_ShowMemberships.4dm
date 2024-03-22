//%attributes = {"invisible":true}
//Method: PERS_ShowMemberships
//Description
// update arrays/collections used to display memberships.
// executed in context of the input form for [Personnel]
// Parameters
// $1  : $Option : "Expand" | "Collapse"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 10, 2022, 18:20:07
	Mods_2022_11
	// ----------------------------------------------------
	C_TEXT:C284(PERS_ShowMemberships; $1)
	
End if 

//
C_TEXT:C284($option)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$option:=$1
End if 
If ($option="")
	$option:="collapse"  // default
End if 

C_TEXT:C284($Name_txt; $Startup_txt; $Password_txt)
C_LONGINT:C283($NumberLogins_L)
C_DATE:C307($LastLogin_d)
ARRAY LONGINT:C221($MemberinGroups_aL; 0)
GET GROUP LIST:C610($GroupNames_atxt; $GroupNumbers_aL)
ARRAY TEXT:C222(4DGroups_atxt; 0)
C_COLLECTION:C1488(ugroups)

Case of 
	: ($option="collapse")
		GRP_GetPersonGroups(New object:C1471("grpNamesPtr"; ->4DPersonnelGroups_atxt; \
			"personID"; [Personnel:42]Person ID:1; \
			"getParents"; False:C215))
		ugroups:=USR_GetUserGroupMemberships([Personnel:42]UserID_4D:12)
		
		ARRAY TEXT:C222($names; 0)
		ARRAY TEXT:C222($main; 0)
		COLLECTION TO ARRAY:C1562(ugroups; $names; "groupname"; $main; "main")
		C_LONGINT:C283($loop_L)
		For ($loop_L; Size of array:C274($names); 1; -1)
			If ($main{$loop_L}#"m")
				DELETE FROM ARRAY:C228($names; $loop_L; 1)
				ugroups.remove($loop_L-1)
			End if 
		End for 
		
		COPY ARRAY:C226($names; 4DGroups_atxt)
		ugroups:=ugroups
		
	: ($option="expand")
		GRP_GetPersonGroups(New object:C1471("grpNamesPtr"; ->4DPersonnelGroups_atxt; \
			"personID"; [Personnel:42]Person ID:1; \
			"getParents"; True:C214; \
			"showlevel"; True:C214))
		
		ugroups:=USR_GetUserGroupMemberships([Personnel:42]UserID_4D:12)
		ARRAY TEXT:C222($names; 0)
		ARRAY TEXT:C222($main; 0)
		COLLECTION TO ARRAY:C1562(ugroups; $names; "groupname"; $main; "main")
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($names))
			If ($main{$loop_L}#"m")
				$names{$loop_L}:="2 - "+$names{$loop_L}
			Else 
				$names{$loop_L}:="1 - "+$names{$loop_L}
				
			End if 
			
		End for 
		COPY ARRAY:C226($names; 4DGroups_atxt)
		ugroups:=ugroups
		
End case 


If (False:C215)
	
	If ([Personnel:42]UserID_4D:12#0)
		
		If (False:C215)
			C_TEXT:C284($methodonError)
			$methodonError:=Method called on error:C704
			C_BOOLEAN:C305(4DError_b)
			4DError_b:=False:C215
			ON ERR CALL:C155("4D_Errors")
			GET USER PROPERTIES:C611([Personnel:42]UserID_4D:12; $Name_txt; $Startup_txt; $Password_txt; $NumberLogins_L; $LastLogin_d; $MemberinGroups_aL)
			ON ERR CALL:C155($methodonError)
			
			If (Not:C34(4DError_b))
				C_LONGINT:C283($Loop_l; $Position_L)
				
				For ($Loop_l; 1; Size of array:C274($MemberinGroups_aL))
					$Position_L:=Find in array:C230($GroupNumbers_aL; $MemberinGroups_aL{$Loop_l})
					If ($Position_L>0)
						APPEND TO ARRAY:C911(4DGroups_atxt; $GroupNames_atxt{$Position_L})
					End if 
					
				End for 
			Else 
				ALERT:C41("4D User ID "+String:C10([Personnel:42]UserID_4D:12)+" not found in 4D Users and Groups!")
			End if 
			
		Else 
			
			ugroups:=USR_GetUserGroupMemberships([Personnel:42]UserID_4D:12)
			
			If (ugroups.count("error")>0)
				OBJECT SET TITLE:C194(*; "NameEmployer"; String:C10([Personnel:42]Person ID:1)+":"+[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5+" - "+[Personnel:42]Employer:9+\
					" - ("+String:C10([Personnel:42]UserID_4D:12)+" : Invalid UserID)")
				
			Else 
				ARRAY TEXT:C222($names; 0)
				ARRAY TEXT:C222($main; 0)
				COLLECTION TO ARRAY:C1562(ugroups; $names; "groupname"; $main; "main")
				C_LONGINT:C283($loop_L)
				For ($loop_L; Size of array:C274($names); 1; -1)
					If ($main{$loop_L}#"m")
						DELETE FROM ARRAY:C228($names; $loop_L; 1)
						ugroups.remove($loop_L-1)
					End if 
				End for 
				
				COPY ARRAY:C226($names; 4DGroups_atxt)
				
			End if 
			
			ugroups:=ugroups
			
		End if 
		
	End if 
	
	QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=[Personnel:42]Person ID:1)
	ARRAY INTEGER:C220($GroupNumbers_ai; 0)
	
	SELECTION TO ARRAY:C260([PERS_GroupMembers:110]GroupID_I:1; $GroupNumbers_ai)
	QUERY WITH ARRAY:C644([PERS_Groups:109]PERS_GroupID_I:1; $GroupNumbers_ai)
	ARRAY TEXT:C222(4DPersonnelGroups_atxt; 0)
	SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupName_s:2; 4DPersonnelGroups_atxt)
	
End if 

//End PERS_ShowMemberships   