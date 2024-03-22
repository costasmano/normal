//%attributes = {"invisible":true}
//GetElmtNumber 
//Get the element number in Safety Inspection.
//Format for sorting purposes.
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/25/2007 12:31:58)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(11/1/2007 08:36:32)
	Mods_2007_CM12_5302
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 16:49:16)
	Mods_2012_12
	//  `Added special case for Rail RR@
	// Modified by: Costas Manousakis-(Designer)-(5/6/13 14:43:54)
	Mods_2013_05
	//  `Added special case for  Tunnels T@
	// Modified by: Costas Manousakis-(Designer)-(10/25/19 13:21:08)
	Mods_2019_10_bug
	//  `Added special case for PED - same as RR@ - CallReference #667
	// Modified by: Costas Manousakis-(Designer)-(2021-12-27T00:00:00 17:09:05)
	Mods_2021_12_bug
	//  `use the BaseType if it is defined
End if 

C_TEXT:C284($0; $vsparent; $vsElmt)  // **Replaced old C_STRING length 6
C_LONGINT:C283($ElmNo_i; $ElmParNo_i; $k)  // **replaced _ o _ c_INTEGER()
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
			
		: (($inspType="RR@") | ($inspType="PED"))
			$K:=Find in array:C230(INSP_NewElementNumbers_ai; $ElmNo_i)
			If ($K>0)
				$vsElmt:=INSP_NewElementLabels_atxt{$k}
			End if 
			
		: ($inspType="T@")
			$K:=Find in array:C230(INSP_NewElementNumbers_ai; $ElmNo_i)
			If ($K>0)
				$vsElmt:=INSP_NewElementLabels_atxt{$k}
			End if 
			
		Else 
			$vsElmt:=<>ELMTDICT_Prefix_as{$k}
	End case 
	$vsparent:=GetParentPrefix($ElmNo_i)
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