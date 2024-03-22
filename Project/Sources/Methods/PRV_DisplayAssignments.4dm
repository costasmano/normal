//%attributes = {"invisible":true}
//Method: PRV_DisplayAssignments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/28/12, 14:58:31
	// ----------------------------------------------------
	//Created : 
	Mods_2012_08
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
READ ONLY:C145(*)

C_TEXT:C284($1; $QueryName_txt)
$QueryName_txt:=$1
C_LONGINT:C283($2)  //table number
C_TEXT:C284($3; $4)
C_TEXT:C284(NamedSelection_txt)
NamedSelection_txt:=$4

InitProcessVar
If (Current user:C182="Designer")
	READ WRITE:C146([LB_QueryTable:147])
Else 
	READ ONLY:C145([LB_QueryTable:147])
	
End if 
QUERY:C277([LB_QueryTable:147]; [LB_QueryTable:147]QueryName_s:1=$QueryName_txt)
C_BOOLEAN:C305($Continue_b)
$Continue_b:=True:C214
Case of 
	: (Records in selection:C76([LB_QueryTable:147])=0) & (Current user:C182="Designer")
		
		CREATE RECORD:C68([LB_QueryTable:147])
		[LB_QueryTable:147]QueryName_s:1:=$QueryName_txt
		[LB_QueryTable:147]TableNumber_l:3:=$2
		[LB_QueryTable:147]TableName_s:4:=Table name:C256([LB_QueryTable:147]TableNumber_l:3)
		[LB_QueryTable:147]WindowTitle_s:5:=$3
		Inc_Sequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
		LogNewRecord(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0; "LB_QueryTable")
		
		InitChangeStack(1)
		PushChange(1; ->[LB_QueryTable:147]QueryName_s:1)
		PushChange(1; ->[LB_QueryTable:147]TableNumber_l:3)
		PushChange(1; ->[LB_QueryTable:147]TableName_s:4)
		PushChange(1; ->[LB_QueryTable:147]WindowTitle_s:5)
		FlushGrpChgs(1; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
		
		SAVE RECORD:C53([LB_QueryTable:147])
	: (Records in selection:C76([LB_QueryTable:147])=1)
	Else 
		$Continue_b:=False:C215
		ALERT:C41("Design of this search "+$QueryName_txt+" is not completed. Contact database adminstrator")
		
End case 
If ($Continue_b)
	If (Current user:C182="Designer")
		ut_LoadRecordInteractiveV2(->[LB_QueryTable:147])
	Else 
		LOAD RECORD:C52([LB_QueryTable:147])
	End if 
	[LB_QueryTable:147]WindowTitle_s:5:=$3
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	
	InitPers
	Compiler_LB
	PRV_Variables("INIT")
	PRV_Variables("LOADGLOBAL")
	
	C_LONGINT:C283($Width; $Height)
	FORM GET PROPERTIES:C674([Contract_Assignment_Maintenance:101]; "PreservationList"; $Width; $Height)
	ut_OpenNewWindow($Width; $Height; 2; 0; ""; "ut_CloseCancel")
	UpdatWindArray(""; Current process:C322)
	DIALOG:C40([Contract_Assignment_Maintenance:101]; "PreservationList")
	
	CLEAR SET:C117("MyLocalSet")
	CLEAR SET:C117("SelectedRecordsSet")
	CLEAR NAMED SELECTION:C333("MyLocalNamedSelection")
	CLOSE WINDOW:C154
	UpdatWindArray(""; Current process:C322; True:C214)
	
End if 

//End PRV_DisplayAssignments