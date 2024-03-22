//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/05, 15:06:42
	// ----------------------------------------------------
	// Method: QR_GroupBy
	// Description
	// place an argument into a group based on limiting vallues
	//
	// Parameters
	//$0 : index of group (integer) - -1 for error
	//$1 : value to be grouped (real)
	//$2-$n : limiting values (real)
	// Grouped based on $1<=$j
	// ----------------------------------------------------
	Mods_2005_CM12
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($0; $GroupNo_I; $NumGroups_I)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i)
C_REAL:C285($1; $Value_R)
C_REAL:C285($2; $3; $4; $5; $6; $7; $8)
$GroupNo_I:=0
If (Count parameters:C259>3)
	$NumGroups_I:=Count parameters:C259-1
	For ($i; 2; $NumGroups_I)
		If (($1>${$i}) & ($1<=${$i+1}))
			$GroupNo_I:=$i-1
		End if 
	End for 
	If ($1>${Count parameters:C259})
		$GroupNo_I:=Count parameters:C259-1
	End if 
Else 
	$GroupNo_I:=-1
	
End if 
$0:=$GroupNo_I