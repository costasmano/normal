//%attributes = {"invisible":true}
//Method: BrgRank_UpdSysParam
//Description
//  ` update the system parameter BRG_RANKINGDATE
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/19/14, 16:39:37
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
READ WRITE:C146([Parameters:107])
C_BOOLEAN:C305($RecordLoaded_b)
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="BRG_RANKINGDATE")
$RecordLoaded_b:=False:C215
If (Records in selection:C76([Parameters:107])=1)
	
	If (ut_LoadRecordInteractive(->[Parameters:107]))
		$RecordLoaded_b:=True:C214
	End if 
	
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="BRG_RANKINGDATE"
	[Parameters:107]Description:2:="Date when the Bridge Rankings were calculated or loaded in the database."
	$RecordLoaded_b:=True:C214
End if 

If ($RecordLoaded_b)
	[Parameters:107]Value:3:=ut_CreateTimeStamp
	SAVE RECORD:C53([Parameters:107])
	UNLOAD RECORD:C212([Parameters:107])
End if 

READ ONLY:C145([Parameters:107])

//End BrgRank_UpdSysParam