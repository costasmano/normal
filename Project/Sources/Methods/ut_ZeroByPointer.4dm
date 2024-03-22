//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/12/09, 08:34:09
	// ----------------------------------------------------
	// Method: ut_ZeroByPointer
	// Description
	// Will Zero/clear a series of variables, based on a pattern and a numeric counter.
	
	//!!!! VAriables MUST BE DEFINED because in compiled mode there is no way to check
	//!!! if the generated pointer points to a real variable or not!!!!
	// 
	// Parameters
	// $1 : $VarPattern_txt : must contain $Loop where the pattern will be incremented
	// $2 : $start_L
	// $3 : $End_L
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // ("WKHRMODS")
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 
C_TEXT:C284($1; $VarPattern_txt)
C_LONGINT:C283($2; $start_L; $3; $End_L)
$VarPattern_txt:=$1
$start_L:=$2
$End_L:=$3
C_POINTER:C301($Var_ptr)
C_LONGINT:C283($VarType_L)
C_LONGINT:C283($Loop_L; $VarTblTest_L; $VarFldTest_L)
C_BOOLEAN:C305($VarOK_B)
C_TEXT:C284($VarNameTest_txt)
//ALERT("Zero for "+$VarPattern_txt+" from "+String($start_L)+" to "+String($End_L))
For ($Loop_L; $start_L; $End_L)
	$Var_ptr:=Get pointer:C304(Replace string:C233($VarPattern_txt; "$Loop"; String:C10($Loop_L)))
	//RESOLVE POINTER($Var_ptr;$VarNameTest_txt;$VarTblTest_L;$VarFldTest_L)
	$VarOK_B:=(Type:C295($Var_ptr->)#5)
	//$VarOK_B:=($VarNameTest_txt=(Replace string($VarPattern_txt;"$Loop";String($Loop_L))))
	If ($VarOK_B)
		
		$VarType_L:=Type:C295($Var_ptr->)
		If ($VarTblTest_L=-1)
			Case of 
				: ($VarType_L=Is undefined:K8:13)
				: (($VarType_L=Is integer:K8:5) | ($VarType_L=Is longint:K8:6) | ($VarType_L=Is real:K8:4))
					$Var_ptr->:=0
				: (($VarType_L=Is string var:K8:2) | ($VarType_L=Is text:K8:3))
					$Var_ptr->:=""
				: ($VarType_L=Is BLOB:K8:12)
					SET BLOB SIZE:C606($Var_ptr->; 0)
				: ($VarType_L=Is picture:K8:10)
					$Var_ptr->:=($Var_ptr->)*0
				: ($VarType_L=Is date:K8:7)
					$Var_ptr->:=Date:C102("00/00/00")
				: ($VarType_L=Is date:K8:7)
					$Var_ptr->:=Time:C179("0")
					
			End case 
			
		End if 
	Else 
		//ALERT("Bad Variable call "+(Replace string($VarPattern_txt;"$Loop";String($Loop_L))))
	End if 
	
End for 