//%attributes = {"invisible":true}
//procedure: PushChange
//purpose: when a change is made this gets put on the stack
//$1 is the level of the change (which layout)
//$2 pointer to the field that was changed
If (False:C215)
	//by: Albert Leung
	//created: 1/29/97
	
	//Modified: 6/20/97 by Tom Nee
	//Don't duplicate this field if it's already in the array of changed fields.
End if 

C_LONGINT:C283($1; $level; $elements)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($2; $change)

$level:=$1
$change:=$2

If (Type:C295(ptr_changes)=Array 2D:K8:24)  //avoid unecessary errors...
	$elements:=Size of array:C274(ptr_Changes{$level})+1
	
	If (Find in array:C230(ptr_Changes{$level}; $change)<0)  //First, check if this field is already in the array of changes.
		//This field is NOT in the array of changes, so add it.  
		INSERT IN ARRAY:C227(ptr_Changes{$level}; $elements; 1)
		ptr_Changes{$level}{$elements}:=$change
	End if 
End if 