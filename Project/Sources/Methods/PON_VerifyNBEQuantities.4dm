//%attributes = {"invisible":true}
//Method: PON_VerifyNBEQuantities
//Description
// verify quantities for NBE elements.
// check that sum of element child quantities do not exceed parent total q
// and,  sum if child state quantities do not exceed parent state q
// return a text string with a list of parent elements with the errors
// Parameters
// $0 : $ErrMsg_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/25/15, 17:10:01
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 11:14:45)
	Mods_2016_02_bug
	//  `Account for Damage element which must be included in other defects
	// Modified by: Costas Manousakis-(Designer)-(2/24/16 12:21:10)
	Mods_2016_02_bug
	//  `fixed  bug where damage 7000 and child quantities were not initialized correctly for new elements
	// Modified by: Costas Manousakis-(Designer)-(11/4/16 15:42:28)
	Mods_2016_11
	//  `added call to PON_VerifyUniqueKeys to add to the error messages
	// Modified by: Costas Manousakis-(Designer)-(11/9/16 16:04:27)
	Mods_2016_11
	//  `added check for quantities to add up correctly. added retrieval of the Grandparent key for reference
	// Modified by: Costas Manousakis-(Designer)-(11/10/16 16:04:27)
	Mods_2016_11
	//  `slight  mods in the error report log
	// Modified by: Costas Manousakis-(Designer)-(3/2/21 20:37:22)
	Mods_2021_03
	//  `added check on enforcing protective systems belonging to proper elements
End if 
//
C_TEXT:C284($0)

C_TEXT:C284($ErrMsg_txt)

ARRAY LONGINT:C221($NBEIds_sorted_aL; 0)
SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEMID:22; $NBEIds_sorted_aL)

C_LONGINT:C283(v_27_002_l)  //InspID
ARRAY LONGINT:C221(v_179_003_aL; 0)  //ELEM_KEY
ARRAY LONGINT:C221(v_179_004_aL; 0)  //ELEM_PARENT_KEY
ARRAY LONGINT:C221(v_179_005_aL; 0)  //ENVKEY
ARRAY LONGINT:C221(v_179_006_aL; 0)  //STRUNITKEY
ARRAY LONGINT:C221(v_179_022_aL; 0)  //ELEMID
ARRAY LONGINT:C221(v_179_027_aL; 0)  //ELEM_PARENTID
ARRAY LONGINT:C221(v_179_004_aL; 0)  //ELEM_PARENT_KEY
ARRAY LONGINT:C221(v_179_019_aL; 0)  //ELEM_GRANDPARENT_KEY
ARRAY REAL:C219(v_179_007_ar; 0)  //ELEM_QUANTITY
ARRAY REAL:C219(v_179_013_ar; 0)  //ELEM_QTYSTATE1
ARRAY REAL:C219(v_179_014_ar; 0)  //ELEM_QTYSTATE2
ARRAY REAL:C219(v_179_015_ar; 0)  //ELEM_QTYSTATE3
ARRAY REAL:C219(v_179_016_ar; 0)  //ELEM_QTYSTATE4
ARRAY TEXT:C222(v_178_004_atxt; 0)  //ELEM_SMART_FLAG
v_27_002_l:=[Inspections:27]InspID:2
$ErrMsg_txt:=""

Begin SQL
	select 
	[PON_ELEM_INSP].ELEMID, 
	[PON_ELEM_INSP].ELEM_KEY, 
	[PON_ELEM_INSP].STRUNITKEY, 
	[PON_ELEM_INSP].ENVKEY, 
	[PON_ELEM_INSP].ELEM_PARENTID, 
	[PON_ELEM_INSP].ELEM_QUANTITY,  
	[PON_ELEM_INSP].ELEM_QTYSTATE1, 
	[PON_ELEM_INSP].ELEM_QTYSTATE2, 
	[PON_ELEM_INSP].ELEM_QTYSTATE3,
	[PON_ELEM_INSP].ELEM_QTYSTATE4, 
	[PON_ELEM_DEFS].ELEM_SMART_FLAG, 
	[PON_ELEM_INSP].ELEM_PARENT_KEY,
	[PON_ELEM_INSP].[ELEM_GRANDPARENT_KEY]
	
	from [PON_ELEM_INSP], [PON_ELEM_DEFS]
	where 
	[PON_ELEM_INSP].inspID = :v_27_002_l
	and
	[PON_ELEM_DEFS].ELEM_KEY = [PON_ELEM_INSP].ELEM_KEY
	order by [PON_ELEM_INSP].ELEM_PARENTID  
	
	into 
	:v_179_022_aL, 
	:v_179_003_aL, 
	:v_179_006_aL, 
	:v_179_005_aL, 
	:v_179_027_aL, 
	:v_179_007_ar, 
	:v_179_013_ar, 
	:v_179_014_ar, 
	:v_179_015_ar, 
	:v_179_016_ar, 
	:v_178_004_atxt, 
	:v_179_004_aL,
	:v_179_019_aL ;
	
End SQL
ARRAY LONGINT:C221($NBE_DisplayOrder_aL; Size of array:C274(v_179_022_aL))
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($NBE_DisplayOrder_aL))
	$NBE_DisplayOrder_aL{$loop_L}:=Find in array:C230($NBEIds_sorted_aL; v_179_022_aL{$loop_L})
	If ($NBE_DisplayOrder_aL{$loop_L}<=0)
		$NBE_DisplayOrder_aL{$loop_L}:=99999
	End if 
End for 
SORT ARRAY:C229($NBE_DisplayOrder_aL; v_179_022_aL; v_179_003_aL; v_179_006_aL; v_179_005_aL; v_179_027_aL; v_179_007_ar; v_179_013_ar; v_179_014_ar; v_179_015_ar; v_179_016_ar; v_178_004_atxt; v_179_004_aL; v_179_019_aL; >)
C_LONGINT:C283($CurrParID_L; $ParIDIndx_L)
C_REAL:C285($ParQ_r; $ChildQ_r; $DamQ_r)
ARRAY REAL:C219($ChildQS_ar; 0)
ARRAY REAL:C219($ParQS_ar; 0)
ARRAY REAL:C219($ChildQS_ar; 4)
ARRAY REAL:C219($ParQS_ar; 4)
ARRAY REAL:C219($DamQ_ar; 4)

$CurrParID_L:=0
$ParQ_r:=0
$ChildQ_r:=0
$DamQ_r:=0

C_LONGINT:C283($loop_L; $st_L)
C_TEXT:C284($IndividualErr_txt; $format_txt)
$format_txt:="###,###,###,##0.0000"
For ($loop_L; 1; Size of array:C274(v_179_027_aL))  //parentid
	//verify individual Quantity errors
	
	If (v_179_007_ar{$loop_L}<0.0001)
		
		$ErrMsg_txt:=$ErrMsg_txt+"ERROR !!! Zero Total Quantity for Element !!"+<>sCR
		$ErrMsg_txt:=$ErrMsg_txt+"  Elem. Key = "+String:C10(v_179_003_aL{$loop_L})+<>sCR
		If (v_179_004_aL{$loop_L}>0)
			$ErrMsg_txt:=$ErrMsg_txt+"  Parent Key = "+String:C10(v_179_004_aL{$loop_L})+<>sCR
		End if 
		If (v_179_019_aL{$loop_L}>0)
			$ErrMsg_txt:=$ErrMsg_txt+"  GrandParent Key = "+String:C10(v_179_019_aL{$loop_L})+<>sCR
		End if 
		$ErrMsg_txt:=$ErrMsg_txt+"  Env. = "+String:C10(v_179_005_aL{$loop_L})+<>sCR
		$ErrMsg_txt:=$ErrMsg_txt+"  Struct. Unit = "+String:C10(v_179_006_aL{$loop_L})+<>sCR
		$ErrMsg_txt:=$ErrMsg_txt+<>sCR
		
	End if 
	
	If (v_179_007_ar{$loop_L}#(v_179_013_ar{$loop_L}+v_179_014_ar{$loop_L}+v_179_015_ar{$loop_L}+v_179_016_ar{$loop_L}))
		$ErrMsg_txt:=$ErrMsg_txt+"ERROR !!! Quantities in States 1-4 do not match Element Quantity !!"+<>sCR
		$ErrMsg_txt:=$ErrMsg_txt+"  Elem. Key = "+String:C10(v_179_003_aL{$loop_L})+<>sCR
		If (v_179_004_aL{$loop_L}>0)
			$ErrMsg_txt:=$ErrMsg_txt+"  Parent Key = "+String:C10(v_179_004_aL{$loop_L})+<>sCR
		End if 
		If (v_179_019_aL{$loop_L}>0)
			$ErrMsg_txt:=$ErrMsg_txt+"  GrandParent Key = "+String:C10(v_179_019_aL{$loop_L})+<>sCR
		End if 
		$ErrMsg_txt:=$ErrMsg_txt+"  Env. = "+String:C10(v_179_005_aL{$loop_L})+<>sCR
		$ErrMsg_txt:=$ErrMsg_txt+"  Struct. Unit = "+String:C10(v_179_006_aL{$loop_L})+<>sCR
		$ErrMsg_txt:=$ErrMsg_txt+"  Total Q "+String:C10(v_179_007_ar{$loop_L}; $format_txt)+" # "+String:C10(v_179_013_ar{$loop_L}; $format_txt)+" + "+String:C10(v_179_014_ar{$loop_L}; $format_txt)+" + "+String:C10(v_179_015_ar{$loop_L}; $format_txt)+" + "+String:C10(v_179_016_ar{$loop_L}; $format_txt)+<>sCR
		$ErrMsg_txt:=$ErrMsg_txt+<>sCR
		
	End if 
	If ((v_179_027_aL{$loop_L}>0) & (v_178_004_atxt{$loop_L}="Y"))
		//quantities are checked  only for defects
		
		If (v_179_027_aL{$loop_L}#$CurrParID_L)
			// found a new parent 
			// first check the previous parent
			$IndividualErr_txt:=""
			//check  total Qs
			If ($ParQ_r<$ChildQ_r)
				$IndividualErr_txt:=$IndividualErr_txt+"  Sum of Defect Total Quantities = "+String:C10($ChildQ_r)+" EXCEED Element Total Quantity = "+String:C10($ParQ_r)+<>sCR
			End if 
			//Check state Q
			For ($st_L; 1; 4)
				If ($ParQS_ar{$st_L}<$ChildQS_ar{$st_L})
					$IndividualErr_txt:=$IndividualErr_txt+"  Sum of Defect Quantities in State "+String:C10($st_L)+" = "+String:C10($ChildQS_ar{$st_L})+" EXCEED Element Quantity in State "+String:C10($st_L)+" = "+String:C10($ParQS_ar{$st_L})+<>sCR
				End if 
			End for 
			//check Damage Qs  - they must be less than or equal of each of the other defect Qs - both total Q and each state
			If ($ChildQ_r<$DamQ_r)
				$IndividualErr_txt:=$IndividualErr_txt+"  Sum of Defect Total Quantities "+String:C10($st_L)+" = "+String:C10($ChildQ_r)+" ARE LESS than Total Damage (7000) Quantity "+" = "+String:C10($DamQ_r)+<>sCR
			End if 
			For ($st_L; 1; 4)
				If ($ChildQS_ar{$st_L}<$DamQ_ar{$st_L})
					$IndividualErr_txt:=$IndividualErr_txt+"  Sum of Defect Quantities in State "+String:C10($st_L)+" = "+String:C10($ChildQS_ar{$st_L})+" ARE LESS than Damage (7000) Quantity in State "+String:C10($st_L)+" = "+String:C10($DamQ_ar{$st_L})+<>sCR
				End if 
			End for 
			
			If ($IndividualErr_txt#"")
				//found errors
				$ErrMsg_txt:=$ErrMsg_txt+"ERROR !!! Quantity Discrepancies between Element and Defect(s) !! "+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+"  Elem. Key = "+String:C10(v_179_003_aL{$ParIDIndx_L})+<>sCR
				If (v_179_004_aL{$ParIDIndx_L}>0)
					$ErrMsg_txt:=$ErrMsg_txt+"  Parent Key = "+String:C10(v_179_004_aL{$ParIDIndx_L})+<>sCR
				End if 
				$ErrMsg_txt:=$ErrMsg_txt+"  Env. = "+String:C10(v_179_005_aL{$ParIDIndx_L})+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+"  Struct. Unit = "+String:C10(v_179_006_aL{$ParIDIndx_L})+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+$IndividualErr_txt
				$ErrMsg_txt:=$ErrMsg_txt+<>sCR
			End if 
			//then initialize the new stuff
			//  `find  new parent
			$ParIDIndx_L:=Find in array:C230(v_179_022_aL; v_179_027_aL{$loop_L})
			
			If ($ParIDIndx_L>0)
				$CurrParID_L:=v_179_022_aL{$ParIDIndx_L}
				$ParQ_r:=v_179_007_ar{$ParIDIndx_L}
				$ParQS_ar{1}:=v_179_013_ar{$ParIDIndx_L}
				$ParQS_ar{2}:=v_179_014_ar{$ParIDIndx_L}
				$ParQS_ar{3}:=v_179_015_ar{$ParIDIndx_L}
				$ParQS_ar{4}:=v_179_016_ar{$ParIDIndx_L}
				$ChildQ_r:=0
				$DamQ_r:=0
				ARRAY REAL:C219($ChildQS_ar; 0)
				ARRAY REAL:C219($DamQ_ar; 0)
				ARRAY REAL:C219($ChildQS_ar; 4)
				ARRAY REAL:C219($DamQ_ar; 4)
				
				If (v_179_003_aL{$loop_L}=7000)
					$DamQ_r:=v_179_007_ar{$loop_L}
					$DamQ_ar{1}:=v_179_013_ar{$loop_L}
					$DamQ_ar{2}:=v_179_014_ar{$loop_L}
					$DamQ_ar{3}:=v_179_015_ar{$loop_L}
					$DamQ_ar{4}:=v_179_016_ar{$loop_L}
				Else 
					$ChildQ_r:=v_179_007_ar{$loop_L}
					$ChildQS_ar{1}:=v_179_013_ar{$loop_L}
					$ChildQS_ar{2}:=v_179_014_ar{$loop_L}
					$ChildQS_ar{3}:=v_179_015_ar{$loop_L}
					$ChildQS_ar{4}:=v_179_016_ar{$loop_L}
				End if 
				
			Else 
				//!!!Parent not found!!! - Orphan Defect!!!
				$ErrMsg_txt:=$ErrMsg_txt+"ERROR !!! Orphan Defect !! "+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+"  Elem. Key = "+String:C10(v_179_003_aL{$loop_L})+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+"  Env = "+String:C10(v_179_005_aL{$loop_L})+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+"  Struct Unit = "+String:C10(v_179_006_aL{$loop_L})+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+"  Parent Key = "+String:C10(v_179_004_aL{$loop_L})+<>sCR
				$ErrMsg_txt:=$ErrMsg_txt+<>sCR
			End if 
			
		Else 
			//same parent - add to previous sums
			//must exclude 7000 damage 
			If (v_179_003_aL{$loop_L}=7000)
				$DamQ_r:=v_179_007_ar{$loop_L}
				$DamQ_ar{1}:=v_179_013_ar{$loop_L}
				$DamQ_ar{2}:=v_179_014_ar{$loop_L}
				$DamQ_ar{3}:=v_179_015_ar{$loop_L}
				$DamQ_ar{4}:=v_179_016_ar{$loop_L}
			Else 
				$ChildQ_r:=$ChildQ_r+v_179_007_ar{$loop_L}
				$ChildQS_ar{1}:=$ChildQS_ar{1}+v_179_013_ar{$loop_L}
				$ChildQS_ar{2}:=$ChildQS_ar{2}+v_179_014_ar{$loop_L}
				$ChildQS_ar{3}:=$ChildQS_ar{3}+v_179_015_ar{$loop_L}
				$ChildQS_ar{4}:=$ChildQS_ar{4}+v_179_016_ar{$loop_L}
			End if 
		End if 
		
	End if 
End for 

$IndividualErr_txt:=""
If ($ParQ_r<$ChildQ_r)
	$IndividualErr_txt:=$IndividualErr_txt+"  Sum of Defect Total Quantities = "+String:C10($ChildQ_r)+" EXCEED Element Total Quantity = "+String:C10($ParQ_r)+<>sCR
End if 

For ($st_L; 1; 4)
	If ($ParQS_ar{$st_L}<$ChildQS_ar{$st_L})
		$IndividualErr_txt:=$IndividualErr_txt+"  Sum of Defect Quantities in State "+String:C10($st_L)+" = "+String:C10($ChildQS_ar{$st_L})+" EXCEED Element Quantity in State "+String:C10($st_L)+" = "+String:C10($ParQS_ar{$st_L})+<>sCR
	End if 
End for 
If ($IndividualErr_txt#"")
	//found errors
	$ErrMsg_txt:=$ErrMsg_txt+"ERROR !!! Quantity Discrepancies between Element and Defect(s) !! "+<>sCR
	$ErrMsg_txt:=$ErrMsg_txt+"  Elem. Key = "+String:C10(v_179_003_aL{$ParIDIndx_L})+<>sCR
	If (v_179_004_aL{$ParIDIndx_L}>0)
		$ErrMsg_txt:=$ErrMsg_txt+"  Parent Key = "+String:C10(v_179_004_aL{$ParIDIndx_L})+<>sCR
	End if 
	$ErrMsg_txt:=$ErrMsg_txt+"  Env. = "+String:C10(v_179_005_aL{$ParIDIndx_L})+<>sCR
	$ErrMsg_txt:=$ErrMsg_txt+"  Struct. Unit = "+String:C10(v_179_006_aL{$ParIDIndx_L})+<>sCR
	$ErrMsg_txt:=$ErrMsg_txt+$IndividualErr_txt
	$ErrMsg_txt:=$ErrMsg_txt+<>sCR
End if 

//check for duplicates also!
$ErrMsg_txt:=$ErrMsg_txt+PON_VerifyUniqueKeys

C_TEXT:C284($EnforceProtSystemTree)
$EnforceProtSystemTree:=ut_GetSysParameter("NBE_EnforceProtSys")
If ($EnforceProtSystemTree="YES")
	$ErrMsg_txt:=$ErrMsg_txt+PON_VerifyProtSys
End if 

$0:=$ErrMsg_txt
//End PON_VerifyNBEQuantities