//%attributes = {"invisible":true}
// Method: SIA_Item5_OM
// Description
//  ` sets the variable and arrays used to enter Item 5
// Parameters
// $1 : $Item5Fld_ptr
// $2 : $ChgStackNum_L
// $3 : $FormEvent_L
// 
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/21/14, 15:46:23
	// ----------------------------------------------------
	// First Release
	Mods_2014_05
	// Modified by: Costas Manousakis-(Designer)-(4/9/19 17:34:22)
	Mods_2019_04_bug
	//  `change Item5D to text var to allow a route letter ex. 2A 
End if 
C_POINTER:C301($1)
C_POINTER:C301($Item5Fld_ptr)
$Item5Fld_ptr:=$1
C_LONGINT:C283($ChgStackNum_L)
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$ChgStackNum_L:=$2
Else 
	$ChgStackNum_L:=1
End if 

C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>2)
	C_LONGINT:C283($3)
	$FormEvent_L:=$3
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_TEXT:C284(Item5A_txt)
C_TEXT:C284(Item5D_txt)

C_TEXT:C284($item5b_s; $item5c_s; $item5e_s)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($item5_txt)
C_LONGINT:C283($inArray_L)
Case of 
	: ($FormEvent_L=On Load:K2:1)
		Item5A_txt:=Substring:C12($Item5Fld_ptr->; 1; 1)
		Item5D_txt:=Substring:C12($Item5Fld_ptr->; 4; 5)
		
		$item5b_s:=Substring:C12($Item5Fld_ptr->; 2; 1)
		$item5c_s:=Substring:C12($Item5Fld_ptr->; 3; 1)
		$item5e_s:=Substring:C12($Item5Fld_ptr->; 9; 1)
		$inArray_L:=Find in array:C230(Item5B_atxt; ($item5b_s+" @"))
		Item5B_atxt:=0
		If ($inArray_L>0)
			Item5B_atxt{0}:=Item5B_atxt{$inArray_L}
		End if 
		$inArray_L:=Find in array:C230(Item5c_atxt; ($item5c_s+" @"))
		Item5C_atxt:=0
		If ($inArray_L>0)
			Item5C_atxt{0}:=Item5C_atxt{$inArray_L}
		End if 
		$inArray_L:=Find in array:C230(Item5E_atxt; ($item5E_s+" @"))
		Item5E_atxt:=0
		If ($inArray_L>0)
			Item5E_atxt{0}:=Item5E_atxt{$inArray_L}
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		$item5_txt:=Item5A_txt+String:C10(Num:C11(Item5B_atxt{0}); "0")+String:C10(Num:C11(Item5C_atxt{0}); "0")+Item5D_txt+String:C10(Num:C11(Item5E_atxt{0}); "0")
		$Item5Fld_ptr->:=$item5_txt
		PushChange($ChgStackNum_L; $Item5Fld_ptr)
		
	: ($FormEvent_L=On Clicked:K2:4)
		$inArray_L:=Item5B_atxt
		C_BOOLEAN:C305($Item5Change_b)
		$Item5Change_b:=False:C215
		If (Item5B_atxt{0}#Item5B_atxt{$inArray_L})
			Item5B_atxt{0}:=Item5B_atxt{$inArray_L}
			$Item5Change_b:=True:C214
		End if 
		$inArray_L:=Item5C_atxt
		If (Item5C_atxt{0}#Item5C_atxt{$inArray_L})
			Item5C_atxt{0}:=Item5C_atxt{$inArray_L}
			$Item5Change_b:=True:C214
		End if 
		$inArray_L:=Item5E_atxt
		If (Item5E_atxt{0}#Item5E_atxt{$inArray_L})
			Item5E_atxt{0}:=Item5E_atxt{$inArray_L}
			$Item5Change_b:=True:C214
		End if 
		
		If ($Item5Change_b)
			$item5_txt:=Item5A_txt+String:C10(Num:C11(Item5B_atxt{0}); "0")+String:C10(Num:C11(Item5C_atxt{0}); "0")+Item5D_txt+String:C10(Num:C11(Item5E_atxt{0}); "0")
			$Item5Fld_ptr->:=$item5_txt
			PushChange($ChgStackNum_L; $Item5Fld_ptr)
			
		End if 
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		
End case 