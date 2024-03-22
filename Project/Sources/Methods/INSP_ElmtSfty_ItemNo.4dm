//%attributes = {"invisible":true}
// Method: INSP_ElmtSfty_ItemNo
// Description
// Get the Item no var for the elements safety
// 
// Parameters
// $0 : itemno :text
// $1 : $ElmtNo_L (optional - if not passed use the current Elementsafety elementNo value
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/08/08, 18:12:54
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DEFELMTEXPORT")
	// Modified by: costasmanousakis-(Designer)-(2/16/10 10:48:48)
	Mods_2010_02
	//  `Fix display of item 58
	// Modified by: Costas Manousakis-(Designer)-(5/2/13 09:28:39)
	Mods_2013_05
	//  `Tunnel Items
End if 
C_TEXT:C284($0; $ItemNo_txt)
$ItemNo_txt:=""
C_LONGINT:C283($ElmNo_i)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($Include_I_b)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER
	$ElmNo_i:=$1
Else 
	$ElmNo_i:=[ElementsSafety:29]ElementNo:1
End if 
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$Include_I_b:=$2
Else 
	$Include_I_b:=True:C214
End if 


C_LONGINT:C283($K)


$K:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElmNo_i)
If ($K>0)
	
	Case of 
		: (<>ELMTDICT_Cat_as{$K}="N60")
			If ($Include_I_b)
				$ItemNo_txt:="I 60"
			Else 
				$ItemNo_txt:="60"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="N61")
			If ($Include_I_b)
				$ItemNo_txt:="I 61"
			Else 
				$ItemNo_txt:="61"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="N62")
			If ($Include_I_b)
				$ItemNo_txt:="I 62"
			Else 
				$ItemNo_txt:="62"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="N58")
			If ($Include_I_b)
				$ItemNo_txt:="I 58"
			Else 
				$ItemNo_txt:="58"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="N59")
			If ($Include_I_b)
				$ItemNo_txt:="I 59"
			Else 
				$ItemNo_txt:="59"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="STR")
			If ($Include_I_b)
				$ItemNo_txt:="62a"
			Else 
				$ItemNo_txt:="62a"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="CEI")
			If ($Include_I_b)
				$ItemNo_txt:="62c"
			Else 
				$ItemNo_txt:="62c"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="SUP")
			If ($Include_I_b)
				$ItemNo_txt:="62d"
			Else 
				$ItemNo_txt:="62d"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="ROA")
			If ($Include_I_b)
				$ItemNo_txt:="62b"
			Else 
				$ItemNo_txt:="62b"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="CRO")
			If ($Include_I_b)
				$ItemNo_txt:="62e"
			Else 
				$ItemNo_txt:="62e"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="EGR")
			If ($Include_I_b)
				$ItemNo_txt:="62f"
			Else 
				$ItemNo_txt:="62f"
			End if 
		: (<>ELMTDICT_Cat_as{$K}="UTI")
			If ($Include_I_b)
				$ItemNo_txt:="62g"
			Else 
				$ItemNo_txt:="62g"
			End if 
		Else 
			$ItemNo_txt:=<>ELMTDICT_Cat_as{$K}
	End case 
Else 
	$ItemNo_txt:=""
End if 

$0:=$ItemNo_txt