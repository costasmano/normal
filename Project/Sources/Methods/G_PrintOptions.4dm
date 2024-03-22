//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/12/07, 10:20:31
	// ----------------------------------------------------
	// Method: G_PrintOptions
	// Description
	// Set the print options
	// 
	// Parameters
	// $1 : $Orientation : Lint (def 1: portrait)
	// $2 : $Paper : text (def first paper containing "Letter"") 
	//  ` - if a single space will keep the current paper setting
	// $3 : $Scale : Lint (def 100)
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(5/14/09 15:37:54)
	Mods_2009_05
	//Added logic to find the paper name that contains the word letter
	
	// Modified by: manousakisc (10/21/2013)
	Mods_2013_10
	//  `added setting of printable margins to 12;12;12;12 to match the best printable area
	// ` so that blank pages are not printed.
	
End if 

C_LONGINT:C283($1; $Orientation; $3; $Scale)
C_TEXT:C284($2; $Paper)

ARRAY TEXT:C222($Papers_atxt; 0)
PRINT OPTION VALUES:C785(Paper option:K47:1; $Papers_atxt)
$Orientation:=1
$Paper:="Letter"
C_LONGINT:C283($inList_L)
$inList_L:=Find in array:C230($Papers_atxt; "@Letter@")
If ($inList_L>0)
	$Paper:=$Papers_atxt{$inList_L}
End if 
$Scale:=100
If (Count parameters:C259>0)
	If ($1>0)
		$Orientation:=$1
	Else 
		If ($1<0)
			GET PRINT OPTION:C734(Orientation option:K47:2; $Orientation)
		End if 
	End if 
End if 
If (Count parameters:C259>1)
	If (Length:C16($2)>1)
		$Paper:=$2
	Else 
		If ($2=" ")
			GET PRINT OPTION:C734(Paper option:K47:1; $Paper)
		End if 
	End if 
End if 
If (Count parameters:C259>2)
	If ($3>0)
		$Scale:=$3
	Else 
		If ($3<0)
			GET PRINT OPTION:C734(Scale option:K47:3; $Scale)
		End if 
	End if 
End if 
SET PRINT OPTION:C733(Orientation option:K47:2; $Orientation)
SET PRINT OPTION:C733(Paper option:K47:1; $Paper)
SET PRINT OPTION:C733(Scale option:K47:3; $Scale)

//GET PRINTABLE MARGIN($left;$top;$right;$bott)
// set printable margins to 12 12 12 12
SET PRINTABLE MARGIN:C710(12; 12; 12; 12)