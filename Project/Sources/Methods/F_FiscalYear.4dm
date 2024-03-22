//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/09/06, 17:49:08
	// ----------------------------------------------------
	// Method: F_FiscalYear
	// Description
	// Return the Fiscal year from a date - FY=Jul1-Jun30
	// 
	// Parameters
	// $0 : FY : Integer
	// $1 : Inputdate : Date
	// $2 : Start of Fiscal Year month : Int (Optional - default =7 : July)
	// $3 : FY goes to next year after the month ? Boolean : Optional - default = true
	// ----------------------------------------------------
	Mods_2006_CMz1
End if 
C_LONGINT:C283($0; $FY_I)  //Command Replaced was o_C_INTEGER
C_DATE:C307($1; $InputDate_d)
C_LONGINT:C283($2; $StartMonth_I)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($3; $AddAYear_b)
$InputDate_d:=$1
If (Count parameters:C259>1)
	$StartMonth_I:=$2
Else 
	$StartMonth_I:=7
End if 
If (Count parameters:C259>2)
	$AddAYear_b:=$3
Else 
	$AddAYear_b:=True:C214
End if 
C_LONGINT:C283($YearAdded_I)  //Command Replaced was o_C_INTEGER
If ($AddAYear_b)
	$YearAdded_I:=1
Else 
	$YearAdded_I:=0
End if 

$FY_I:=0
C_LONGINT:C283($Year_I; $Month_I)  //Command Replaced was o_C_INTEGER
$Month_I:=Month of:C24($InputDate_d)
$Year_I:=Year of:C25($InputDate_d)
If ($Month_I>=$StartMonth_I)
	$FY_I:=$Year_I+$YearAdded_I
Else 
	$FY_I:=$Year_I+(1-$YearAdded_I)
End if 

$0:=$FY_I