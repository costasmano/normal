//%attributes = {"invisible":true}
//Method: ut_defineBrgCondRtg
//Description
//  `Create the DOM tree holding the range of bridge cond and corresponting Text value.
//  `Store the tree in parameters table 

// Parameters
// $1 : $Task_txt ("INIT" | "LOADARRAY"  optional - default = "LOADARRAY")

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
	// Modified by: Costas Manousakis-(Designer)-(9/21/17 17:23:30)
	Mods_2017_09_bug
	//  `fixed character case in the search for rows in the tree.
End if 
//
C_TEXT:C284(vsforward)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($Tree_txt; $RowTree_txt; $TheDom_txt)
C_TEXT:C284($TreeName_txt)
$TreeName_txt:="BRG_CONDRANGE"

C_TEXT:C284($Task_txt)
$Task_txt:=""
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Task_txt:=$1
End if 

If ($Task_txt="")
	$Task_txt:="LOADARRAY"
End if 

Case of 
	: ($Task_txt="INIT")
		
		$Tree_txt:=DOM Create XML Ref:C861($TreeName_txt)
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; (-0.1); "BridgeRangeName"; "ERROR-LOW")
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; (4.7); "BridgeRangeName"; "BAD")
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; (6.1); "BridgeRangeName"; "POOR")
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; (7.1); "BridgeRangeName"; "GOOD")
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; (9.1); "BridgeRangeName"; "EXCELLENT")
		$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
		DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; (99999); "BridgeRangeName"; "ERROR-HIGH")
		DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)
		
		QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$TreeName_txt)
		If (Records in selection:C76([Parameters:107])=1)
			If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
				[Parameters:107]Description:2:=$TheDom_txt
				LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
				SAVE RECORD:C53([Parameters:107])
			End if 
		Else 
			CREATE RECORD:C68([Parameters:107])
			[Parameters:107]ParamCode:1:=$TreeName_txt
			[Parameters:107]Description:2:=$TheDom_txt
			LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
			LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
			SAVE RECORD:C53([Parameters:107])
		End if 
		
		DOM CLOSE XML:C722($Tree_txt)
		
	: ($Task_txt="LOADARRAY")
		
		C_LONGINT:C283($NumRows_L; $elvalue_L)
		ARRAY REAL:C219(<>BRG_CONDRANGE_aR; 0)
		ARRAY TEXT:C222(<>BRG_CONDRANGE_atxt; 0)
		
		$TheDom_txt:=ut_GetSysParameter($TreeName_txt)
		If ($TheDom_txt#"")
			$Tree_txt:=DOM Parse XML variable:C720($TheDom_txt)
			$NumRows_L:=DOM Count XML elements:C726($Tree_txt; "Row")
			
			ARRAY REAL:C219(<>BRG_CONDRANGE_aR; $NumRows_L)
			ARRAY TEXT:C222(<>BRG_CONDRANGE_atxt; $NumRows_L)
			
			C_REAL:C285($highValue_r)
			C_TEXT:C284($HighValCode_txt)
			
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; $NumRows_L)
				$RowTree_txt:=DOM Get XML element:C725($Tree_txt; "Row"; $loop_L; $elvalue_L)
				DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; "HighLimit"; $highValue_r)
				DOM GET XML ATTRIBUTE BY NAME:C728($RowTree_txt; "BridgeRangeName"; $HighValCode_txt)
				<>BRG_CONDRANGE_aR{$loop_L}:=$highValue_r
				<>BRG_CONDRANGE_atxt{$loop_L}:=$HighValCode_txt
			End for 
			
			DOM CLOSE XML:C722($Tree_txt)
			
		End if 
		
End case 

//End ut_defineBrgCondRtg