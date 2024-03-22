//%attributes = {"invisible":true}
//Method: CU_SetLBFormat
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/09/19, 11:53:43
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
End if 
//

C_LONGINT:C283($1; $Column_L; $0; $i)
$Column_L:=$1
C_POINTER:C301($Var_ptr)
$Var_ptr:=Get pointer:C304("VCS"+String:C10($Column_L))
For ($i; 1; 5)
	//Negative value is displayed as blank.  
	$Var_ptr->:=-1  //Pointer to vNewCSi
	If (([Cond Units:45]Percent:6) & ([Cond Units:45]Total Quantity:5>0))
		ALERT:C41("IN %")
		$Var_ptr->:=Round:C94(100*(a_ptr_CSfld{$Column_L}->/[Cond Units:45]Total Quantity:5); 1)
		OBJECT SET FORMAT:C236($Var_ptr->; "##0.0 %;")
	Else 
		ALERT:C41("IN other")
		If (Not:C34([BMS Inspections:44]Metric:14))
			$Var_ptr->:=Round:C94(AnglicizeQ(a_ptr_CSfld{$Column_L}->; [BMS Elements:47]Units:6); 1)
		End if 
		OBJECT SET FORMAT:C236($Var_ptr->; "#,###,##0.0;")
		
	End if 
	
	
	
End for 
ALERT:C41("$Var_ptr IS "+String:C10($Var_ptr->))
$0:=$Var_ptr->
ALERT:C41("$0 IS "+String:C10($0))
//End CU_SetLBFormat