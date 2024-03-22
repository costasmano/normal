//%attributes = {"invisible":true}
//GetParentPrefix 
//Created by Albert Leung
//Created 9/19/2002
//Purpose: Get the Prefix of the parent element
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/22/2007 11:12:49)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(11/1/2007 08:36:21)
	Mods_2007_CM12_5302
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 16:49:16)
	Mods_2012_12
	//  `Added special case for Rail RR@
	// Modified by: Costas Manousakis-(Designer)-(12/9/13 16:43:39)
	Mods_2013_12
	//  `Added  the case for Tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(2021-12-27T00:00:00 17:09:05)
	Mods_2021_12_bug
	//  `use the BaseType if it is defined ; add PED
End if 


C_TEXT:C284($vsDescr)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 4
C_LONGINT:C283($ElmNo_i; $ElmParNo_i; $k)  //Command Replaced was o_C_INTEGER
If (Count parameters:C259=1)
	C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER
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