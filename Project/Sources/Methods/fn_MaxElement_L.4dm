//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/26/10, 10:07:47
	// ----------------------------------------------------
	// Method: fn_MaxElement_L
	// Description
	//  ` Return the index of the 'largest/max element of an array.
	//  `Will show and alert if the pointer passed is not a 'comparable' array
	//  `Will return 0 if the array size is 0
	// 
	// Parameters
	// $0 : $MaxElmt_L
	// $1 : $Array_ptr
	// ----------------------------------------------------
	
	Mods_2010_10
End if 
C_LONGINT:C283($0; $MaxElmt_L)
C_POINTER:C301($1; $Array_ptr)
$MaxElmt_L:=0
C_LONGINT:C283($NumElmts_L; $loop_L)
$Array_ptr:=$1
If ((Type:C295($Array_ptr->)=String array:K8:15) | (Type:C295($Array_ptr->)=Text array:K8:16) | (Type:C295($Array_ptr->)=Real array:K8:17) | (Type:C295($Array_ptr->)=Integer array:K8:18) | (Type:C295($Array_ptr->)=LongInt array:K8:19) | (Type:C295($Array_ptr->)=Date array:K8:20))
	$NumElmts_L:=Size of array:C274($Array_ptr->)
	If ($NumElmts_L>0)
		$MaxElmt_L:=1
		For ($loop_L; 2; $NumElmts_L)
			If ($Array_ptr->{$loop_L}>$Array_ptr->{$MaxElmt_L})
				$MaxElmt_L:=$loop_L
			End if 
			
		End for 
		
	End if 
	
Else 
	ALERT:C41("BMS ERROR! : Pointer passed to Method "+Current method name:C684+" is not a pointer to a valid array!")
End if 

$0:=$MaxElmt_L