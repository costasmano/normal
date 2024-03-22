//%attributes = {}
//Method: INSP_GetParentPrefix
//Description
// Get the prefix of the parent element similar to GetParentPrefix but using 
// using object INSP_InspTypeElems_o defined by INSP_LoadElemsByInspType 
// Parameters
// $0 : $ElmNumber_txt
// $1 : $ElmNum_L (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-12-27T00:00:00, 18:58:39
	// ----------------------------------------------------
	//Created : 
	Mods_2021_12_bug
	
	C_TEXT:C284(INSP_GetParentPrefix; $0)
	C_LONGINT:C283(INSP_GetParentPrefix; $1)
End if 
//


C_TEXT:C284($vsDescr)
C_TEXT:C284($0)
C_LONGINT:C283($ElmNo_i; $ElmParNo_i; $k)
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$ElmNo_i:=$1
Else 
	$ElmNo_i:=[ElementsSafety:29]ElementNo:1
End if 
$vsDescr:=""
$K:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElmNo_i)
C_TEXT:C284($inspType)
$inspType:=[Inspections:27]Insp Type:6
If (Replace string:C233([Inspections:27]BaseType_s:215; " "; "")#"")
	$inspType:=Replace string:C233([Inspections:27]BaseType_s:215; " "; "")
End if 

If ($k>0)
	$ElmParNo_i:=<>ELMTDICT_Parent_ai{$k}
	
	If ($ElmParNo_i#0)  //Does this element have a parent?
		$K:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElmParNo_i)
		Case of 
			: ($inspType="RTA")
				$vsDescr:=<>ELMTDICT_Part_as{$K}
				If ($vsDescr="")
					$vsDescr:=<>ELMTDICT_Prefix_as{$K}
				End if 
				
			: (($inspType="RR@") | ($inspType="T@") | ($inspType="PED"))
				C_OBJECT:C1216(INSP_InspTypeElems_o; $insptype_o)
				$insptype_o:=OB Get:C1224(INSP_InspTypeElems_o; $inspType; Is object:K8:27)
				ARRAY LONGINT:C221($INSP_NewElementNumbers_ai; 0)
				ARRAY TEXT:C222($INSP_NewElementLabels_atxt; 0)
				If (OB Is defined:C1231($insptype_o))
					OB GET ARRAY:C1229($insptype_o; "ElemIDs"; $INSP_NewElementNumbers_ai)
					OB GET ARRAY:C1229($insptype_o; "ElemLabels"; $INSP_NewElementLabels_atxt)
				End if 
				$K:=Find in array:C230($INSP_NewElementNumbers_ai; $ElmParNo_i)
				If ($K>0)
					$vsDescr:=$INSP_NewElementLabels_atxt{$k}
				End if 
				
				$K:=Find in array:C230(INSP_NewElementNumbers_ai; $ElmParNo_i)
				
				If ($K>0)
					$vsDescr:=INSP_NewElementLabels_atxt{$k}
				End if 
			Else 
				$vsDescr:=<>ELMTDICT_Prefix_as{$K}
		End case 
		
	End if 
End if 
$0:=$vsDescr
//End INSP_GetParentPrefix