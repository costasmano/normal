//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/22/08, 08:37:19
	// ----------------------------------------------------
	// Method: SC_SetRanking
	// Description
	// Set the ranking in the various scour priority categories
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("SCOUR")
	// Modified by: Costas Manousakis-(Designer)-(12/18/12 17:18:22)
	Mods_2012_12
	//  `Added saving of calc date in parameters table under parameter SC_DateCalc
	Mods_2013_01  //r004 ` Add use of [BridgeInfoLink] table
	//Also add code so data will transfer using [Activity Log] table
	//Modified by: Charles Miller (1/17/13 14:54:38)
End if 
C_LONGINT:C283($i; $j)
ARRAY TEXT:C222($ScourCategories_as; 4)  //Command Replaced was o_ARRAY string length was 1
$ScourCategories_as{1}:="A"
$ScourCategories_as{2}:="B"
$ScourCategories_as{3}:="C"
$ScourCategories_as{4}:="D"
For ($j; 1; Size of array:C274($ScourCategories_as))
	QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]Category:5=$ScourCategories_as{$j})
	ORDER BY:C49([ScourPriorityRank:108]; [ScourPriorityRank:108]LifeTimeRisk:4; <)
	For ($i; 1; Records in selection:C76([ScourPriorityRank:108]))
		GOTO SELECTED RECORD:C245([ScourPriorityRank:108]; $i)
		If (ut_LoadRecordInteractive(->[ScourPriorityRank:108]))
			[ScourPriorityRank:108]Rank:6:=$i
			LogChanges(->[ScourPriorityRank:108]Rank:6; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; 0)
			SAVE RECORD:C53([ScourPriorityRank:108])
		End if 
	End for 
	
End for 
READ WRITE:C146([Parameters:107])
C_BOOLEAN:C305($RecordLoaded_b)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SC_DateCalc")
$RecordLoaded_b:=False:C215
ARRAY POINTER:C280(ptr_Changes; 0; 0)
InitChangeStack(1)

If (Records in selection:C76([Parameters:107])=1)
	
	If (ut_LoadRecordInteractive(->[Parameters:107]))
		$RecordLoaded_b:=True:C214
	End if 
	
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="SC_DateCalc"
	[Parameters:107]Description:2:="Date of last Calculation of Scour Priority Rankings"
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "PARAMETERS")
	PushChange(1; ->[Parameters:107]ParamCode:1)
	PushChange(1; ->[Parameters:107]Description:2)
	$RecordLoaded_b:=True:C214
End if 

If ($RecordLoaded_b)
	[Parameters:107]Value:3:=ut_CreateTimeStamp
	PushChange(1; ->[Parameters:107]Value:3)
	SAVE RECORD:C53([Parameters:107])
	UNLOAD RECORD:C212([Parameters:107])
	FlushGrpChgs(1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
End if 

READ ONLY:C145([Parameters:107])