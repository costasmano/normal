//%attributes = {"invisible":true}
//Method: mail_ValidateEmail
//Description
//  ` Validate an email address using regex. 
// Parameters
// $0 : $EmailGood_b
// $1 : $EmlAddr_txt
// $2 : $Username_ptr (optional)
// $3 : $Domain_ptr (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	// Date and time: 04/10/13, 08:03:35
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
C_BOOLEAN:C305($0; $EmailGood_b)
C_TEXT:C284($1)

C_TEXT:C284($ml_txt)
C_TEXT:C284($MLPat_txt)
C_TEXT:C284($domain_txt)

//(?i) : caseinsensitive search
//^ : beginning of string $ : end of string

$MLPat_txt:="(?i)^([A-Z0-9._%+-]+)@([A-Z0-9.-]+\\.[A-Z]{2,4})$"
$EmailGood_b:=False:C215
$ml_txt:=$1
ARRAY LONGINT:C221($pos_aL; 0)
ARRAY LONGINT:C221($Len_aL; 0)
C_BOOLEAN:C305($EmailGood_b)
$EmailGood_b:=Match regex:C1019($MLPat_txt; $ml_txt; 1; $pos_aL; $Len_aL)
If ($EmailGood_b)
	ARRAY TEXT:C222($parts_atxt; Size of array:C274($pos_aL))
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($parts_atxt))
		$parts_atxt{$loop_L}:=Substring:C12($ml_txt; $pos_aL{$loop_L}; $Len_aL{$loop_L})
	End for 
	$domain_txt:=$parts_atxt{2}
	For ($loop_L; 3; Size of array:C274($parts_atxt))
		$domain_txt:=$domain_txt+"."+$parts_atxt{$loop_L}
	End for 
	
	If (Count parameters:C259>1)
		C_POINTER:C301($2; $Domain_ptr)
		$Domain_ptr:=$2
		$Domain_ptr->:=$domain_txt
	End if 
	If (Count parameters:C259>2)
		C_POINTER:C301($3; $Username_ptr)
		$Username_ptr:=$3
		$Username_ptr->:=$parts_atxt{1}
	End if 
	
End if 

$0:=$EmailGood_b
//End mail_ValidateEmail