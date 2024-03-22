//%attributes = {"invisible":true}
//Method: NTI_VerifyNTIQuantities
//Description
// Verify NTE elements for an inspection
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 13:16:39
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_TEXT:C284(NTI_VerifyNTIQuantities; $0)
	C_POINTER:C301(NTI_VerifyNTIQuantities; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(3/23/18 16:00:28)
	Mods_2018_03
	//  `additions for protective systems
End if 
//
C_POINTER:C301($1)

C_TEXT:C284($0)

C_TEXT:C284($ErrMsg_txt)

ARRAY LONGINT:C221($NBEIds_sorted_aL; 0)
C_BOOLEAN:C305($BinInsp_b; $TINInsp_b)
$BinInsp_b:=(Current form table:C627=(->[Inspections:27]))
$TINInsp_b:=(Current form table:C627=(->[TIN_Inspections:184]))

Case of 
	: ($BinInsp_b)
		SELECTION TO ARRAY:C260([NTI_ELEM_BIN_INSP:183]ELEMID:2; $NBEIds_sorted_aL)
		v_27_002_l:=[Inspections:27]InspID:2
	: ($TINInsp_b)
		SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEMID:2; $NBEIds_sorted_aL)
		v_27_002_l:=[TIN_Inspections:184]InspectionID:2
		
End case 

C_LONGINT:C283(v_27_002_l)  //InspID
ARRAY LONGINT:C221(v_179_003_aL; 0)  //ELEM_KEY
ARRAY LONGINT:C221(v_179_004_aL; 0)  //ELEM_PARENT_KEY
ARRAY LONGINT:C221(v_179_022_aL; 0)  //ELEMID
ARRAY LONGINT:C221(v_179_027_aL; 0)  //ELEM_PARENTID
ARRAY REAL:C219(v_179_007_ar; 0)  //ELEM_QUANTITY
ARRAY REAL:C219(v_179_013_ar; 0)  //ELEM_QTYSTATE1
ARRAY REAL:C219(v_179_014_ar; 0)  //ELEM_QTYSTATE2
ARRAY REAL:C219(v_179_015_ar; 0)  //ELEM_QTYSTATE3
ARRAY REAL:C219(v_179_016_ar; 0)  //ELEM_QTYSTATE4
ARRAY TEXT:C222(v_178_004_atxt; 0)  //ELEM_SMART_FLAG
ARRAY LONGINT:C221(v_179_019_aL; 0)  //ELEM_GRANDPARENT_KEY
ARRAY LONGINT:C221(v_179_028_aL; 0)  //ELEM_GRANDPARENTID
ARRAY TEXT:C222(v_178_003_atxt; 0)  //ELEM_PROTECT_SYS

$ErrMsg_txt:=""

Case of 
	: ($BINInsp_b)
		Begin SQL
			select 
			[nti_elem_bin_insp].ELEMID, 
			[nti_elem_bin_insp].ELEM_KEY, 
			[nti_elem_bin_insp].ELEM_PARENT_ID, 
			[nti_elem_bin_insp].ELEM_QUANTITY,  
			[nti_elem_bin_insp].ELEM_QTYSTATE1, 
			[nti_elem_bin_insp].ELEM_QTYSTATE2, 
			[nti_elem_bin_insp].ELEM_QTYSTATE3,
			[nti_elem_bin_insp].ELEM_QTYSTATE4, 
			[NTI_ELEM_DEFS].[DEFECTFLAG], 
			[nti_elem_bin_insp].ELEM_PARENT_KEY ,
			[nti_elem_bin_insp].ELEM_GRANDPARENT_KEY,
			[nti_elem_bin_insp].ELEM_GRANDPARENT_ID ,
			[NTI_ELEM_DEFS].[ELEM_PROTECT_SYS]
			
			from [nti_elem_bin_insp], [NTI_ELEM_DEFS]
			where 
			[nti_elem_bin_insp].inspID = :v_27_002_l
			and
			[NTI_ELEM_DEFS].ELEM_KEY = [nti_elem_bin_insp].ELEM_KEY
			order by [nti_elem_bin_insp].ELEM_PARENT_ID  
			
			into 
			:v_179_022_aL, 
			:v_179_003_aL, 
			:v_179_027_aL, 
			:v_179_007_ar, 
			:v_179_013_ar, 
			:v_179_014_ar, 
			:v_179_015_ar, 
			:v_179_016_ar, 
			:v_178_004_atxt, 
			:v_179_004_aL ,
			:v_179_019_aL ,
			:v_179_028_aL ,
			:v_178_003_atxt ;
			
		End SQL
		
	: ($TINInsp_b)
		Begin SQL
			select 
			[NTI_ELEM_TIN_INSP].ELEMID, 
			[NTI_ELEM_TIN_INSP].ELEM_KEY, 
			[NTI_ELEM_TIN_INSP].ELEM_PARENT_ID, 
			[NTI_ELEM_TIN_INSP].ELEM_QUANTITY,  
			[NTI_ELEM_TIN_INSP].ELEM_QTYSTATE1, 
			[NTI_ELEM_TIN_INSP].ELEM_QTYSTATE2, 
			[NTI_ELEM_TIN_INSP].ELEM_QTYSTATE3,
			[NTI_ELEM_TIN_INSP].ELEM_QTYSTATE4, 
			[NTI_ELEM_TIN_INSP].ELEM_PARENT_KEY,
			[NTI_ELEM_DEFS].[DEFECTFLAG] ,
			[NTI_ELEM_TIN_INSP].ELEM_GRANDPARENT_KEY,
			[NTI_ELEM_TIN_INSP].ELEM_GRANDPARENT_ID ,
			[NTI_ELEM_DEFS].[ELEM_PROTECT_SYS]
			
			from [NTI_ELEM_TIN_INSP], [NTI_ELEM_DEFS]
			where 
			[NTI_ELEM_TIN_INSP].[InspectionID] = :v_27_002_l
			and
			[NTI_ELEM_DEFS].ELEM_KEY = [NTI_ELEM_TIN_INSP].ELEM_KEY
			order by [NTI_ELEM_TIN_INSP].ELEM_PARENT_ID  
			
			into 
			:v_179_022_aL, 
			:v_179_003_aL, 
			:v_179_027_aL, 
			:v_179_007_ar, 
			:v_179_013_ar, 
			:v_179_014_ar, 
			:v_179_015_ar, 
			:v_179_016_ar, 
			:v_179_004_aL,
			:v_178_004_atxt ,
			:v_179_019_aL ,
			:v_179_028_aL ,
			:v_178_003_atxt ;
			
		End SQL
		
End case 


ARRAY LONGINT:C221($NBE_DisplayOrder_aL; Size of array:C274(v_179_022_aL))
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($NBE_DisplayOrder_aL))
	$NBE_DisplayOrder_aL{$loop_L}:=Find in array:C230($NBEIds_sorted_aL; v_179_022_aL{$loop_L})
	If ($NBE_DisplayOrder_aL{$loop_L}<=0)
		$NBE_DisplayOrder_aL{$loop_L}:=99999
	End if 
End for 
SORT ARRAY:C229($NBE_DisplayOrder_aL; v_179_022_aL; v_179_003_aL; v_179_027_aL; \
v_179_007_ar; v_179_013_ar; v_179_014_ar; v_179_015_ar; v_179_016_ar; v_179_004_aL; \
v_178_004_atxt; v_179_019_aL; v_179_028_aL; v_178_003_atxt; >)

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
C_TEXT:C284($IndividualErr_txt)
C_LONGINT:C283($elem_ParKey_L; $elem_parID_L; $elem_GP_key_L; $elem_GP_ID_L; $ElemID_L; $elem_key_L)
C_TEXT:C284($elem_def_txt; $elem_prot_txt)
C_REAL:C285($Elem_Q_r; $elem_QCS1_r; $elem_QCS2_r; $elem_QCS3_r; $elem_QCS4_r)

For ($loop_L; 1; Size of array:C274(v_179_027_aL))  //parentid
	//load info in variables
	$ElemID_L:=v_179_022_aL{$loop_L}
	$elem_key_L:=v_179_003_aL{$loop_L}
	$elem_ParKey_L:=v_179_004_aL{$loop_L}
	$elem_parID_L:=v_179_027_aL{$loop_L}
	$elem_GP_key_L:=v_179_019_aL{$loop_L}
	$elem_GP_ID_L:=v_179_028_aL{$loop_L}
	$elem_def_txt:=v_178_004_atxt{$loop_L}
	$elem_prot_txt:=v_178_003_atxt{$loop_L}
	$Elem_Q_r:=v_179_007_ar{$loop_L}
	$elem_QCS1_r:=v_179_013_ar{$loop_L}
	$elem_QCS2_r:=v_179_014_ar{$loop_L}
	$elem_QCS3_r:=v_179_015_ar{$loop_L}
	$elem_QCS4_r:=v_179_016_ar{$loop_L}
	
	If (($elem_parID_L>0) & ($elem_def_txt="Y"))  //quantities are checked  only for defects
		
		If ($elem_parID_L#$CurrParID_L)
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
					$ErrMsg_txt:=$ErrMsg_txt+"  Parent. Key = "+String:C10(v_179_004_aL{$ParIDIndx_L})+<>sCR
				End if 
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
				$ErrMsg_txt:=$ErrMsg_txt+"  Elem Key = "+String:C10(v_179_003_aL{$loop_L})+<>sCR
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
	Else 
		//for protective systems  - check if the parent exists and is valid
		If (v_178_003_atxt{$loop_L}="Y")
			//parent key is 
			
			
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
		$ErrMsg_txt:=$ErrMsg_txt+"  Parent. Key = "+String:C10(v_179_004_aL{$ParIDIndx_L})+<>sCR
	End if 
	$ErrMsg_txt:=$ErrMsg_txt+$IndividualErr_txt
	$ErrMsg_txt:=$ErrMsg_txt+<>sCR
End if 

//**********
//New methodology
//**********

ARRAY TEXT:C222($ParKeys_atxt; 0)
ARRAY LONGINT:C221($ParIDs_aL; 0)
ARRAY REAL:C219($ParQ_ar; 0)
ARRAY REAL:C219($ParQCS1_ar; 0)
ARRAY REAL:C219($ParQCS2_ar; 0)
ARRAY REAL:C219($ParQCS3_ar; 0)
ARRAY REAL:C219($ParQCS4_ar; 0)
ARRAY REAL:C219($DefQ_ar; 0)
ARRAY REAL:C219($DefQCS1_ar; 0)
ARRAY REAL:C219($DefQCS2_ar; 0)
ARRAY REAL:C219($DefQCS3_ar; 0)
ARRAY REAL:C219($DefQCS4_ar; 0)

$ErrMsg_txt:=""
C_BOOLEAN:C305($AbortChecks_b)
$AbortChecks_b:=False:C215
C_TEXT:C284($ParentKey_txt; $KeyFormat_txt; $ElemParKey_txt; $GPKey_txt; $QFmt_txt)
$KeyFormat_txt:="000000"
$QFmt_txt:="###,###,###,##0.0##"

C_LONGINT:C283($ItemInList_L; $GPInList_L)
//part A - primary element check
For ($loop_L; 1; Size of array:C274(v_179_027_aL))
	//load info in variables
	$ElemID_L:=v_179_022_aL{$loop_L}
	$elem_key_L:=v_179_003_aL{$loop_L}
	$elem_ParKey_L:=v_179_004_aL{$loop_L}
	$elem_parID_L:=v_179_027_aL{$loop_L}
	$elem_GP_key_L:=v_179_019_aL{$loop_L}
	$elem_GP_ID_L:=v_179_028_aL{$loop_L}
	$elem_def_txt:=v_178_004_atxt{$loop_L}
	$elem_prot_txt:=v_178_003_atxt{$loop_L}
	$Elem_Q_r:=v_179_007_ar{$loop_L}
	$elem_QCS1_r:=v_179_013_ar{$loop_L}
	$elem_QCS2_r:=v_179_014_ar{$loop_L}
	$elem_QCS3_r:=v_179_015_ar{$loop_L}
	$elem_QCS4_r:=v_179_016_ar{$loop_L}
	
	If ($elem_ParKey_L=0)
		
		Case of 
			: ($elem_def_txt="Y")
				$AbortChecks_b:=True:C214
				$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Element "+String:C10($elem_key_L)+\
					", total Quantity ="+String:C10($Elem_Q_r; $QFmt_txt)+" is a Defect but not assigned to a Parent Element!"+Char:C90(Carriage return:K15:38)
			: ($elem_prot_txt="Y")
				$AbortChecks_b:=True:C214
				$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Element "+String:C10($elem_key_L)+\
					", total Quantity ="+String:C10($Elem_Q_r; $QFmt_txt)+" is a Protective System but not assigned to a Parent Element!"+Char:C90(Carriage return:K15:38)
			Else 
				$ParentKey_txt:=String:C10($elem_key_L; $KeyFormat_txt)+String:C10(0; $KeyFormat_txt)
				If (Find in array:C230($ParKeys_atxt; $ParentKey_txt)>0)
					$AbortChecks_b:=True:C214
					$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Element "+String:C10($elem_key_L)+\
						", total Quantity ="+String:C10($Elem_Q_r; $QFmt_txt)+" is duplicated!"+Char:C90(Carriage return:K15:38)
				Else 
					APPEND TO ARRAY:C911($ParKeys_atxt; $ParentKey_txt)
					APPEND TO ARRAY:C911($ParIDs_aL; $ElemID_L)
					APPEND TO ARRAY:C911($ParQ_ar; $Elem_Q_r)
					APPEND TO ARRAY:C911($ParQCS1_ar; $elem_QCS1_r)
					APPEND TO ARRAY:C911($ParQCS2_ar; $elem_QCS2_r)
					APPEND TO ARRAY:C911($ParQCS3_ar; $elem_QCS3_r)
					APPEND TO ARRAY:C911($ParQCS4_ar; $elem_QCS4_r)
					APPEND TO ARRAY:C911($DefQ_ar; 0)
					APPEND TO ARRAY:C911($DefQCS1_ar; 0)
					APPEND TO ARRAY:C911($DefQCS2_ar; 0)
					APPEND TO ARRAY:C911($DefQCS3_ar; 0)
					APPEND TO ARRAY:C911($DefQCS4_ar; 0)
					
				End if 
		End case 
		
	End if 
	
End for 

//part B - Protective system check

If (Not:C34($AbortChecks_b))
	
	For ($loop_L; 1; Size of array:C274(v_179_027_aL))
		//load info in variables
		$ElemID_L:=v_179_022_aL{$loop_L}
		$elem_key_L:=v_179_003_aL{$loop_L}
		$elem_ParKey_L:=v_179_004_aL{$loop_L}
		$elem_parID_L:=v_179_027_aL{$loop_L}
		$elem_GP_key_L:=v_179_019_aL{$loop_L}
		$elem_GP_ID_L:=v_179_028_aL{$loop_L}
		$elem_def_txt:=v_178_004_atxt{$loop_L}
		$elem_prot_txt:=v_178_003_atxt{$loop_L}
		$Elem_Q_r:=v_179_007_ar{$loop_L}
		$elem_QCS1_r:=v_179_013_ar{$loop_L}
		$elem_QCS2_r:=v_179_014_ar{$loop_L}
		$elem_QCS3_r:=v_179_015_ar{$loop_L}
		$elem_QCS4_r:=v_179_016_ar{$loop_L}
		If ($elem_prot_txt="Y")
			$ElemParKey_txt:=String:C10($elem_ParKey_L; $KeyFormat_txt)+String:C10(0; $KeyFormat_txt)
			$ItemInList_L:=Find in array:C230($ParKeys_atxt; $ElemParKey_txt)
			If ($ItemInList_L<=0)
				//Parent key not found!!
				$AbortChecks_b:=True:C214
				$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Protective System Element "+String:C10($elem_key_L)+\
					", total Quantity ="+String:C10($Elem_Q_r; $QFmt_txt)+" has a Parent key ="+String:C10($elem_ParKey_L)+" which does not Exist!"+Char:C90(Carriage return:K15:38)
			Else 
				//Check if parent id Match 
				If ($ParIDs_aL{$ItemInList_L}#$elem_parID_L)
					$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Protective System Element "+String:C10($elem_key_L)+\
						", total Quantity ="+String:C10($Elem_Q_r; $QFmt_txt)+" with Parent key ="+String:C10($elem_ParKey_L)+\
						" is not correctly linked to the parent (ID Mismatch)!"+Char:C90(Carriage return:K15:38)
				End if 
				$ElemParKey_txt:=String:C10($elem_ParKey_L; $KeyFormat_txt)+String:C10($elem_key_L; $KeyFormat_txt)
				
				If (Find in array:C230($ParKeys_atxt; $ElemParKey_txt)>0)
					//duplicate!!
					$AbortChecks_b:=True:C214
					$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Protective System Element "+String:C10($elem_key_L)+\
						" and Parent key ="+String:C10($elem_ParKey_L)+" already exists!"+Char:C90(Carriage return:K15:38)
				Else 
					APPEND TO ARRAY:C911($ParKeys_atxt; $ElemParKey_txt)
					APPEND TO ARRAY:C911($ParIDs_aL; $ElemID_L)
					APPEND TO ARRAY:C911($ParQ_ar; $Elem_Q_r)
					APPEND TO ARRAY:C911($ParQCS1_ar; $elem_QCS1_r)
					APPEND TO ARRAY:C911($ParQCS2_ar; $elem_QCS2_r)
					APPEND TO ARRAY:C911($ParQCS3_ar; $elem_QCS3_r)
					APPEND TO ARRAY:C911($ParQCS4_ar; $elem_QCS4_r)
					APPEND TO ARRAY:C911($DefQ_ar; 0)
					APPEND TO ARRAY:C911($DefQCS1_ar; 0)
					APPEND TO ARRAY:C911($DefQCS2_ar; 0)
					APPEND TO ARRAY:C911($DefQCS3_ar; 0)
					APPEND TO ARRAY:C911($DefQCS4_ar; 0)
					
				End if 
				
			End if 
			
		End if 
		
	End for 
	
End if 

//part C - Defects check

If (Not:C34($AbortChecks_b))
	
	For ($loop_L; 1; Size of array:C274(v_179_027_aL))
		//load info in variables
		$ElemID_L:=v_179_022_aL{$loop_L}
		$elem_key_L:=v_179_003_aL{$loop_L}
		$elem_ParKey_L:=v_179_004_aL{$loop_L}
		$elem_parID_L:=v_179_027_aL{$loop_L}
		$elem_GP_key_L:=v_179_019_aL{$loop_L}
		$elem_GP_ID_L:=v_179_028_aL{$loop_L}
		$elem_def_txt:=v_178_004_atxt{$loop_L}
		$elem_prot_txt:=v_178_003_atxt{$loop_L}
		$Elem_Q_r:=v_179_007_ar{$loop_L}
		$elem_QCS1_r:=v_179_013_ar{$loop_L}
		$elem_QCS2_r:=v_179_014_ar{$loop_L}
		$elem_QCS3_r:=v_179_015_ar{$loop_L}
		$elem_QCS4_r:=v_179_016_ar{$loop_L}
		If ($elem_def_txt="Y")
			
			If ($elem_GP_key_L=0)
				//defect to main element
				$ElemParKey_txt:=String:C10($elem_ParKey_L; $KeyFormat_txt)+String:C10(0; $KeyFormat_txt)
			Else 
				//defect to prot system
				$ElemParKey_txt:=String:C10($elem_GP_key_L; $KeyFormat_txt)+String:C10($elem_ParKey_L; $KeyFormat_txt)
			End if 
			$ItemInList_L:=Find in array:C230($ParKeys_atxt; $ElemParKey_txt)
			If ($ItemInList_L<=0)
				If ($elem_GP_key_L=0)
					$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Defect "+String:C10($elem_key_L)+\
						" has Parent key ="+String:C10($elem_ParKey_L)+" which cannot be found!"+Char:C90(Carriage return:K15:38)
				Else 
					$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Defect "+String:C10($elem_key_L)+\
						" has Parent key ="+String:C10($elem_ParKey_L)+" and GrandParent key ="+String:C10($elem_GP_key_L)+" which combination cannot be found!!"+Char:C90(Carriage return:K15:38)
				End if 
			Else 
				//check if IDs match - both parent ID and granparent ID
				If ($elem_parID_L#$ParIDs_aL{$ItemInList_L})
					$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Defect "+String:C10($elem_key_L)+\
						", total Quantity ="+String:C10($Elem_Q_r)+" with Parent key ="+String:C10($elem_ParKey_L)+\
						" is not correctly linked to the parent (ID Mismatch)!"+Char:C90(Carriage return:K15:38)
					
				End if 
				If ($elem_GP_key_L>0)
					//find gp record - must exist since we found the combination key
					$GPKey_txt:=String:C10($elem_GP_key_L; $KeyFormat_txt)+String:C10(0; $KeyFormat_txt)
					$GPInList_L:=Find in array:C230($ParKeys_atxt; $GPKey_txt)
					If ($GPInList_L>0)
						If ($elem_GP_ID_L#$ParIDs_aL{$GPInList_L})
							$ErrMsg_txt:=$ErrMsg_txt+"FATAL ERROR : Defect "+String:C10($elem_key_L)+\
								", total Quantity ="+String:C10($Elem_Q_r; $QFmt_txt)+" with Parent key ="+String:C10($elem_ParKey_L)+\
								" and GrandParent key ="+String:C10($elem_GP_key_L)+\
								" is not correctly linked to the GrandParent (ID Mismatch)!"+Char:C90(Carriage return:K15:38)
						End if 
					End if 
				End if 
			End if 
			//add defect quantitites to the arrays
			$DefQ_ar{$ItemInList_L}:=$DefQ_ar{$ItemInList_L}+$Elem_Q_r
			$DefQCS1_ar{$ItemInList_L}:=$DefQCS1_ar{$ItemInList_L}+$elem_QCS1_r
			$DefQCS2_ar{$ItemInList_L}:=$DefQCS2_ar{$ItemInList_L}+$elem_QCS2_r
			$DefQCS3_ar{$ItemInList_L}:=$DefQCS3_ar{$ItemInList_L}+$elem_QCS3_r
			$DefQCS4_ar{$ItemInList_L}:=$DefQCS4_ar{$ItemInList_L}+$elem_QCS4_r
			
		End if 
		
	End for 
	
	//Now check the quantities in the parent elements
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ParKeys_atxt))
		C_TEXT:C284($ElmtError_txt)
		$ElmtError_txt:=""
		If ($ParQ_ar{$loop_L}<$DefQ_ar{$loop_L})
			$ElmtError_txt:=$ElmtError_txt+"Element Quantity ("+String:C10($ParQ_ar{$loop_L}; $QFmt_txt)+\
				") is less than sum of total defect quantities "+String:C10($ParQ_ar{$loop_L}; $QFmt_txt)+")"+Char:C90(Carriage return:K15:38)
		End if 
		
		If ($ParQCS1_ar{$loop_L}<$DefQCS1_ar{$loop_L})
			$ElmtError_txt:=$ElmtError_txt+"Element Quantity in CS1 ("+String:C10($ParQCS1_ar{$loop_L}; $QFmt_txt)+\
				") is less than sum of defect quantities in CS1 "+String:C10($DefQCS1_ar{$loop_L}; $QFmt_txt)+")"+Char:C90(Carriage return:K15:38)
			
		End if 
		
		If ($ParQCS2_ar{$loop_L}<$DefQCS2_ar{$loop_L})
			$ElmtError_txt:=$ElmtError_txt+"Element Quantity in CS2 ("+String:C10($ParQCS2_ar{$loop_L}; $QFmt_txt)+\
				") is less than sum of defect quantities in CS2 "+String:C10($DefQCS2_ar{$loop_L}; $QFmt_txt)+")"+Char:C90(Carriage return:K15:38)
		End if 
		If ($ParQCS3_ar{$loop_L}<$DefQCS3_ar{$loop_L})
			$ElmtError_txt:=$ElmtError_txt+"Element Quantity in CS3 ("+String:C10($ParQCS3_ar{$loop_L}; $QFmt_txt)+\
				") is less than sum of defect quantities in CS3 "+String:C10($DefQCS3_ar{$loop_L}; $QFmt_txt)+")"+Char:C90(Carriage return:K15:38)
			
		End if 
		If ($ParQCS4_ar{$loop_L}<$DefQCS4_ar{$loop_L})
			$ElmtError_txt:=$ElmtError_txt+"Element Quantity in CS4 ("+String:C10($ParQCS4_ar{$loop_L}; $QFmt_txt)+\
				") is less than sum of defect quantities in CS4 ("+String:C10($DefQCS4_ar{$loop_L}; $QFmt_txt)+")"+Char:C90(Carriage return:K15:38)
			
		End if 
		If ($ElmtError_txt#"")
			C_LONGINT:C283($Elemno_L; $parentNo_L)
			$parentNo_L:=Num:C11(Substring:C12($ParKeys_atxt{$loop_L}; 1; 6))
			$Elemno_L:=Num:C11(Substring:C12($ParKeys_atxt{$loop_L}; 7; 6))
			
			If ($Elemno_L=0)
				//main element
				$ElmtError_txt:="ERROR : For Element "+String:C10($parentNo_L)+" :"+Char:C90(Carriage return:K15:38)+$ElmtError_txt
			Else 
				//protective system
				$ElmtError_txt:="ERROR : For Protective System "+String:C10($Elemno_L)+" for element "+String:C10($parentNo_L)+" :"+Char:C90(Carriage return:K15:38)+$ElmtError_txt
			End if 
			
			$ErrMsg_txt:=$ErrMsg_txt+$ElmtError_txt
			
		End if 
		
	End for 
	
End if 

$0:=$ErrMsg_txt

//End NTI_VerifyNBEQuantities