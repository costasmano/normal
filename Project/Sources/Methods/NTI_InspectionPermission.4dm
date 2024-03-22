//%attributes = {"invisible":true}
//Method: NTI_InspectionPermission
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/26/16, 11:23:05
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_BOOLEAN:C305(NTI_InspectionPermission; $0)
End if 
//
C_BOOLEAN:C305($Edit_b)
$Edit_b:=False:C215
Case of 
	: (([TIN_Inspections:184]InspApproval:6=BMS Approved) | ([TIN_Inspections:184]InspReview:5=BMS Approved))
	Else 
		$Edit_b:=([TIN_Inspections:184]TeamLeader:11=<>CurrentUser_PID)
		$Edit_b:=$Edit_b | ([TIN_Inspections:184]DistrTnlInspEng:22=<>CurrentUser_PID)
		$Edit_b:=$Edit_b | ([TIN_Inspections:184]CreatedBy:8=Current user:C182)
		C_LONGINT:C283($Count_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([TIN_Insp_TmMembers:187]; [TIN_Insp_TmMembers:187]InspectionID:1=[TIN_Inspections:184]InspectionID:2; *)
		QUERY:C277([TIN_Insp_TmMembers:187];  & ; [TIN_Insp_TmMembers:187]PersonID:2=<>CurrentUser_PID)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$Edit_b:=$Edit_b | ($Count_L>0)
End case 

If ((User in group:C338(Current user:C182; "Design Access Group")) & (Not:C34($Edit_b)))
	CONFIRM:C162("Do you "+Current user:C182+" want to edit this inspection?")
	$Edit_b:=(OK=1)
End if 

$0:=$Edit_b
//End NTI_InspectionPermission