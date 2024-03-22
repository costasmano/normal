//%attributes = {"invisible":true}
//Method: BrgRank_CopyToBridge
//Description
//  `Copy rank from Bridge Rank Calculations to Bridge MHD NBIS table
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/19/14, 14:59:41
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
End if 
//

COPY NAMED SELECTION:C331([BridgeRankResult:157]; "$TempBridgeRankResults")
//start the bar
C_LONGINT:C283($TotalNum_L; $CurrentValue_L; $Updated_L)
C_TEXT:C284(vsForward)
ALL RECORDS:C47([Bridge MHD NBIS:1])
$TotalNum_L:=Records in selection:C76([Bridge MHD NBIS:1])
//C_LONGINT(<>ProgressPID)
//<>ProgressPID:=StartProgress ("Applying Rank";"NONE";"Applying Rank to "+String($TotalNum_L)+" records";"Remaining Records")
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Applying Rank to "+String:C10($TotalNum_L)+" records"; $TotalNum_L; False:C215; ""; 3)
//initialize the bar
$CurrentValue_L:=1
$Updated_L:=0
FIRST RECORD:C50([Bridge MHD NBIS:1])
While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
	If (($CurrentValue_L%($TotalNum_L/150))=0) | ($CurrentValue_L=1)
		//update the bar
		//UpdateProgress ($CurrentValue_L;$TotalNum_L)
		//update progress
		UpdateProgressNew($progressObj_o; $CurrentValue_L)
		
	End if 
	C_LONGINT:C283($currBridgeRank_L; $NewRank_L)
	$currBridgeRank_L:=[Bridge MHD NBIS:1]Rank:6
	$CurrentValue_L:=$CurrentValue_L+1
	QUERY:C277([BridgeRankResult:157]; [BridgeRankResult:157]UniqueKey_s:2=([Bridge MHD NBIS:1]BIN:3+String:C10([BridgeRankCalc:156]RunID_L:1; 11*"0")))
	
	If (Records in selection:C76([BridgeRankResult:157])=1)
		FIRST RECORD:C50([BridgeRankResult:157])
		$NewRank_L:=[BridgeRankResult:157]Rank_L:4
		
		If ($NewRank_L=999999)
			$NewRank_L:=0
		End if 
		
	Else 
		$NewRank_L:=0
	End if 
	
	If ($currBridgeRank_L#$NewRank_L)
		
		If (ut_LoadRecordInteractiveV2(->[Bridge MHD NBIS:1])=1)
			[Bridge MHD NBIS:1]Rank:6:=$NewRank_L
			LogChanges(->[Bridge MHD NBIS:1]Rank:6; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			SAVE RECORD:C53([Bridge MHD NBIS:1])
			$Updated_L:=$Updated_L+1
		End if 
		
	End if 
	
	NEXT RECORD:C51([Bridge MHD NBIS:1])
End while 

//stop the progress bar
//CALL PROCESS(<>ProgressPID)
//quit progress
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

BrgRank_UpdSysParam
ALERT:C41("Updated Rank for "+String:C10($Updated_L)+" out of "+String:C10($TotalNum_L)+" Bridge Records!")

USE NAMED SELECTION:C332("$TempBridgeRankResults")
CLEAR NAMED SELECTION:C333("$TempBridgeRankResults")
//End BrgRank_CopyToBridge