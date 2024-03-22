//%attributes = {"invisible":true}
// Method: PRV_MEETINGINP_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 07/02/12, 10:01:19
	// ----------------------------------------------------
	// First Release
	Mods_2012_07
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		If (Is new record:C668(Current form table:C627->))
			[Preservation_Meetings:148]AssignID:2:=[Contract_Assignment_Maintenance:101]AssignID:3
			[Preservation_Meetings:148]MeetingType_s:3:=PRV_NEWMTGTYPE_txt
			Inc_Sequence("PreservMtgs"; ->[Preservation_Meetings:148]MeetingID_L:1)
			GOTO OBJECT:C206([Preservation_Meetings:148]MeetingDate_d:4)
		End if 
		
		Case of 
			: ([Preservation_Meetings:148]MeetingType_s:3="PUBLIC")
				FORM GOTO PAGE:C247(2)
				
			: ([Preservation_Meetings:148]MeetingType_s:3="CSLT")
				FORM GOTO PAGE:C247(1)
		End case 
		ut_SetStringOrTextFilter(->[Preservation_Meetings:148]Purpose_txt:6)
		ut_SetStringOrTextFilter(->[Preservation_Meetings:148]Summary_txt:7)
		ut_SetStringOrTextFilter(->[Preservation_Meetings:148]Attendees_txt:9)
		ut_SetStringOrTextFilter(->[Preservation_Meetings:148]Location_txt:8)
		
		
		If (PRV_LockedAssignment_b)
			OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "DE@Btn"; False:C215)
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 