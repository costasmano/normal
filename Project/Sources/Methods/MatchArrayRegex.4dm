//%attributes = {"invisible":true}
//Method: MatchArrayRegex
//Description
// find in array a regex pattern
// Parameters
// $0 : $Array_Pos_L 
// $1 : $TextArr_ptr
// $2 : $RegexPattern_txt
// $3 : $StartPos_L (optional)
// $4 : $RegexStartPos_L (optional)

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/10/18, 10:40:04
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
	
	C_LONGINT:C283(MatchArrayRegex; $0)
	C_POINTER:C301(MatchArrayRegex; $1)
	C_TEXT:C284(MatchArrayRegex; $2)
	C_LONGINT:C283(MatchArrayRegex; $3)
	C_LONGINT:C283(MatchArrayRegex; $4)
	
End if 
//

C_LONGINT:C283($0; $Array_Pos_L)
$Array_Pos_L:=-1

C_POINTER:C301($1; $TextArr_ptr)
$TextArr_ptr:=$1

C_TEXT:C284($RegexPattern_txt; $2)
$RegexPattern_txt:=$2

C_LONGINT:C283($StartPos_L)
$StartPos_L:=1
If (Count parameters:C259>2)
	C_LONGINT:C283($3)
	$StartPos_L:=$3
End if 

C_LONGINT:C283($RegexStartPos_L)
$RegexStartPos_L:=1
If (Count parameters:C259>3)
	C_LONGINT:C283($4)
	$RegexStartPos_L:=$4
End if 
C_BOOLEAN:C305($assertOn_b)

Case of 
	: (Type:C295($TextArr_ptr->)#Text array:K8:16) & (Type:C295($TextArr_ptr->)#String array:K8:15)
		C_LONGINT:C283($TableNum_L; $FieldNum_L)
		C_TEXT:C284($VarName_txt)
		RESOLVE POINTER:C394($TextArr_ptr; $VarName_txt; $TableNum_L; $FieldNum_L)
		If ($TableNum_L>0)
			$VarName_txt:=" Field ["+Table name:C256($TableNum_L)+"]"+Field name:C257($TableNum_L; $FieldNum_L)
		Else 
			$VarName_txt:="Variable "+$VarName_txt
		End if 
		ALERT:C41("Error in MatchArrayRegex! Received Pointer to "+$VarName_txt+" which is not to Text or String array!")
	: (Size of array:C274($TextArr_ptr->)=0)
	: ($StartPos_L<0)
	: (Size of array:C274($TextArr_ptr->)<$StartPos_L)
	Else 
		C_LONGINT:C283($loop_L)
		C_BOOLEAN:C305($match_b)
		
		For ($loop_L; $StartPos_L; Size of array:C274($TextArr_ptr->))
			$match_b:=Match regex:C1019($RegexPattern_txt; $TextArr_ptr->{$loop_L}; $RegexStartPos_L)
			If ($match_b)
				$Array_Pos_L:=$loop_L
				$loop_L:=Size of array:C274($TextArr_ptr->)+1
			End if 
			
		End for 
		
End case 

$0:=$Array_Pos_L
//End MatchArrayRegex