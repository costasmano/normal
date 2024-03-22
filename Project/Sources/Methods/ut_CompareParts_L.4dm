//%attributes = {"invisible":true}
//Method: ut_CompareParts_L
//Description
//  ` parts are either numeric or alpha - if numeric compare value, if alpha compare string
//  ` no error if not the same.  it is set by the second param.

// Parameters
// $0 : $comp_L (0:equal ; 1 : gt ; -1: lt)
// $1 : $t1_txt
// $2 : $t2_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/25/14, 16:59:24
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_LONGINT:C283($0)
C_TEXT:C284($1; $2)

C_LONGINT:C283($comp_L)
C_TEXT:C284($t1_txt; $t2_txt)

$comp_L:=0  //assume equal
$t1_txt:=$1
$t2_txt:=$2

C_BOOLEAN:C305($alpha_b)
$alpha_b:=(Match regex:C1019("[a-zA-Z]+"; $t2_txt) | Match regex:C1019("[a-zA-Z]+"; $t1_txt))
If ($alpha_b)
	Case of 
		: ($t1_txt>$t2_txt)
			$comp_L:=1
		: ($t1_txt<$t2_txt)
			$comp_L:=-1
	End case 
Else 
	C_REAL:C285($t1_r; $t2_r)
	$t1_r:=Num:C11($t1_txt)
	$t2_r:=Num:C11($t2_txt)
	Case of 
		: ($t1_r>$t2_r)
			$comp_L:=1
		: ($t1_r<$t2_r)
			$comp_L:=-1
	End case 
	
End if 

$0:=$comp_L
//End ut_CompareParts_L