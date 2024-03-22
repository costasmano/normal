If (False:C215)
	//Object Method: [PERS_Groups].Input.PERS_GroupName_s 
	// Modified by: Costas Manousakis-(Designer)-(1/31/13 15:15:29)
	Mods_2013_01
	//  `Added code to enforce uniqueness of Groupname
End if 

C_LONGINT:C283($Count_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=[PERS_Groups:109]PERS_GroupName_s:2; *)
QUERY:C277([PERS_Groups:109];  & [PERS_Groups:109]PERS_GroupID_I:1#[PERS_Groups:109]PERS_GroupID_I:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($Count_L=0)
	PushChange(1; Self:C308)
	OBJECT SET ENABLED:C1123(*; "bValidate@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	ALERT:C41("There is an existing Personnel Group with the same name <"+[PERS_Groups:109]PERS_GroupName_s:2+"> !")
	REJECT:C38
	OBJECT SET ENABLED:C1123(*; "bValidate@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	GOTO OBJECT:C206([PERS_Groups:109]PERS_GroupName_s:2)
	POST KEY:C465(Tab key:K12:28)
	POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
End if 