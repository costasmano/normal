//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/07, 15:20:50
	// ----------------------------------------------------
	// Method: WKHR_Accumulate
	// Description
	// Custom Accumulate function. to ignore zero entries
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
C_POINTER:C301($2; $3; $Total_ptr; $Counter_ptr)
$Total_ptr:=$2
$Counter_ptr:=$3
C_LONGINT:C283($4)
C_TEXT:C284($1; $Function)
$Function:=$1
C_LONGINT:C283($0)
Case of 
	: ($Function="ACCUMULATE")
		If ($4>0)
			$Total_ptr->:=$Total_ptr->+$4
			$Counter_ptr->:=$Counter_ptr->+1
		End if 
	: ($Function="AVERAGE")
		C_REAL:C285($res)
		If ($Counter_ptr->>0)
			$res:=($Total_ptr->)/($Counter_ptr->)
			$0:=Int:C8(Round:C94($res; 0))
		Else 
			$0:=0
		End if 
		$Total_ptr->:=0
		$Counter_ptr->:=0
End case 