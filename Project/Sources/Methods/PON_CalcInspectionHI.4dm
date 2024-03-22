//%attributes = {"invisible":true}
//Method: PON_CalcInspectionHI
//Description
// Calculate the HI for a given inpsection
// 
// Parameters
// $0 : $HI_r
// $1 : $InspRecID_L
// $2 : $TotBrgVal_ptr : pointer to var for total bridge value
// $3 : $CurBrgVal_ptr : pointer to var for curent bridge value
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/08/15, 17:16:09
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
	
	C_REAL:C285(PON_CalcInspectionHI; $0)
	C_LONGINT:C283(PON_CalcInspectionHI; $1)
	C_POINTER:C301(PON_CalcInspectionHI; $2; $3)
	
End if 
//
C_REAL:C285($0)
C_LONGINT:C283($1)
C_POINTER:C301($2; $3)

C_REAL:C285($HI_r)
C_POINTER:C301($TotBrgVal_ptr; $CurBrgVal_ptr)

C_LONGINT:C283(v_179_021_l)  //INSPID
v_179_021_l:=$1

$TotBrgVal_ptr:=$2
$CurBrgVal_ptr:=$3

C_REAL:C285($TotBrgVal_r; $CurBrgVal_r; $ElmtTotalV_r; $ElmtCurVHI_r)
C_LONGINT:C283($i; $NumElmts)

$TotBrgVal_r:=0
$CurBrgVal_r:=0

ARRAY LONGINT:C221(v_179_005_aL; 0)  //ENVKEY
ARRAY LONGINT:C221(v_179_003_aL; 0)  //ELEM_KEY
ARRAY REAL:C219(v_179_007_ar; 0)  //ELEM_QUANTITY
ARRAY REAL:C219(v_179_013_ar; 0)  //ELEM_QTYSTATE1
ARRAY REAL:C219(v_179_014_ar; 0)  //ELEM_QTYSTATE2
ARRAY REAL:C219(v_179_015_ar; 0)  //ELEM_QTYSTATE3
ARRAY REAL:C219(v_179_016_ar; 0)  //ELEM_QTYSTATE4
ARRAY TEXT:C222(v_178_004_atxt; 0)  //ELEM_SMART_FLAG
ARRAY REAL:C219(v_180_004_ar; 0)  //ELEM_COST

Begin SQL
	select [PON_ELEM_INSP].ELEM_KEY, [PON_ELEM_INSP].ENVKEY, [PON_ELEM_INSP].ELEM_QUANTITY, [PON_ELEM_INSP].ELEM_QTYSTATE1, 
	[PON_ELEM_INSP].ELEM_QTYSTATE2, [PON_ELEM_INSP].ELEM_QTYSTATE3, [PON_ELEM_INSP].ELEM_QTYSTATE4,
	[PON_ELEM_DEFS].ELEM_SMART_FLAG, [PON_ELEM_COSTS].ELEM_COST
	from 
	[PON_ELEM_INSP], [PON_ELEM_DEFS], [PON_ELEM_COSTS]
	where
	[PON_ELEM_INSP].inspid = :v_179_021_l
	and
	[PON_ELEM_DEFS].ELEM_KEY = [PON_ELEM_INSP].ELEM_KEY
	and 
	[PON_ELEM_COSTS].ELEM_KEY = [PON_ELEM_INSP].ELEM_KEY
	and 
	[PON_ELEM_COSTS].ENVKEY = [PON_ELEM_INSP].ENVKEY
	into :v_179_003_aL, :v_179_005_aL, :v_179_007_ar, :v_179_013_ar, :v_179_014_ar, :v_179_015_ar, :v_179_016_ar, :v_178_004_atxt , :v_180_004_ar ;
End SQL
$NumElmts:=Size of array:C274(v_179_003_aL)
For ($i; 1; $NumElmts)
	
	If (v_178_004_atxt{$i}#"Y")
		
		$ElmtCurVHI_r:=HI_CalcElmtHI(v_179_007_ar{$i}; v_179_013_ar{$i}; v_179_014_ar{$i}; v_179_015_ar{$i}; v_179_016_ar{$i}; 0; 4)
		$ElmtTotalV_r:=Round:C94((v_179_007_ar{$i}*v_180_004_ar{$i}); 0)
		$TotBrgVal_r:=$TotBrgVal_r+$ElmtTotalV_r
		$CurBrgVal_r:=$CurBrgVal_r+Round:C94(($ElmtCurVHI_r*$ElmtTotalV_r); 0)
		
	End if 
End for 

ARRAY LONGINT:C221(v_179_005_aL; 0)  //ENVKEY
ARRAY LONGINT:C221(v_179_003_aL; 0)  //ELEM_KEY
ARRAY REAL:C219(v_179_007_ar; 0)  //ELEM_QUANTITY
ARRAY REAL:C219(v_179_013_ar; 0)  //ELEM_QTYSTATE1
ARRAY REAL:C219(v_179_014_ar; 0)  //ELEM_QTYSTATE2
ARRAY REAL:C219(v_179_015_ar; 0)  //ELEM_QTYSTATE3
ARRAY REAL:C219(v_179_016_ar; 0)  //ELEM_QTYSTATE4
ARRAY TEXT:C222(v_178_004_atxt; 0)  //ELEM_SMART_FLAG
ARRAY REAL:C219(v_180_004_ar; 0)  //ELEM_COST

$HI_r:=HI_CalcHI_Function($CurBrgVal_r; $TotBrgVal_r)
$TotBrgVal_ptr->:=$TotBrgVal_r
$CurBrgVal_ptr->:=$CurBrgVal_r

$0:=$HI_r
//End PON_CalcInspectionHI