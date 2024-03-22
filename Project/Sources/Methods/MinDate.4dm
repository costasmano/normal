//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/30/09, 08:53:45
	// ----------------------------------------------------
	// Method: MinDate
	// Description
	// Get the minimum of a set of dates - ignore null dates
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
End if 

C_LONGINT:C283($NoPars; $i)  //Command Replaced was o_C_INTEGER
C_DATE:C307($Min; $0)
C_DATE:C307(${1})  //parameters $1 to $n of date

$NoPars:=Count parameters:C259
$Min:=!9999-12-31!

If ($NoPars>0)
	If ($1#!00-00-00!)
		$Min:=$1
	End if 
	
	If ($NoPars>1)
		For ($i; 2; $NoPars)
			If (${$i}#!00-00-00!)
				If (${$i}<$Min)
					$Min:=${$i}
				End if 
				
			End if 
		End for 
	End if 
End if 

$0:=$Min