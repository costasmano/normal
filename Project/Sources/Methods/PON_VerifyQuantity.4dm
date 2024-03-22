//%attributes = {"invisible":true}
//Method: PON_VerifyQuantity
//Description
// Make sure quantities of element and chidren are ok
// Parameters
// $0 : $ErrMsg_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/10/15, 14:51:46
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
	// Modified by: Costas Manousakis-(Designer)-(2/10/16 11:33:31)
	Mods_2016_02_bug
	//  `Account for Damage element which must be included in other defects
	// Modified by: Costas Manousakis-(Designer)-(2/24/16 12:34:53)
	Mods_2016_02_bug
	//  `fixed the code that is checking when the current element is NOT and NBE or prot sys  - was not excluding 7000
	// Modified by: Costas Manousakis-(Designer)-(5/4/16 12:31:39)
	Mods_2016_05_bug
	//  `exclude quantity of current defect if it is a Damage element 7000
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($ErrMsg_txt)
$ErrMsg_txt:=""
C_LONGINT:C283(PON_QCheck_ParentID_L)
ARRAY REAL:C219(PON_QCheck_ChildQ_ar; 0)
ARRAY LONGINT:C221(PON_QCheck_IDs_aL; 0)
ARRAY TEXT:C222(PON_QCheck_smflag_atxt; 0)

QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
If (([PON_ELEM_INSP:179]ELEM_PARENTID:27=0) | ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y"))
	//am i a NBE parent or a prot system?
	PON_QCheck_ParentID_L:=[PON_ELEM_INSP:179]ELEMID:22
	Begin SQL
		select [PON_ELEM_INSP].ELEM_QUANTITY, [PON_ELEM_DEFS].ELEM_SMART_FLAG from
		[PON_ELEM_INSP], [PON_ELEM_DEFS]
		where 
		[PON_ELEM_DEFS].ELEM_KEY = [PON_ELEM_INSP].Elem_key
		and
		[PON_ELEM_INSP].ELEM_PARENTID = :PON_QCheck_ParentID_L
		and
		[PON_ELEM_INSP].Elem_key <> 7000
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
	If ([PON_ELEM_INSP:179]ELEM_QUANTITY:7<$totChildQ_r)
		//ERROR
		$ErrMsg_txt:="The Sum of Quantities of Defects associated with this Element exceed the total Quantity of the Element!"
	End if 
Else 
	//child find siblings and parent
	PON_QCheck_ParentID_L:=[PON_ELEM_INSP:179]ELEM_PARENTID:27
	C_REAL:C285($ParentQ_r; $totChildQ_r)
	Begin SQL
		select [PON_ELEM_INSP].ELEM_QUANTITY 
		from
		[PON_ELEM_INSP]
		where 
		[PON_ELEM_INSP].ELEMID= :PON_QCheck_ParentID_L
		into 
		:PON_QCheck_ChildQ_ar  ;
	End SQL
	$ParentQ_r:=PON_QCheck_ChildQ_ar{1}
	
	Begin SQL
		select [PON_ELEM_INSP].ELEM_QUANTITY, [PON_ELEM_INSP].ELEMID, [PON_ELEM_DEFS].ELEM_SMART_FLAG from
		[PON_ELEM_INSP], [PON_ELEM_DEFS]
		where 
		[PON_ELEM_DEFS].ELEM_KEY = [PON_ELEM_INSP].Elem_key
		and
		[PON_ELEM_INSP].ELEM_PARENTID= :PON_QCheck_ParentID_L
		and
		[PON_ELEM_INSP].Elem_key <> 7000
		into 
		:PON_QCheck_ChildQ_ar , :PON_QCheck_IDs_aL, :PON_QCheck_smflag_atxt ;
	End SQL
	$totChildQ_r:=0
	For ($loop_L; 1; Size of array:C274(PON_QCheck_ChildQ_ar))
		If (PON_QCheck_IDs_aL{$loop_L}#[PON_ELEM_INSP:179]ELEMID:22)
			If (PON_QCheck_smflag_atxt{$loop_L}="Y")
				$totChildQ_r:=$totChildQ_r+PON_QCheck_ChildQ_ar{$loop_L}
			End if 
		End if 
	End for 
	//exclude current element if it is a damage 7000
	If ([PON_ELEM_INSP:179]ELEM_KEY:3#7000)
		$totChildQ_r:=$totChildQ_r+[PON_ELEM_INSP:179]ELEM_QUANTITY:7
	End if 
	
	If ($totChildQ_r>$ParentQ_r)
		$ErrMsg_txt:="The Sum of Quantities of Defects associated with the Parent of this Element exceed the total Quantity ("+String:C10($ParentQ_r; "###,###,###,###,###,###.00")+") of the Parent Element!"
	End if 
End if 

$0:=$ErrMsg_txt
//End PON_VerifyQuantity