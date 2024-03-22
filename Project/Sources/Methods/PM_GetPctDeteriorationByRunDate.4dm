//%attributes = {"invisible":true}
//Method: PM_GetPctDeteriorationByRunDate
//Description
// 
// Parameters
// $0 : $PctDet
// $1 : $RunDate_d (optional)
// $2 : $BIN_s (Optional)
// $3 : $avgCond_r (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/29/14, 10:26:53
	// ----------------------------------------------------
	//Created : 
	Mods_2014_01
	// Modified by: Costas Manousakis-(Designer)-(12/1/17 13:32:29)
	Mods_2017_12_bug
	//  `if nothing found in the [Pontis_Metric_Data] table try to use the averages in DOM tree BridgeRankHIChgByAvgCond_txt
	//  `added 3rd parameter for the Average bridge condition
	//  `changed 2nd param to text ; added extra checks for 'bad' data from the [Pontis_Metric_Data] table
End if 
//
C_REAL:C285($0; $PctDet)
$PctDet:=0

C_DATE:C307($RunDate_d)
$RunDate_d:=[Pontis_Metrics:41]PM_ImportDate_d:4
If (Count parameters:C259>0)
	C_DATE:C307($1)
	If ($1#!00-00-00!)
		$RunDate_d:=$1
	End if 
End if 
C_TEXT:C284($BIN_s)
$BIN_s:=[Bridge MHD NBIS:1]BIN:3
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$BIN_s:=$2
End if 

C_REAL:C285($avgCond_r)
$avgCond_r:=10  //will use the overall average if we don't have a proper average
If (Count parameters:C259>2)
	C_REAL:C285($3)
	$avgCond_r:=$3
Else 
	//try the current bridge record if loaded
	If ([Bridge MHD NBIS:1]BIN:3#"")
		C_LONGINT:C283($numValidItems_L)
		$numValidItems_L:=fn_BridgeConditionAvg(->$avgCond_r; [Bridge MHD NBIS:1]Item58:130; [Bridge MHD NBIS:1]Item59:131; [Bridge MHD NBIS:1]Item60:132; [Bridge MHD NBIS:1]Item62:134)
	End if 
End if 

C_REAL:C285($StartHI_r; $EndHI_r)
$StartHI_r:=0
$EndHI_r:=0
C_TEXT:C284($uniqueKey_txt)
QUERY:C277([Pontis_Metrics:41]; [Pontis_Metrics:41]PM_ImportDate_d:4=$RunDate_d)
$uniqueKey_txt:=$BIN_s+"-"+String:C10([Pontis_Metrics:41]PM_RunKey_l:1; "000000000")
ARRAY REAL:C219($HIs_ar; 0)
ARRAY LONGINT:C221($Years_aL; 0)
QUERY:C277([Pontis_Metric_Data:40]; [Pontis_Metric_Data:40]PM_UNiqueKey_s:1=$uniqueKey_txt)
ARRAY REAL:C219($HIs_ar; Records in selection:C76([Pontis_Metric_Data:40]))
ARRAY LONGINT:C221($Years_aL; Records in selection:C76([Pontis_Metric_Data:40]))
SELECTION TO ARRAY:C260([Pontis_Metric_Data:40]PMD_Hindex_r:3; $HIs_ar; [Pontis_Metric_Data:40]PMD_YKey_l:2; $Years_aL)
C_BOOLEAN:C305($SearchinDOM_b)
$SearchinDOM_b:=False:C215
If (Size of array:C274($HIs_ar)>0)
	
	SORT ARRAY:C229($Years_aL; $HIs_ar)
	$StartHI_r:=$HIs_ar{1}
	$EndHI_r:=$HIs_ar{Size of array:C274($HIs_ar)}
	
	If ($StartHI_r>0)
		
		If ($EndHI_r<$StartHI_r)
			$PctDet:=($StartHI_r-$EndHI_r)/$StartHI_r
		Else 
			//start and end HI are same - probably a smart flag or a fake element that does not deteriorate.
			// use the HI change averages based on avg bridge condition
			$SearchinDOM_b:=True:C214
			
		End if 
		
	Else 
		//if the start HI is zero and the average cond >0 then use the averages stored in the DOM tree
		
		If (($avgCond_r>=0) & ($avgCond_r<=10))
			$SearchinDOM_b:=True:C214
		End if 
		
	End if 
Else 
	//if we did not find any data for the BIN use averages
	$SearchinDOM_b:=True:C214
	
End if 

If ($SearchinDOM_b)
	If (BridgeRankHIChgByAvgCond_txt#"")  // check if DOM tree is on
		If (($avgCond_r>=0) & ($avgCond_r<=10))
			//got some average - use the floor of it
			$avgCond_r:=Int:C8($avgCond_r)
			C_TEXT:C284($domelem_txt; $domHIElem_txt)
			ON ERR CALL:C155("4D_Errors")
			4DError_b:=False:C215
			$domelem_txt:=ut_DOM_FindElmtRef(BridgeRankHIChgByAvgCond_txt; "PM_AvgHIChgbyCond/AvgCond"; ->$avgCond_r)
			If ((Not:C34(4DError_b)) & ($domelem_txt#""))
				$domHIElem_txt:=DOM Find XML element:C864($domelem_txt; "AvgCond/AvgHIChg")
				If (Not:C34(4DError_b))
					DOM GET XML ELEMENT VALUE:C731($domHIElem_txt; $PctDet)
				End if 
				
			End if 
			ON ERR CALL:C155("")
			4DError_b:=False:C215
		End if 
	End if 
	
End if 

$0:=$PctDet

//End PM_GetPctDeteriorationByRunDate