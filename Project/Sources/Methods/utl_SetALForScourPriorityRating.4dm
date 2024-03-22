//%attributes = {"invisible":true,"executedOnServer":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/17/13, 14:22:02
//----------------------------------------------------
//Method: utl_SetALForScourPriorityRating
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r004 ` This method runs on server and is meant to prepopulate [ScourPriorityRank] 
	//[Activity Log] records as we are now going to transfer this data
	//It also moves one [Parameters] record [Parameters]ParamCode="SC_DateCalc"
	//Modified by: Charles Miller (1/17/13 14:22:04)
	
End if 
READ ONLY:C145(*)
ALL RECORDS:C47([ScourPriorityRank:108])


C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Records in selection:C76([ScourPriorityRank:108]))
	GOTO SELECTED RECORD:C245([ScourPriorityRank:108]; $Loop_l)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	InitChangeStack(1)
	LogNewRecord(->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; 0; "")
	PushChange(1; ->[ScourPriorityRank:108]Category:5)
	PushChange(1; ->[ScourPriorityRank:108]FailureCost:3)
	PushChange(1; ->[ScourPriorityRank:108]FailureProb:2)
	PushChange(1; ->[ScourPriorityRank:108]LifeTimeRisk:4)
	PushChange(1; ->[ScourPriorityRank:108]Rank:6)
	FlushGrpChgs(1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; 0)
	
End for 
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_DateCalc")

ARRAY POINTER:C280(ptr_Changes; 0; 0)
InitChangeStack(1)
LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
PushChange(1; ->[Parameters:107]Description:2)
PushChange(1; ->[Parameters:107]Value:3)
FlushGrpChgs(1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
//End utl_SetALForScourPriorityRating

