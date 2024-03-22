//%attributes = {}
//Method: INSP_GetElmtNumber
//Description
// return the element number label usually returned by GetElmtNumber but 
// using object INSP_InspTypeElems_o defined by INSP_LoadElemsByInspType 
// Parameters
// $0 : $ElmNumber_txt
// $1 : $ElmNum_L (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-12-27T00:00:00, 18:30:37
	// ----------------------------------------------------
	//Created : 
	Mods_2021_12_bug
	
	C_TEXT:C284(INSP_GetElmtNumber; $0)
	C_LONGINT:C283(INSP_GetElmtNumber; $1)
	
End if 
//

C_TEXT:C284($0; $vsparent; $vsElmt)
C_LONGINT:C283($ElmNo_i; $ElmParNo_i; $k)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)  // **replaced _ o _ c_INTEGER()
	$ElmNo_i:=$1
Else 
	$ElmNo_i:=[ElementsSafety:29]ElementNo:1
End if 

$K:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElmNo_i)
C_TEXT:C284($inspType)
$inspType:=[Inspections:27]Insp Type:6
If (Replace string:C233([Inspections:27]BaseType_s:215; " "; "")#"")
	$inspType:=Replace string:C233([Inspections:27]BaseType_s:215; " "; "")
End if 

If ($K>0)
	Case of 
		: ($inspType="RTA")
			$vsElmt:=<>ELMTDICT_Part_as{$k}
			If ($vsElmt="")
				$vsElmt:=<>ELMTDICT_Prefix_as{$k}
			End if 
			
		: (($inspType="RR@") | ($inspType="PED") | ($inspType="T@"))
			C_OBJECT:C1216(INSP_InspTypeElems_o; $insptype_o)
			$insptype_o:=OB Get:C1224(INSP_InspTypeElems_o; $inspType; Is object:K8:27)
			ARRAY LONGINT:C221($INSP_NewElementNumbers_ai; 0)
			ARRAY TEXT:C222($INSP_NewElementLabels_atxt; 0)
			If (OB Is defined:C1231($insptype_o))
				OB GET ARRAY:C1229($insptype_o; "ElemIDs"; $INSP_NewElementNumbers_ai)
				OB GET ARRAY:C1229($insptype_o; "ElemLabels"; $INSP_NewElementLabels_atxt)
			End if 
			$K:=Find in array:C230($INSP_NewElementNumbers_ai; $ElmNo_i)
			If ($K>0)
				$vsElmt:=$INSP_NewElementLabels_atxt{$k}
			End if 
		Else 
			$vsElmt:=<>ELMTDICT_Prefix_as{$k}
	End case 
	$vsparent:=INSP_GetParentPrefix($ElmNo_i)
	If ($vsparent#"")
		If (Length:C16($vsparent)=2)
			$vsparent:=" "+$vsparent
		End if 
		$0:=$vsparent+$vsElmt
	Else 
		If (Length:C16($vsElmt)=2)
			$0:=" "+$vsElmt
		Else 
			$0:=$vsElmt
		End if 
		
	End if 
Else 
	$0:=""
End if 
//End INSP_GetElmtNumber