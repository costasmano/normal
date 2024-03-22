//%attributes = {"invisible":true}
If (False:C215)
	//procedure: InitChangeStack
	//by: Albert Leung
	//created: 1/29/97
	//purpose: use this array to store changes
	// Modified by: Costas Manousakis-(Designer)-(6/22/17 11:53:58)
	Mods_2017_06_bug
	//  `insert in array the difference between the level requested to the current size of the ptr_changes array
	//  `also initialize ptr_changes if it is not
End if 

C_LONGINT:C283($1; $level)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($size)  //Command Replaced was o_C_INTEGER
If (Type:C295(ptr_Changes)=Is undefined:K8:13)
	
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	
End if 

$level:=$1
$size:=Size of array:C274(ptr_Changes)

If ($size<$level)
	INSERT IN ARRAY:C227(ptr_Changes; $size+1; $level-$size)
End if 
ARRAY POINTER:C280(ptr_Changes{$level}; 0)