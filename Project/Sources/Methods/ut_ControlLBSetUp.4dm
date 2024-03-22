//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/16/12, 15:00:41
//----------------------------------------------------
//Method: ut_ControlLBSetUp
//Description
//This method controls creation of or load of records for LB where we are replacing included forms
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/23/12 15:00:42)
	
End if 
C_TEXT:C284($1; $QueryName_txt)
$QueryName_txt:=$1
C_LONGINT:C283($2)
READ ONLY:C145([LB_QueryTable:147])

QUERY:C277([LB_QueryTable:147]; [LB_QueryTable:147]QueryName_s:1=$QueryName_txt)
C_BOOLEAN:C305($Continue_b)
$Continue_b:=True:C214
Case of 
	: (Records in selection:C76([LB_QueryTable:147])=0)
		If (Current user:C182="Designer")
			CREATE RECORD:C68([LB_QueryTable:147])
			[LB_QueryTable:147]QueryName_s:1:=$QueryName_txt
			[LB_QueryTable:147]TableNumber_l:3:=$2
			[LB_QueryTable:147]TableName_s:4:=Table name:C256([LB_QueryTable:147]TableNumber_l:3)
			[LB_QueryTable:147]WindowTitle_s:5:=""
			Inc_Sequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
			LogNewRecord(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0; "LB_QueryTable")
			InitChangeStack(1)
			PushChange(1; ->[LB_QueryTable:147]QueryName_s:1)
			PushChange(1; ->[LB_QueryTable:147]TableNumber_l:3)
			PushChange(1; ->[LB_QueryTable:147]TableName_s:4)
			PushChange(1; ->[LB_QueryTable:147]WindowTitle_s:5)
			FlushGrpChgs(1; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
			
			SAVE RECORD:C53([LB_QueryTable:147])
		Else 
			
		End if 
	: (Records in selection:C76([LB_QueryTable:147])=1)
		
	Else 
		$Continue_b:=False:C215
		ALERT:C41("Design of this search "+$QueryName_txt+" is corrupted. Contact database adminstrator")
		
End case 
If ($Continue_b)
	If (Current user:C182="Designer") & (Shift down:C543)
		ut_LoadRecordInteractiveV2(->[LB_QueryTable:147])
	Else 
		LOAD RECORD:C52([LB_QueryTable:147])
	End if 
Else 
	CANCEL:C270
End if 
//End ut_ControlLBSetUp