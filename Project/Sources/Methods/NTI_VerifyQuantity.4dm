//%attributes = {"invisible":true}
//Method: NTI_VerifyQuantity
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 11:10:01
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_TEXT:C284(NTI_VerifyQuantity; $0)
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($ErrMsg_txt)
$ErrMsg_txt:=""
C_LONGINT:C283(PON_QCheck_ParentID_L)
ARRAY REAL:C219(PON_QCheck_ChildQ_ar; 0)
ARRAY LONGINT:C221(PON_QCheck_IDs_aL; 0)
ARRAY TEXT:C222(PON_QCheck_smflag_atxt; 0)

QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8=0)
	
	PON_QCheck_ParentID_L:=[NTI_ELEM_BIN_INSP:183]ELEMID:2
	Begin SQL
		select [nti_elem_bin_insp].ELEM_QUANTITY, [NTI_ELEM_DEFS].[DEFECTFLAG] from
		[nti_elem_bin_insp], [NTI_ELEM_DEFS]
		where 
		[NTI_ELEM_DEFS].ELEM_KEY = [nti_elem_bin_insp].Elem_key
		and
		[nti_elem_bin_insp].ELEM_PARENT_ID = :PON_QCheck_ParentID_L
		/* and
		[nti_elem_bin_insp].Elem_key <> 7000+Needtocheckthis_itExcludesTheDamageElement */
		into 
		:PON_QCheck_ChildQ_ar , :PON_QCheck_smflag_atxt ;
	End SQL
	C_LONGINT:C283($loop_L)
	C_REAL:C285($totChildQ_r)
	$totChildQ_r:=0
	For ($loop_L; 1; Size of array:C274(PON_QCheck_ChildQ_ar))
		If (PON_QCheck_smflag_atxt{$loop_L}="Y")
			$totChildQ_r:=$totChildQ_r+PON_QCheck_ChildQ_ar{$loop_L}
		End if 
	End for 
	If ([NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21<$totChildQ_r)
		//ERROR
		$ErrMsg_txt:="The Sum of Quantities of Defects associated with this Element exceed the total Quantity of the Element!"
	End if 
Else 
	//child find siblings and parent
	PON_QCheck_ParentID_L:=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8
	C_REAL:C285($ParentQ_r; $totChildQ_r)
	Begin SQL
		select [nti_elem_bin_insp].ELEM_QUANTITY 
		from
		[nti_elem_bin_insp]
		where 
		[nti_elem_bin_insp].ELEMID= :PON_QCheck_ParentID_L
		into 
		:PON_QCheck_ChildQ_ar  ;
	End SQL
	$ParentQ_r:=PON_QCheck_ChildQ_ar{1}
	
	Begin SQL
		select [nti_elem_bin_insp].ELEM_QUANTITY, [nti_elem_bin_insp].ELEMID, [NTI_ELEM_DEFS].[DEFECTFLAG] from
		[nti_elem_bin_insp], [NTI_ELEM_DEFS]
		where 
		[NTI_ELEM_DEFS].ELEM_KEY = [nti_elem_bin_insp].Elem_key
		and
		[nti_elem_bin_insp].ELEM_PARENT_ID= :PON_QCheck_ParentID_L
		/* and
		[nti_elem_bin_insp].Elem_key <> 7000+Needtocheckthis_itExcludesTheDamageElement */
		into 
		:PON_QCheck_ChildQ_ar , :PON_QCheck_IDs_aL, :PON_QCheck_smflag_atxt ;
	End SQL
	$totChildQ_r:=0
	For ($loop_L; 1; Size of array:C274(PON_QCheck_ChildQ_ar))
		If (PON_QCheck_IDs_aL{$loop_L}#[NTI_ELEM_BIN_INSP:183]ELEMID:2)
			If (PON_QCheck_smflag_atxt{$loop_L}="Y")
				$totChildQ_r:=$totChildQ_r+PON_QCheck_ChildQ_ar{$loop_L}
			End if 
		End if 
	End for 
	$totChildQ_r:=$totChildQ_r+[NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21
	
	If ($totChildQ_r>$ParentQ_r)
		$ErrMsg_txt:="The Sum of Quantities of Defects associated with the Parent of this Element exceed the total Quantity ("+String:C10($ParentQ_r; "###,###,###,###,###,###.00")+") of the Parent Element!"
	End if 
End if 

$0:=$ErrMsg_txt

//End NTI_VerifyQuantity