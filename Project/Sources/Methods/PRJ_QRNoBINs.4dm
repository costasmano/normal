//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/10, 14:18:18
	// ----------------------------------------------------
	// Method: PRJ_QRNoBINs
	// Description
	// Return Number of BINs according to criteria. Crtiteria can be SD, RANGE, NOTSDRANGE
	// 
	// Parameters
	// $0 : $Result_L
	// $1 : $Criteria_txt
	//  ` "SD"
	//  ` "RANGE" : $Range1_r <= AverageCond < $Range2_r
	//  ` "NOTSDRANGE"
	// $2 : $Range1_r
	// $3 : $Range2_r  
	
	// ----------------------------------------------------
	
	Mods_2010_04
End if 
C_LONGINT:C283($0; $Result_L)
$Result_L:=0
If ([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1#0)
	C_BOOLEAN:C305($ROBridgemhdnbis_b)
	$ROBridgemhdnbis_b:=False:C215
	READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
	If (Read only state:C362([Bridge MHD NBIS:1]))
		$ROBridgemhdnbis_b:=True:C214
	Else 
		READ ONLY:C145([Bridge MHD NBIS:1])
	End if 
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	ARRAY TEXT:C222($inclBIns_atxt; 0)
	If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $inclBIns_atxt)
	End if 
	C_TEXT:C284($1; $Criteria_txt)
	$Criteria_txt:=$1
	QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $inclBIns_atxt)
	
	Case of 
		: ($Criteria_txt="SD")  //Count SD BINs only
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=True:C214)
			$Result_L:=Records in selection:C76([Bridge MHD NBIS:1])
			
		: (($Criteria_txt="RANGE") | ($Criteria_txt="NOTSDRANGE"))  //Count BINs with $Range1_r <= AverageCond < $Range2_r
			C_REAL:C285($2; $Range1_r; $3; $Range2_r; $BridgeAvg_r)
			$Range1_r:=$2
			$Range2_r:=$3
			C_LONGINT:C283($Recs_L; $Loop_L; $ValidItems_L)
			If ($Criteria_txt="NOTSDRANGE")  //Count NonSD BINs with $Range1_r <= AverageCond < $Range2_r
				QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=False:C215)
			End if 
			QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)  // only valid for NBI records
			$Recs_L:=Records in selection:C76([Bridge MHD NBIS:1])
			If ($Recs_L>0)
				ARRAY TEXT:C222($i58; $Recs_L)  //Command Replaced was o_ARRAY string length was 2
				ARRAY TEXT:C222($i59; $Recs_L)  //Command Replaced was o_ARRAY string length was 2
				ARRAY TEXT:C222($i60; $Recs_L)  //Command Replaced was o_ARRAY string length was 2
				ARRAY TEXT:C222($i62; $Recs_L)  //Command Replaced was o_ARRAY string length was 2
				SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item58:130; $i58; [Bridge MHD NBIS:1]Item59:131; $i59; [Bridge MHD NBIS:1]Item60:132; $i60; [Bridge MHD NBIS:1]Item62:134; $i62)
				For ($Loop_L; 1; $Recs_L)
					$ValidItems_L:=fn_BridgeConditionAvg(->$BridgeAvg_r; $i58{$Loop_L}; $i59{$Loop_L}; $i60{$Loop_L}; $i62{$Loop_L})
					If ($ValidItems_L>0)
						If (($BridgeAvg_r>=$Range1_r) & ($BridgeAvg_r<$Range2_r))
							$Result_L:=$Result_L+1
						End if 
					End if 
				End for 
			End if 
	End case 
	
	If (Not:C34($ROBridgemhdnbis_b))
		READ WRITE:C146([Bridge MHD NBIS:1])
	End if 
	
	READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
End if 

$0:=$Result_L