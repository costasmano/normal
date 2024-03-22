//%attributes = {"invisible":true}
//Method: ut_ArrayToText
// Convert and array to a text variable. Can handle String, text, Date, integer, longint, real, boolean, time
// Can specify the separator between the array elements. default is charriage return (char(13))
// Can also specify a prefix for each of the array elements. default is ""
// Parameters
// $0 : $MyText_txt
// $1 : $array_ptr
// $2 : $Delimiter_txt (optional)
// $3 : $Prefix_txt (optional)
// $4 : $Format_txt (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/21/15, 14:20:46
	// ----------------------------------------------------
	//Created : 
	Mods_2015_12_bug
	
	C_TEXT:C284(ut_ArrayToText; $0)
	C_POINTER:C301(ut_ArrayToText; $1)
	C_TEXT:C284(ut_ArrayToText; $2)
	C_TEXT:C284(ut_ArrayToText; $3)
	C_TEXT:C284(ut_ArrayToText; $4)
	
	// Modified by: Costas Manousakis-(Designer)-(7/8/21 12:52:30)
	Mods_2021_07
	//  `added boolean and time arrays; 
	//  `for date and time arrays use Num of the format passed in $4
	//  `for boolean if the format passed is "valueIftrue;valueifFalse", 
	//  //  `split the two values and use Choose (bool;"valueiftrue";"valueifFalse")
End if 
//
C_TEXT:C284($0)
C_POINTER:C301($1)

C_TEXT:C284($MyText_txt; $Delimiter_txt; $Prefix_txt; $Format_txt)
C_POINTER:C301($Array_ptr)
$MyText_txt:=""
$Delimiter_txt:=Char:C90(Carriage return:K15:38)
$Prefix_txt:=""
$Format_txt:=""
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$Delimiter_txt:=$2
End if 
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$Prefix_txt:=$3
End if 
If (Count parameters:C259>3)
	C_TEXT:C284($4)
	$Format_txt:=$4
End if 

$Array_ptr:=$1
//convert the array in $1 to a text array
ARRAY TEXT:C222($List_atxt; 0)
C_LONGINT:C283($loop_L)
Case of 
	: ((Type:C295($Array_ptr->)=Integer array:K8:18) | (Type:C295($Array_ptr->)=LongInt array:K8:19)\
		 | (Type:C295($Array_ptr->)=Real array:K8:17))
		ARRAY TEXT:C222($List_atxt; Size of array:C274($Array_ptr->))
		For ($loop_L; 1; Size of array:C274($List_atxt))
			
			If ($Format_txt#"")
				$List_atxt{$loop_L}:=String:C10($Array_ptr->{$loop_L}; $Format_txt)
			Else 
				$List_atxt{$loop_L}:=String:C10($Array_ptr->{$loop_L})
			End if 
			
		End for 
	: (Type:C295($Array_ptr->)=Date array:K8:20) | (Type:C295($Array_ptr->)=Time array:K8:29)
		ARRAY TEXT:C222($List_atxt; Size of array:C274($Array_ptr->))
		C_LONGINT:C283($Format_L)
		//for date and time format is a longint code
		If ($Format_txt#"")
			$Format_L:=Num:C11($Format_txt)
		End if 
		
		For ($loop_L; 1; Size of array:C274($List_atxt))
			
			If ($Format_txt#"")
				$List_atxt{$loop_L}:=String:C10($Array_ptr->{$loop_L}; $Format_L)
			Else 
				$List_atxt{$loop_L}:=String:C10($Array_ptr->{$loop_L})
			End if 
			
		End for 
		
	: (Type:C295($Array_ptr->)=Boolean array:K8:21)
		ARRAY TEXT:C222($List_atxt; Size of array:C274($Array_ptr->))
		If ($Format_txt#"")
			//get the first two options separated by ;
			C_LONGINT:C283($semi_L)
			$semi_L:=Position:C15(";"; $Format_txt)
			C_TEXT:C284($falsev; $Truev)
			If ($semi_L>0)
				$Truev:=Substring:C12($Format_txt; 1; ($semi_L-1))
				$falsev:=Substring:C12($Format_txt; ($semi_L+1))
			Else 
				$Truev:=$Format_txt
				$falsev:=""
			End if 
		End if 
		For ($loop_L; 1; Size of array:C274($List_atxt))
			
			If ($Format_txt#"")
				$List_atxt{$loop_L}:=Choose:C955($Array_ptr->{$loop_L}; $Truev; $falsev)
			Else 
				$List_atxt{$loop_L}:=String:C10($Array_ptr->{$loop_L})
			End if 
			
		End for 
		
	: ((Type:C295($Array_ptr->)=String array:K8:15) | (Type:C295($Array_ptr->)=Text array:K8:16))
		ARRAY TEXT:C222($List_atxt; Size of array:C274($Array_ptr->))
		For ($loop_L; 1; Size of array:C274($List_atxt))
			$List_atxt{$loop_L}:=$Array_ptr->{$loop_L}
		End for 
		
End case 
If (Size of array:C274($List_atxt)>0)
	$MyText_txt:=$Prefix_txt+$List_atxt{1}
	For ($loop_L; 2; Size of array:C274($List_atxt))
		$MyText_txt:=$MyText_txt+$Delimiter_txt+$Prefix_txt+$List_atxt{$loop_L}
	End for 
	
End if 

$0:=$MyText_txt
//End ut_ArrayToText