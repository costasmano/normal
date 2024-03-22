//%attributes = {"invisible":true}
//Method: ut_MessageArray
//Description
// Write an array using ut_message. 
// Will convert int, real, date arrays to strings, boolean to Y or N
// Others will print an error message
// Parameters
// $1 : $Array_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/08/14, 10:37:18
	// ----------------------------------------------------
	//Created : 
	Mods_2014_09
End if 
//
C_POINTER:C301($1)

C_LONGINT:C283($loop_L; $arrayType_L; $tableNum_L; $fieldNum_L)
C_TEXT:C284($varName_txt)
$arrayType_L:=Type:C295($1->)
RESOLVE POINTER:C394($1; $varName_txt; $tableNum_L; $fieldNum_L)
Case of 
	: (($arrayType_L=Text array:K8:16) | ($arrayType_L=String array:K8:15))
		For ($loop_L; 1; Size of array:C274($1->))
			ut_Message($1->{$loop_L}+<>sCR)
		End for 
	: (($arrayType_L=LongInt array:K8:19) | ($arrayType_L=Integer array:K8:18) | ($arrayType_L=Real array:K8:17) | ($arrayType_L=Date array:K8:20))
		For ($loop_L; 1; Size of array:C274($1->))
			ut_Message(String:C10($1->{$loop_L})+<>sCR)
		End for 
	: (($arrayType_L=Boolean array:K8:21))
		For ($loop_L; 1; Size of array:C274($1->))
			ut_Message(f_Boolean2String($1->{$loop_L}; "YN")+<>sCR)
		End for 
	: (($arrayType_L=Pointer array:K8:23) | ($arrayType_L=Picture array:K8:22))
		ut_Message("!!!! ut_MessageArray Error : Cannot print to text a "+fGetDataType($arrayType_L)+"  array name :"+$varName_txt+"!!!!"+<>sCR)
	Else 
		ut_Message("!!!! ut_MessageArray Error : Invalid data type passed "+fGetDataType($arrayType_L)+" variable name :"+$varName_txt+"!!!!"+<>sCR)
		ut_Message("!!!!     Table Number :"+String:C10($tableNum_L)+"  Field Num :"+String:C10($fieldNum_L))
		
		If (Is table number valid:C999($tableNum_L))
			
			If (Is field number valid:C1000($tableNum_L; $fieldNum_L))
				ut_Message("!!!!     Field Name :"+Field name:C257($tableNum_L; $fieldNum_L))
			Else 
				ut_Message("!!!!     Table Name :"+Table name:C256($tableNum_L))
			End if 
			
		End if 
		ut_Message(<>sCR)
End case 

//End ut_MessageArray