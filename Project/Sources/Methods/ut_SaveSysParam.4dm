//%attributes = {"invisible":true}
//Method: ut_SaveSysParam
//Description
// Save (create or update) a system parameter in the [Parameters] table
// Parameters
// $1 : $ParamName_txt
// $2 : $Value_txt
// $3 : $DescrOrValue_txt (save value in Descr or in Value field - default "D" ; if not "D" will save in Value field)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/16/16, 12:56:09
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_TEXT:C284(ut_SaveSysParam; $1)
	C_TEXT:C284(ut_SaveSysParam; $2)
	C_TEXT:C284(ut_SaveSysParam; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-06-30 16:12:09)
	Mods_2022_06
	//  `unload the parameters record at the end
End if 
//
C_TEXT:C284($1; $2)

C_TEXT:C284($ParamName_txt; $Value_txt; $DescrOrValue_txt)
$ParamName_txt:=$1
$Value_txt:=$2
$DescrOrValue_txt:="D"
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$DescrOrValue_txt:=$3
End if 

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$ParamName_txt)
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		
		If ($DescrOrValue_txt="D")
			[Parameters:107]Description:2:=$Value_txt
			LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		Else 
			[Parameters:107]Value:3:=$Value_txt
			LogChanges(->[Parameters:107]Value:3; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		End if 
		
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:=$ParamName_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	
	If ($DescrOrValue_txt="D")
		[Parameters:107]Description:2:=$Value_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	Else 
		[Parameters:107]Value:3:=$Value_txt
		LogChanges(->[Parameters:107]Value:3; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	End if 
	
	SAVE RECORD:C53([Parameters:107])
End if 

UNLOAD RECORD:C212([Parameters:107])

//End ut_SaveSysParam