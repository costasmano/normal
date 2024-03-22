//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/23/11, 21:26:08
	// ----------------------------------------------------
	// Method: ut_charscan
	// Description
	//  ` Clean characters from a text
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 

C_TEXT:C284($0; $1; $scanme_txt; $char_c; $Fixed_txt)
$scanme_txt:=$1
C_LONGINT:C283($loop_L; $Len_L; $ascii_L)
$Len_L:=Length:C16($scanme_txt)
$Fixed_txt:=""
For ($loop_L; 1; $Len_L)
	$char_c:=Substring:C12($scanme_txt; $loop_L; 1)
	$ascii_l:=Character code:C91($char_c)
	If (($ascii_l>128) | ($ascii_l=0))
		Case of 
			: ($ascii_l=148)
				//change it to a doule quote
				ALERT:C41(" index "+String:C10($loop_L)+" : "+$char_c+" : "+String:C10($ascii_l))  //bullets are OK
				$Fixed_txt:=$Fixed_txt+<>sQU
				
			: ($ascii_l=183)  //bullets are OK
			: ($ascii_l=188)  //degree sign are OK
			: ($ascii_l=197)  //approx sign are OK
			: ($ascii_l=208)
				ALERT:C41(" index "+String:C10($loop_L)+" : "+$char_c+" : "+String:C10($ascii_l))  //bullets are OK
				$Fixed_txt:=$Fixed_txt+"-"
			: ($ascii_l=211)
				//change it to a doule quote
				ALERT:C41(" index "+String:C10($loop_L)+" : "+$char_c+" : "+String:C10($ascii_l))  //bullets are OK
				$Fixed_txt:=$Fixed_txt+<>sQU
			: ($ascii_l=213)
				//change it to a single quote
				ALERT:C41(" index "+String:C10($loop_L)+" : "+$char_c+" : "+String:C10($ascii_l))  //bullets are OK
				$Fixed_txt:=$Fixed_txt+Char:C90(39)
			: ($ascii_l=218)
				//change it to a 1/2
				ALERT:C41(" index "+String:C10($loop_L)+" : "+$char_c+" : "+String:C10($ascii_l))  //bullets are OK
				$Fixed_txt:=$Fixed_txt+Char:C90(39)
				
			: ($ascii_l=225)  //change this to a 'regular' bullet
				ALERT:C41(" index "+String:C10($loop_L)+" : "+$char_c+" : "+String:C10($ascii_l))  //bullets are OK
				$Fixed_txt:=$Fixed_txt+Char:C90(165)
			Else 
				ALERT:C41(" index "+String:C10($loop_L)+" : "+$char_c+" : "+String:C10($ascii_l))  //bullets are OK
				$Fixed_txt:=$Fixed_txt+" "
				
		End case 
	Else 
		//WR INSERT TEXT ($MyArea;Char($ascii_l))
		$Fixed_txt:=$Fixed_txt+$char_c
	End if 
	
End for 
$0:=$Fixed_txt