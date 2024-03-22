//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// PRJ_ReturnAccessAllowed
	// User name (OS): cjmiller
	// Date and time: 05/16/07, 15:02:41
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CJMv2  //r060   `05/16/07, 15:02:44 `Add code to control access 
	Mods_2007_CJM_v5303  //r004 `10/23/07, 16:49:42 `Designer has access also
	// Modified by: costasmanousakis-(Designer)-(10/8/08 15:05:51)
	Mods_2008_CM_5404  // ("ACCESS")
	//  `removed option to allow users belonging to the responsible section to have write access to the project.
	Mods_2011_06  // CJ Miller`06/28/11, 10:23:09      ` If [PRJ_ProjectDetails] locked set to non-enterable
End if 
C_BOOLEAN:C305($0; $AccessAllowed_b)
$AccessAllowed_b:=False:C215

Case of 
	: (Locked:C147([PRJ_ProjectDetails:115])=True:C214)
		$AccessAllowed_b:=False:C215
		If (Record number:C243(Current form table:C627->)=New record:K29:1)
			ALERT:C41("Creation of record not allowed as Project detail record is locked")
		End if 
	: (Current user:C182="Designer")
		$AccessAllowed_b:=True:C214
	: (PRJ_MembershipGroup_txt="PRJ_CreateGroup")
		$AccessAllowed_b:=True:C214
	: (PRJ_MembershipGroup_txt="Struct Proj Managers")
		$AccessAllowed_b:=True:C214
	: (GRP_4DUIDinGroup(<>CurrentUser_UID; "Struct Proj Managers")=1)
		$AccessAllowed_b:=True:C214
	: (PRJ_MembershipGroup_txt="PRJ_Tool")
		$AccessAllowed_b:=True:C214
		//: (PRJ_MembershipGroup_txt=[PRJ_ProjectDetails]PRJ_BridgeSectResp_s)
		//$AccessAllowed_b:=True
End case 

$0:=$AccessAllowed_b
//End PRJ_ReturnAccessAllowed