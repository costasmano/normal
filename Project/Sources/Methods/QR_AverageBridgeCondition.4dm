//%attributes = {"shared":true}
// Method: QR_AverageBridgeCondition
// Description
//  ` Returns the average of Items 58 59 60 62 for the current
//  ` Bridge mhd nbis record or of a list of BINs passed as parameter 1
// 
// Parameters
// $0 : $AverageCond_r
// $1 : $BinList_txt (Optional) a text string with a list of BINs comma separated
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/10, 09:14:33
	// ----------------------------------------------------
	
	Mods_2010_04
End if 
C_REAL:C285($0; $AverageCond_r)
$AverageCond_r:=0
C_TEXT:C284($BinList_txt)
C_LONGINT:C283($ArraySize_L; $Loop_L)
C_BOOLEAN:C305($BINLoaded_b)
$BINLoaded_b:=False:C215
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$BinList_txt:=$1
	C_BLOB:C604($BlobArray)
	$BlobArray:=ut_ParseTextToArrayDelim($BinList_txt; ",")
	ARRAY TEXT:C222($BINList_atxt; 0)
	BLOB TO VARIABLE:C533($BlobArray; $BINList_atxt)
	$ArraySize_L:=Size of array:C274($BINList_atxt)
	For ($Loop_L; 1; $ArraySize_L)
		$BINList_atxt{$Loop_L}:=f_TrimStr($BINList_atxt{$Loop_L}; True:C214; True:C214)
	End for 
	For ($Loop_L; $ArraySize_L; 1; -1)
		If ($BINList_atxt{$Loop_L}="")
			DELETE FROM ARRAY:C228($BINList_atxt; $Loop_L)
		End if 
	End for 
	
Else 
	If ([Bridge MHD NBIS:1]BIN:3#"")
		ARRAY TEXT:C222($BINList_atxt; 1)
		$BINList_atxt{1}:=[Bridge MHD NBIS:1]BIN:3
		$BINLoaded_b:=True:C214
	Else 
		ARRAY TEXT:C222($BINList_atxt; 0)
	End if 
	
End if 
$ArraySize_L:=Size of array:C274($BINList_atxt)
If ($ArraySize_L>0)
	
	C_LONGINT:C283($NumItems_L; $ItemSum_L; $NumBins_L)
	C_REAL:C285($AverageSum_r)
	$AverageSum_r:=0
	$NumBins_L:=0
	For ($loop_L; 1; Size of array:C274($BINList_atxt))
		If (Not:C34($BINLoaded_b))
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BINList_atxt{$loop_L})
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			LOAD RECORD:C52([Bridge MHD NBIS:1])
		End if 
		If ([Bridge MHD NBIS:1]BIN:3#"")
			$NumItems_L:=0
			$ItemSum_L:=0
			C_REAL:C285($BridgeAvg_r)
			$NumItems_L:=fn_BridgeConditionAvg(->$BridgeAvg_r; [Bridge MHD NBIS:1]Item58:130; [Bridge MHD NBIS:1]Item59:131; [Bridge MHD NBIS:1]Item60:132; [Bridge MHD NBIS:1]Item62:134)
			If ($NumItems_L>0)
				$AverageSum_r:=$AverageSum_r+($BridgeAvg_r)
				$NumBins_L:=$NumBins_L+1
			End if 
			
		End if 
		
	End for 
	If ($NumBins_L>0)
		$AverageCond_r:=$AverageSum_r/$NumBins_L
	End if 
	
End if 

$0:=$AverageCond_r