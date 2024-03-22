//%attributes = {"invisible":true}
//Method: NTI_ValidateElemInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 11:03:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_BOOLEAN:C305(NTI_ValidateElemInput; $0)
	C_POINTER:C301(NTI_ValidateElemInput; $1)
	// Modified by: Costas Manousakis-(Designer)-(3/21/18 12:30:34)
	Mods_2018_03
	//  `additions for protective systems
End if 
//
C_BOOLEAN:C305($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($elemInpValid_b)
C_POINTER:C301($Tbl_ptr)
$Tbl_ptr:=$1
C_POINTER:C301($Quant_ptr; $qt1_ptr; $qt2_ptr; $qt3_ptr; $qt4_ptr; $Key_ptr; $ParKey_ptr; $ElemID_ptr; $GPKey_ptr)

Case of 
	: ($Tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
		$Quant_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21
		$qt1_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17
		$qt2_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE2:18
		$qt3_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE3:19
		$qt4_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE4:20
		$Key_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3
		$ParKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
		$ElemID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEMID:2
		$GPKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
		
	: ($Tbl_ptr=(->[NTI_ELEM_TIN_INSP:185]))
		$Quant_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21
		$qt1_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17
		$qt2_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18
		$qt3_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19
		$qt4_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
		$Key_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3
		$ParKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
		$ElemID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEMID:2
		$GPKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25
		
End case 
ARRAY POINTER:C280($StateQs_aptr; 0)
APPEND TO ARRAY:C911($StateQs_aptr; $qt1_ptr)
APPEND TO ARRAY:C911($StateQs_aptr; $qt2_ptr)
APPEND TO ARRAY:C911($StateQs_aptr; $qt3_ptr)
APPEND TO ARRAY:C911($StateQs_aptr; $qt4_ptr)

// assume true
$elemInpValid_b:=True:C214
C_TEXT:C284($Message_txt; $temp_txt)
$Message_txt:=""

If ($Key_ptr->>0)
Else 
	$Message_txt:=$Message_txt+"An Element Has not been Selected!"+Char:C90(Carriage return:K15:38)
End if 
//need to add check if there are quantities in states where they're not supposed to be for defects

$temp_txt:=""
QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$Key_ptr->)

If ($ParKey_ptr->>0) & ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")  //if there is a parent and defect
	C_LONGINT:C283($NoQuantityStateFlag_L; $CS_L)
	$NoQuantityStateFlag_L:=NTI_NoQuantityState($Key_ptr->)
	
	For ($CS_L; 1; 4)
		If ($NoQuantityStateFlag_L ?? $CS_L) & (($StateQs_aptr{$CS_L}->)>0)
			// will clear quantity and alert
			$StateQs_aptr{$CS_L}->:=0
			
			If ($temp_txt="")
				$temp_txt:="Cleared Quantity in State "+String:C10($CS_L)
				
			Else 
				$temp_txt:=$temp_txt+Char:C90(Carriage return:K15:38)+"Cleared Quantity in State "+String:C10($CS_L)
			End if 
			
		End if 
	End for 
	
End if 
If ($temp_txt#"")
	$Message_txt:=$Message_txt+Char:C90(Carriage return:K15:38)+"Following Condition States Quantities "+\
		"have been cleared because current element is not allowed to have any Quantity in them."+\
		String:C10(Carriage return:K15:38)+$temp_txt+\
		String:C10(Carriage return:K15:38)+"Please verify all quantities before saving!"
	$elemInpValid_b:=False:C215
	
End if 

If (($Quant_ptr->)<=0)
	$Message_txt:=$Message_txt+Char:C90(13)+"Element Quantity cannot be zero or less!"
	$elemInpValid_b:=False:C215
End if 
If ((($qt1_ptr->)<0) | (($qt2_ptr->)<0) | (($qt3_ptr->)<0) | (($qt4_ptr->)<0))
	// any of the states is neg
	$Message_txt:=$Message_txt+Char:C90(13)+"Quantities in States Cannot be less than zero!!  Please Adjust!"
	$elemInpValid_b:=False:C215
	
End if 
If ((($qt1_ptr->)+($qt2_ptr->)+($qt3_ptr->)+($qt4_ptr->))#($Quant_ptr->))
	// Quantities in States do not match Total
	$Message_txt:=$Message_txt+Char:C90(13)+"Quantities in States do not match Total Quantity!!  Please Adjust!"
	$elemInpValid_b:=False:C215
End if 

If (Not:C34(NTI_VERIFYUNIQELEM_b($Key_ptr->; $ParKey_ptr->; $Tbl_ptr; $GPKey_ptr->)))
	$Message_txt:=$Message_txt+Char:C90(13)+"There exists a duplicate Element with same Number / Parent / GrandParent combination!"
	$elemInpValid_b:=False:C215
End if 
//need to check sum of total quantities in defects must be less than or equal to total q

If ($Tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
	$temp_txt:=NTI_VerifyQuantity
Else 
	$temp_txt:=NTI_VerifyQuantity_TIN
	
End if 

If ($temp_txt#"")
	$Message_txt:=$Message_txt+Char:C90(Carriage return:K15:38)+$temp_txt
	$elemInpValid_b:=False:C215
End if 

//check if associated defects belong to the currentelement
$temp_txt:=""
C_LONGINT:C283($numCurrDefects_L)  //get current list of defects
$numCurrDefects_L:=LISTBOX Get number of rows:C915(PON_NBE_DAM_LB)
If ($numCurrDefects_L>0)
	ARRAY LONGINT:C221($NewAllowedDefects_aL; 0)
	NTI_FindAllowedDefects($Key_ptr->; ->$NewAllowedDefects_aL)
	ARRAY LONGINT:C221($CurrentDefectKeys_aL; 0)
	C_LONGINT:C283($CurrID_L)
	$CurrID_L:=$ElemID_ptr->
	
	
	If ($Tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
		Begin SQL
			select [NTI_ELEM_BIN_INSP].[ELEM_KEY] from [NTI_ELEM_BIN_INSP], [NTI_ELEM_DEFS]
			where [NTI_ELEM_BIN_INSP].[ELEM_PARENT_ID] = :$CurrID_L 
			and [NTI_ELEM_DEFS].[ELEM_KEY] = [NTI_ELEM_BIN_INSP].[ELEM_KEY]
			and [NTI_ELEM_DEFS].[DEFECTFLAG] = 'Y'
			into :$CurrentDefectKeys_aL ;
		End SQL
	Else 
		Begin SQL
			select [NTI_ELEM_TIN_INSP].[ELEM_KEY] from [NTI_ELEM_TIN_INSP], [NTI_ELEM_DEFS]
			where [NTI_ELEM_TIN_INSP].[ELEM_PARENT_ID] = :$CurrID_L 
			and [NTI_ELEM_DEFS].[ELEM_KEY] = [NTI_ELEM_TIN_INSP].[ELEM_KEY]
			and [NTI_ELEM_DEFS].[DEFECTFLAG] = 'Y'
			into :$CurrentDefectKeys_aL ;
		End SQL
	End if 
	
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; Size of array:C274($CurrentDefectKeys_aL); 1; -1)
		If (Find in array:C230($NewAllowedDefects_aL; $CurrentDefectKeys_aL{$loop_L})>0)
			DELETE FROM ARRAY:C228($CurrentDefectKeys_aL; $loop_L)
		End if 
	End for 
	If (Size of array:C274($CurrentDefectKeys_aL)>0)
		
		For ($loop_L; 1; Size of array:C274($CurrentDefectKeys_aL))
			
			If ($temp_txt="")
				$temp_txt:=String:C10($CurrentDefectKeys_aL{$loop_L})
			Else 
				$temp_txt:=$temp_txt+", "+String:C10($CurrentDefectKeys_aL{$loop_L})
			End if 
		End for 
		
	End if 
	
End if 

If ($temp_txt#"")
	$Message_txt:=$Message_txt+Char:C90(Carriage return:K15:38)+\
		"Following Defect(s) are not allowed with the current element : "+\
		$temp_txt+" ! Please correct before saving!"
	$elemInpValid_b:=False:C215
	
End if 

If (Not:C34($elemInpValid_b))
	ALERT:C41($Message_txt)
End if 

$0:=$elemInpValid_b
//End NTI_ValidateElemInput