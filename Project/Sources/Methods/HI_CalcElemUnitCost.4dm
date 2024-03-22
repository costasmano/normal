//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/15/05, 20:47:50
	// ----------------------------------------------------
	// Method: HI_CalcElemUnitCost
	// Description
	// Calculate the Element Unit Cost
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM18
	Mods_2011_06  // CJ Miller`06/14/11, 11:22:11      ` Type all local variables for v11
End if 
C_REAL:C285($0; $UnitCost_R)
C_LONGINT:C283($1; $ElemID; $2; $Env)

If (Count parameters:C259=2)
	$ElemID:=$1
	$Env:=$2
Else 
	$ElemID:=[Cond Units:45]Element ID:3
	$Env:=[Cond Units:45]Environment:4
End if 
If (($Env<1) | ($Env>4))
	$Env:=2  //Assume Enviroment 2 if missing
End if 
$UnitCost_R:=0
If (False:C215)
	QUERY:C277([ACTMODLS:91]; [ACTMODLS:91]ELEMKEY:2=[BMS Elements:47]Element No:2; *)
	QUERY:C277([ACTMODLS:91];  & ; [ACTMODLS:91]ENVKEY:5=[Cond Units:45]Environment:4; *)
	QUERY:C277([ACTMODLS:91];  & ; [ACTMODLS:91]SKEY:3=[BMS Categories:49]Num of CSs:7; *)
	QUERY:C277([ACTMODLS:91];  & ; [ACTMODLS:91]MOKEY:1="00")
	SELECTION TO ARRAY:C260([ACTMODLS:91]VARUNITCO:13; $arr_UnitCost_R)
	$UnitCost_R:=0
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($arr_UnitCost_R))
		If ($arr_UnitCost_R{$i}>$UnitCost_R)
			$UnitCost_R:=$arr_UnitCost_R{$i}
		End if 
		
	End for 
Else 
	QUERY:C277([Element Costs:50]; [Element Costs:50]Element ID:1=$ElemID; *)
	QUERY:C277([Element Costs:50];  & ; [Element Costs:50]Environment:5=$Env; *)
	QUERY:C277([Element Costs:50];  & ; [Element Costs:50]Action No:3="HI")
	If (Records in selection:C76([Element Costs:50])>0)
		$UnitCost_R:=[Element Costs:50]Cost:4
	End if 
	
End if 
$0:=$UnitCost_R