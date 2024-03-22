//%attributes = {"invisible":true}
//Method: LSS_CheckTeamMembership
//Description
//This method used to reset fro inspection edit or delete if still true
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/26/15, 13:18:41
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/26/15 13:19:15)
	// Modified by: Costas Manousakis-(Designer)-(2/17/16 16:28:24)
	Mods_2016_02_bug
	//  `for Convenience allow other members of the same company to edit an inspection
	Mods_2018_11  //Add code to disallow when <>PERS_MyCompany_txt="Mass. Highway Dept."
End if 
C_POINTER:C301($1; $Pointer_ptr)
$Pointer_ptr:=$1
If (Not:C34($Pointer_ptr->))
	ARRAY LONGINT:C221($Keys_aL; 0)
	C_TEXT:C284($Key_txt)
	$Key_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
	
	Begin SQL
		select [LSS_TeamMembers].[LSS_TeamMemberId_L]
		from 
		[LSS_TeamMembers]
		where [LSS_TeamMembers].[LSS_InspectionId_s] = :$Key_txt
		into :$Keys_aL
		
	End SQL
	$Pointer_ptr->:=True:C214
	Case of 
		: ([LSS_Inspection:164]LSS_CreatedBy_s:45=Current user:C182)
			
		: (<>CurrentUser_PID=[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5)
			
		: (<>CurrentUser_PID=[LSS_Inspection:164]LSS_ProjectManagerId_L:9)
			
		: (<>CurrentUser_PID=[LSS_Inspection:164]LSS_TeamLeaderId_L:8)
			
			
		: (Find in array:C230($Keys_aL; <>CurrentUser_PID)>0)
			
		: (<>PERS_MyCompany_txt="Mass. Highway Dept.")
			$Pointer_ptr->:=False:C215
		: ([LSS_Inspection:164]LSS_ConsultantName_txt:10=<>PERS_MyCompany_txt)
			
			//If ((GRP_UserInGroup ("LSS_TeamLeader")=1) | (GRP_UserInGroup ("LSS_TeamMember")=1))
			//CONFIRM("You are not a Team Leader or Team member for this inspection. Do you want to Edit the inspection, or open in ReadOnly mode?";"Read only";"Edit")
			//$Pointer_ptr->:=(OK=1)
			//Else 
			//$Pointer_ptr->:=False
			//End if 
		Else 
			$Pointer_ptr->:=False:C215
	End case 
End if 

//End LSS_CheckTeamMembership