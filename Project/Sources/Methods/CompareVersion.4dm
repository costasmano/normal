//%attributes = {"invisible":true}
//Method: CompareVersion
//Description
// compare two versions and return if the first is at or greater than the second
// Versions starting with major and minors separated by "."  ex 7.2.1.a
// the basis of comparison is based on the second version. 
// if the nth minor of the second verion is a number, the comparison is numeric, 
// otherwise it is a string comparison
// Parameters
// $0 : $GTE_b
// $1 : $V1 
// $1 : $V2 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/18/20, 15:47:53
	// ----------------------------------------------------
	//Created : 
	Mods_2020_05
	C_BOOLEAN:C305(CompareVersion; $0)
	C_TEXT:C284(CompareVersion; $1; $2)
End if 
//

C_BOOLEAN:C305($0; $GTE_b)
C_TEXT:C284($1; $2; $v1; $v2)
$v1:=$1
$v2:=$2
ARRAY TEXT:C222($v1_atxt; 0)
ARRAY TEXT:C222($v2_atxt; 0)
ut_TextToArray($v1; ->$v1_atxt; ".")
ut_TextToArray($v2; ->$v2_atxt; ".")
If (Size of array:C274($v2_atxt)>Size of array:C274($v1_atxt))
	ARRAY TEXT:C222($v1_atxt; Size of array:C274($v2_atxt))
End if 
C_LONGINT:C283($loop_L)
C_BOOLEAN:C305($VerGT_b; $verEq_b; $verLT_b)
$VerGT_b:=False:C215
$verEq_b:=True:C214
$verLT_b:=False:C215
Case of 
	: (Size of array:C274($v2_atxt)=0)
		//????
	: (Size of array:C274($v1_atxt)=0)
		//???
	Else 
		
		For ($loop_L; 1; Size of array:C274($v2_atxt))
			If ($loop_L>Size of array:C274($v1_atxt))
				//reached end of input ver before target version : input ver is less than target
				$verLT_b:=False:C215
			Else 
				
				If (bIsNumeric($v2_atxt{$loop_L}))
					//comparing number
					
					Case of 
						: (Num:C11($v1_atxt{$loop_L})>Num:C11($v2_atxt{$loop_L}))
							//we are over the target version - exit
							$VerGT_b:=True:C214
							$loop_L:=Size of array:C274($v2_atxt)+1
						: (Num:C11($v1_atxt{$loop_L})=Num:C11($v2_atxt{$loop_L}))
							//still same - keep checking
						Else 
							//less - exit loop
							$loop_L:=Size of array:C274($v2_atxt)+1
							$verLT_b:=True:C214
					End case 
					
				Else 
					//comparing text
					
					Case of 
						: ($v1_atxt{$loop_L}>$v2_atxt{$loop_L})
							//we are over the target version - exit
							$VerGT_b:=True:C214
							$loop_L:=Size of array:C274($v2_atxt)+1
						: ($v1_atxt{$loop_L}=$v2_atxt{$loop_L})
							//still same - keep checking
						Else 
							//less - exit loop
							$loop_L:=Size of array:C274($v2_atxt)+1
							$verLT_b:=True:C214
							
					End case 
					
				End if 
				
			End if 
			
		End for 
End case 

$GTE_b:=Not:C34($verLT_b)
$0:=$GTE_b

//ALERT("version "+$v1+" is "+Choose(Not($verLT_b);"At or after version ";"before version ")+$v2)

//End CompareVersion