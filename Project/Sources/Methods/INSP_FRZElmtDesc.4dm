//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/27/09, 16:36:48
	// ----------------------------------------------------
	// Method: Method: INSP_FRZElmtDesc
	// Description
	// 
	// 
	// Parameters
	// $0 : $Descr_txt 
	// $1 : $Element_no (optional)
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
End if 
C_TEXT:C284($0; $Descr_txt)
C_LONGINT:C283($Element_no)  //Command Replaced was o_C_INTEGER
If (Count parameters:C259>0)
	C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER
	$Element_no:=$1
Else 
	$Element_no:=[ElementsSafety:29]ElementNo:1
End if 

Case of 
	: ($Element_no=41)
		$Descr_txt:="Deck (Underside) / Arch Ring"
	: ($Element_no=42)
		$Descr_txt:="Beams and Diaphragms"
	: ($Element_no=43)
		$Descr_txt:="Concrete Piers / Pier Caps / Columns / Abutments"
	: ($Element_no=44)
		$Descr_txt:="Others (i.e. Parapets, Haunches, Spandrel Walls, etc.)"
	Else 
		$Descr_txt:=""
End case 

$0:=$Descr_txt