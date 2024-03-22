//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// SQL_SetUpStrings
	// User name (OS): 
	// Date and time: 05/24/05, 10:39:34
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM04
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_TEXT:C284($Text_txt; $0; $Compare_txt)
$Compare_txt:=$1
$Text_txt:=""
C_BOOLEAN:C305($IncludeTabs_b)
$IncludeTabs_b:=False:C215
C_TEXT:C284($SingleQuote_s)  // Command Replaced was o_C_STRING length was 1
$SingleQuote_s:=Char:C90(39)  //we might need to escape
If (Count parameters:C259=2)
	$IncludeTabs_b:=True:C214
End if 
C_LONGINT:C283($i)
For ($i; 1; Length:C16($Compare_txt))
	Case of 
		: (Character code:C91($Compare_txt[[$i]])=Tab:K15:37)  //carriage return
			If ($IncludeTabs_b)
				$Text_txt:=$Text_txt+" "  //$Compare_txt≤$i≥`Mods_2001_08_23 `replace tab with 1 space
			End if 
		: (Character code:C91($Compare_txt[[$i]])=Carriage return:K15:38)  //carriage return
			$Text_txt:=$Text_txt+" "
		: (Character code:C91($Compare_txt[[$i]])>0) & (Character code:C91($Compare_txt[[$i]])<=31)
			$Text_txt:=$Text_txt+" "
		: (Character code:C91($Compare_txt[[$i]])=166)
			$Text_txt:=$Text_txt+" "
		: (Character code:C91($Compare_txt[[$i]])=39)  //SINGLE
			$Text_txt:=$Text_txt+$Compare_txt[[$i]]+$SingleQuote_s
		Else 
			$Text_txt:=$Text_txt+$Compare_txt[[$i]]
	End case 
End for 
$0:=$Text_txt

//End SQL_SetUpStrings