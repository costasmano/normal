//Method: "BridgeStatRepParameters"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/16/18, 12:09:49
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
C_POINTER:C301($Legacy_ptr; $SDCalc_ptr; $DistrCalc_ptr)
C_LONGINT:C283($index_L)

$Legacy_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "UseLegacyOwner")
$SDCalc_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "SDCalcMethod")
$DistrCalc_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DistrCalc_4")

C_OBJECT:C1216(STATREP_CalcParams_o)
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283($SDCalc_L; $Legacy_L; $DistrCalc_L)
		If (OB Is defined:C1231(STATREP_CalcParams_o; "SDNewCalcMethod"))
			$SDCalc_ptr->:=OB Get:C1224(STATREP_CalcParams_o; "SDNewCalcMethod"; Is longint:K8:6)
		End if 
		
		If (OB Is defined:C1231(STATREP_CalcParams_o; "UseLegacy"))
			$Legacy_ptr->:=OB Get:C1224(STATREP_CalcParams_o; "UseLegacy"; Is longint:K8:6)
		End if 
		
		$DistrCalc_ptr->:=0
		
		If (OB Is defined:C1231(STATREP_CalcParams_o; "DistrictCalc"))
			$DistrCalc_L:=OB Get:C1224(STATREP_CalcParams_o; "DistrictCalc")
			$index_L:=Find in array:C230($DistrCalc_ptr->; String:C10($DistrCalc_L)+"@")
			If ($index_L>0)
				$DistrCalc_ptr->:=$index_L
			End if 
			
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		
		OB SET:C1220(STATREP_CalcParams_o; "UseLegacy"; $Legacy_ptr->)
		OB SET:C1220(STATREP_CalcParams_o; "SDNewCalcMethod"; $SDCalc_ptr->)
		
		$index_L:=$DistrCalc_ptr->
		If ($index_L>0)
			OB SET:C1220(STATREP_CalcParams_o; "DistrictCalc"; Num:C11(Substring:C12($DistrCalc_ptr->{$index_L}; 1; 1)))
		End if 
		
End case 

//End BridgeStatRepParameters