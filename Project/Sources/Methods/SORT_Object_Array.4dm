//%attributes = {"invisible":true}
//Method: SORT_Object_Array
//         Purpose: Simple Bubble Sort for an array object
//         $1 - Pointer - Pointer to the object array
//         $2 - Text - Property name to sort on
//         $3 - Boolean - Direction: True< = Ascending, False = Decending
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-04-22T00:00:00, 20:39:13
	// ----------------------------------------------------
	//Created : Copied from 4D KB 77040
	
End if 
//
If (False:C215)
	
	C_POINTER:C301(SORT_Object_Array; $1)
	C_TEXT:C284(SORT_Object_Array; $2)
	C_BOOLEAN:C305(SORT_Object_Array; $3)
	
End if 
C_TEXT:C284($MethodName_T)
$MethodName_T:=Current method name:C684
//===================== Declare Variables ==================================
//method_parameters_declarations
C_POINTER:C301($ObjArray_P; $1)
C_TEXT:C284($PropertyName_T; $2)
C_BOOLEAN:C305($Ascending_B; $3)
//-----------------------------------------------------------------------
//method_wide_constants_declarations
//-----------------------------------------------------------------------
//local_variable_declarations
C_LONGINT:C283($Ndx; $Jdx; $SOA; $RIS; $Params_L; $Type_L)
C_OBJECT:C1216($Tmp_O)
C_POINTER:C301($Val_1_P; $Val_2_P)
C_TEXT:C284($Val_1_T; $Val_2_T)
C_BOOLEAN:C305($Val_1_B; $Val_2_B)
C_REAL:C285($Val_1_R; $Val_2_R)
C_DATE:C307($Val_1_D; $Val_2_D)
C_TIME:C306($Val_1_H; $Val_2_H)


//====================== Initialize and Setup ================================

$Params_L:=Count parameters:C259
If (Asserted:C1132($Params_L=3; "Bad param count! Should have been 3, was "+String:C10($Params_L)))
	
	$ObjArray_P:=$1
	$PropertyName_T:=$2
	$Ascending_B:=$3  // False = Decending
	
	If (Type:C295($ObjArray_P->)=Object array:K8:28)
		
		$SOA:=Size of array:C274($ObjArray_P->)
		If ($SOA>0)
			
			$Type_L:=OB Get type:C1230($ObjArray_P->{1}; $PropertyName_T)
			Case of 
					
				: (($Type_L=Is text:K8:3) | ($Type_L=Is string var:K8:2))
					$Val_1_P:=(->$Val_1_T)
					$Val_2_P:=(->$Val_2_T)
					
				: (($Type_L=Is integer:K8:5) | ($Type_L=Is longint:K8:6) | ($Type_L=Is real:K8:4))  //| ($Type_L=Is float))
					$Val_1_P:=(->$Val_1_R)
					$Val_2_P:=(->$Val_2_R)
					
				: ($Type_L=Is boolean:K8:9)
					$Val_1_P:=(->$Val_1_B)
					$Val_2_P:=(->$Val_2_B)
					
				: ($Type_L=Is date:K8:7)
					$Val_1_P:=(->$Val_1_D)
					$Val_2_P:=(->$Val_2_D)
					
				: ($Type_L=Is time:K8:8)
					$Val_1_P:=(->$Val_1_H)
					$Val_2_P:=(->$Val_2_H)
					
				Else 
					$Type_L:=-1
					
			End case 
			
			//=================== Method Actions =============================
			
			If ($Type_L#-1)
				If ($Ascending_B)
					// Sort Asending
					For ($Ndx; 1; $SOA)
						For ($Jdx; 1; $SOA-$Ndx)
							
							$Val_1_P->:=OB Get:C1224($ObjArray_P->{$Jdx}; $PropertyName_T)
							$Val_2_P->:=OB Get:C1224($ObjArray_P->{$Jdx+1}; $PropertyName_T)
							
							If ($Val_2_P-><$Val_1_P->)  // Ascending sort
								
								$Tmp_O:=OB Copy:C1225($ObjArray_P->{$Jdx})
								$ObjArray_P->{$Jdx}:=OB Copy:C1225($ObjArray_P->{$Jdx+1})
								$ObjArray_P->{$Jdx+1}:=OB Copy:C1225($Tmp_O)
								
							End if 
							
						End for 
					End for 
					
				Else 
					// Sort Decending
					For ($Ndx; 1; $SOA)
						For ($Jdx; 1; $SOA-$Ndx)
							
							$Val_1_P->:=OB Get:C1224($ObjArray_P->{$Jdx}; $PropertyName_T)
							$Val_2_P->:=OB Get:C1224($ObjArray_P->{$Jdx+1}; $PropertyName_T)
							
							If ($Val_2_P->>$Val_1_P->)  // Decending sort
								
								$Tmp_O:=OB Copy:C1225($ObjArray_P->{$Jdx})
								$ObjArray_P->{$Jdx}:=OB Copy:C1225($ObjArray_P->{$Jdx+1})
								$ObjArray_P->{$Jdx+1}:=OB Copy:C1225($Tmp_O)
								
							End if 
							
						End for 
					End for 
					
				End if 
			End if 
		End if 
	End if 
	
	//======================== Clean up and Exit =================================
	
End if 