//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/08/08, 10:09:33
	// ----------------------------------------------------
	// Method: F_FindMaxIndx
	// Description
	// 
	// 
	// Parameters
	// $0 : $Index found
	// $1 : $SearchVal_ptr
	// $2 : $ArrayVal_ptr
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 
C_LONGINT:C283($0; $Index_L)
C_POINTER:C301($1; $SearchVal_ptr; $2; $ArrayVal_ptr)
$SearchVal_ptr:=$1
$ArrayVal_ptr:=$2
C_BOOLEAN:C305($Done_b)
C_LONGINT:C283($IMin_L; $IMax_L; $IMed_L; $arraysize_L)
$IMin_L:=1
$arraysize_L:=Size of array:C274($ArrayVal_ptr->)
$IMax_L:=$arraysize_L
Case of 
	: ($SearchVal_ptr-><=$ArrayVal_ptr->{1})
		$Index_L:=1
	: ($SearchVal_ptr->>=$ArrayVal_ptr->{$arraysize_L})
		$Index_L:=$arraysize_L
	Else 
		$Done_b:=False:C215
		Repeat 
			$IMed_L:=($IMin_L+$IMax_L)/2
			If ($SearchVal_ptr->>=$ArrayVal_ptr->{$IMed_L})
				If ($SearchVal_ptr-><=$ArrayVal_ptr->{$IMed_L+1})
					$Index_L:=$IMed_L+1
					$Done_b:=True:C214
				Else 
					$IMin_L:=$IMed_L
				End if 
			Else 
				If ($SearchVal_ptr->>=$ArrayVal_ptr->{$IMed_L-1})
					$Index_L:=$IMed_L
					$Done_b:=True:C214
				Else 
					$IMax_L:=$IMed_L
				End if 
			End if 
			
		Until ($Done_b)
		
End case 

$0:=$Index_L