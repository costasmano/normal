//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/30/09, 13:31:49
	// ----------------------------------------------------
	// Method: fCombineUWInsp
	// Description
	//Determine if a bridge is due for inspection for UW Routine, UW Special
	// 
	// Parameters
	//$Year:=$1
	//$Month:=$2
	//$m:=$3
	//$leeway:=$4
	//$Waive:=$5
	// ----------------------------------------------------
	
	Mods_2009_12
End if 
C_LONGINT:C283($1; $Year)
C_LONGINT:C283($2; $Month)
C_LONGINT:C283($3; $m)
C_LONGINT:C283($4; $leeway)
C_BOOLEAN:C305($5; $Waive)

C_BOOLEAN:C305($0; $test)
C_LONGINT:C283($i)

//Store parameters

$Year:=$1
$Month:=$2
$m:=$3
$leeway:=$4
$Waive:=$5

$test:=False:C215
For ($i; 8; 9)  //Do UW inspections 8,9
	If (fUpforInsp($Year; $Month; $m; $leeway; $i; $Waive))
		$test:=True:C214  //It needs to be inspected
	End if 
End for 
$0:=$test  //Return true or false