//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/07/08, 08:23:45
	// ----------------------------------------------------
	// Method: FN_AtWordBoundary
	// Description
	//  ` Determine whether we are at a word boundary.
	// 
	// Parameters
	// $0 : $AtBoundary_b : Bool
	// $1 : $PrevChar_s : String(1)
	// $2 : $CurChar_s : String(1)
	// $3 : $NextChar_s : String(1)
	
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_BOOLEAN:C305($0; $AtBoundary_b)
C_TEXT:C284($1; $PrevChar_s; $2; $CurChar_s; $3; $NextChar_s)  // Command Replaced was o_C_STRING length was 1
$PrevChar_s:=$1
$CurChar_s:=$2
$NextChar_s:=$3
$AtBoundary_b:=False:C215
C_TEXT:C284($SetDefinite_txt; $SetMaybe_txt; $SetNumbers_txt)
$SetDefinite_txt:="!?; "+<>sCR+<>sLF+<>sTAB
$SetMaybe_txt:=".,:"
$SetNumbers_txt:="0123456789"

Case of 
	: ($CurChar_s="")
		$AtBoundary_b:=True:C214
	: ($NextChar_s="")
		$AtBoundary_b:=True:C214
	: (Position:C15($CurChar_s; $SetDefinite_txt)>0)
		$AtBoundary_b:=True:C214
	: (Position:C15($NextChar_s; $SetDefinite_txt)>0)
		$AtBoundary_b:=True:C214
	: (Position:C15($CurChar_s; $SetMaybe_txt)>0)
		If (Position:C15($PrevChar_s; $SetNumbers_txt)>0)
			$AtBoundary_b:=True:C214
		End if 
	: (Position:C15($NextChar_s; $SetMaybe_txt)>0)
		If (Position:C15($CurChar_s; $SetNumbers_txt)>0)
			$AtBoundary_b:=True:C214
		End if 
		
End case 

$0:=$AtBoundary_b