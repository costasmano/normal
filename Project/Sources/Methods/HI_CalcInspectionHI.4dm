//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/01/10, 12:33:50
	// ----------------------------------------------------
	// Method: HI_CalcInspectionHI
	// Description
	// Calculate the HI for a given inpsection
	// 
	// Parameters
	// $0 : $HI_r
	// $1 : $BMSInspRecID_L
	// $2 : $TotBrgVal_ptr : pointer to var for total bridge value
	// $3 : $CurBrgVal_ptr : pointer to var for curent bridge value
	// ----------------------------------------------------
	
	Mods_2010_02
End if 
C_REAL:C285($0; $HI_r)
C_LONGINT:C283($1; $BMSInspRecID_L)
C_POINTER:C301($2; $3; $TotBrgVal_ptr; $CurBrgVal_ptr)
$BMSInspRecID_L:=$1
$TotBrgVal_ptr:=$2
$CurBrgVal_ptr:=$3
C_REAL:C285($TotBrgVal_r; $CurBrgVal_r; $CUUnitVal_r; $ElmtTotalV_r; $ElmtCurVHI_r)
C_LONGINT:C283($K; $i; $NumElmts; $CUStates_L)
C_TEXT:C284($ElName)
$TotBrgVal_r:=0
$CurBrgVal_r:=0

If ($BMSInspRecID_L>0)
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=$BMSInspRecID_L)
	$NumElmts:=Records in selection:C76([Cond Units:45])
	ARRAY REAL:C219($ar_Q_R; 0)
	ARRAY REAL:C219($ar_Cs1_R; 0)
	ARRAY REAL:C219($ar_Cs2_R; 0)
	ARRAY REAL:C219($ar_Cs3_R; 0)
	ARRAY REAL:C219($ar_Cs4_R; 0)
	ARRAY REAL:C219($ar_Cs5_R; 0)
	ARRAY INTEGER:C220($ar_NCS_i; 0)
	ARRAY TEXT:C222($ar_CUName; 0)  //Command Replaced was o_ARRAY string length was 80
	ARRAY INTEGER:C220($ar_ElmID_L; 0)
	ARRAY INTEGER:C220($ar_Env_i; 0)
	SELECTION TO ARRAY:C260([Cond Units:45]Element ID:3; $ar_ElmID_L; [Cond Units:45]Environment:4; $ar_Env_i; [Cond Units:45]Total Quantity:5; $ar_Q_R; [Cond Units:45]CondState1:10; $ar_Cs1_R)
	SELECTION TO ARRAY:C260([Cond Units:45]CondState2:11; $ar_Cs2_R; [Cond Units:45]CondState3:12; $ar_Cs3_R; [Cond Units:45]CondState4:13; $ar_Cs4_R; [Cond Units:45]CondState5:14; $ar_Cs5_R)
	
	If (Type:C295(ar_BMSELID_L)=Integer array:K8:18)
		If (Size of array:C274(ar_BMSELID_L)>0)
		Else 
			HI_InitBMSElmtArrays
		End if 
	Else 
		HI_InitBMSElmtArrays
	End if 
	
	For ($i; 1; $NumElmts)
		$K:=Find in array:C230(ar_BMSELID_L; $ar_ElmID_L{$i})
		If ($K>0)
			$ElName:=ar_BMSELNAME_S{$K}
			$CUStates_L:=ar_BMSELNoCS_L{$K}
		Else 
			$ElName:="Smart Flag"  //In case of error skip element
			$CUStates_L:=5
		End if 
		
		If ($ElName#"Smart Flag")
			
			$CUUnitVal_r:=HI_CalcElemUnitCost($ar_ElmID_L{$i}; $ar_Env_i{$i})
			$ElmtCurVHI_r:=HI_CalcElmtHI($ar_Q_R{$i}; $ar_Cs1_R{$i}; $ar_Cs2_R{$i}; $ar_Cs3_R{$i}; $ar_Cs4_R{$i}; $ar_Cs5_R{$i}; $CUStates_L)
			$ElmtTotalV_r:=Round:C94(($ar_Q_R{$i}*$CUUnitVal_r); 0)
			$TotBrgVal_r:=$TotBrgVal_r+$ElmtTotalV_r
			$CurBrgVal_r:=$CurBrgVal_r+Round:C94(($ElmtCurVHI_r*$ElmtTotalV_r); 0)
			
		End if 
	End for 
	
End if 

$HI_r:=HI_CalcHI_Function($CurBrgVal_r; $TotBrgVal_r)
$TotBrgVal_ptr->:=$TotBrgVal_r
$CurBrgVal_ptr->:=$CurBrgVal_r
$0:=$HI_r