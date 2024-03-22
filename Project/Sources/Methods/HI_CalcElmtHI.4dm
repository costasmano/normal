//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/10/05, 19:13:13
	// ----------------------------------------------------
	// Method: HI_CalcElmtHI
	// Description
	// Calculate the Health Index value for an element
	//
	// Parameters
	//$1 : > Total quantity
	//$2 : > St1
	//$3 : > St2
	//$4 : > St3
	//$5 : > St4
	//$6 : > St5
	//$7 : > NumberofStates
	// ----------------------------------------------------
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(2/25/10 12:36:24)
	Mods_2010_02
	//  `Fixed a coding issue with parameter $8 - which is not being used anyway
End if 
C_REAL:C285($0; $vr_CurrentElmtValue)
C_REAL:C285($1; $Totalquantity; $2; $St1; $3; $St2; $4; $St3; $5; $St4; $6; $St5)
C_LONGINT:C283($7; $NumberofStates)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($vp_CurrentElmtValue)

C_REAL:C285($vr_HI1; $vr_HI2; $vr_HI3; $vr_HI4; $vr_HI5)
If (Count parameters:C259=7)
	$Totalquantity:=$1
	$St1:=$2
	$St2:=$3
	$St3:=$4
	$St4:=$5
	$St5:=$6
	$NumberofStates:=$7
Else 
	$Totalquantity:=[Cond Units:45]Total Quantity:5
	$St1:=[Cond Units:45]CondState1:10
	$St2:=[Cond Units:45]CondState2:11
	$St3:=[Cond Units:45]CondState3:12
	$St4:=[Cond Units:45]CondState4:13
	$St5:=[Cond Units:45]CondState5:14
	$NumberofStates:=[BMS Categories:49]Num of CSs:7
End if 

If (Count parameters:C259>7)
	C_POINTER:C301($8)
	$vp_CurrentElmtValue:=$8
End if 

If ($Totalquantity>0)
	$vr_HI1:=Round:C94(($St1/$Totalquantity); 2)
	$vr_HI2:=Round:C94((($St2/$Totalquantity)*(1-(1/($NumberofStates-1)))); 2)
	$vr_HI3:=Round:C94((($St3/$Totalquantity)*(1-(2/($NumberofStates-1)))); 2)
	If ($St4>0)
		$vr_HI4:=Round:C94((($St4/$Totalquantity)*(1-(3/($NumberofStates-1)))); 2)
	Else 
		$vr_HI4:=0
	End if 
	If ($St5>0)
		$vr_HI5:=Round:C94((($St5/$Totalquantity)*(1-(4/($NumberofStates-1)))); 2)
	Else 
		$vr_HI5:=0
	End if 
	$vr_CurrentElmtValue:=Round:C94($vr_HI1+$vr_HI2+$vr_HI3+$vr_HI4+$vr_HI5; 2)
Else 
	$vr_CurrentElmtValue:=0
End if 

$0:=$vr_CurrentElmtValue