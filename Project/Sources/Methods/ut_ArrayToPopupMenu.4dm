//%attributes = {"invisible":true}
//Method: ut_ArrayToPopupMenu
//Description
//  convert an array to a string to be used in the Pop up menu command
// Parameters
//$0 : $popupmenu_txt
// $1 : $Array_ptr
// $2 : $Format_txt : optional
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/01/15, 13:29:12
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
	
	C_TEXT:C284(ut_ArrayToPopupMenu; $0)
	C_POINTER:C301(ut_ArrayToPopupMenu; $1)
	C_TEXT:C284(ut_ArrayToPopupMenu; $2)
End if 
//

C_TEXT:C284($0)
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284($popupmenu_txt)
C_POINTER:C301($Array_ptr)
$Array_ptr:=$1
$popupmenu_txt:=""
ARRAY TEXT:C222($List_atxt; 0)
Case of 
	: ((Type:C295($Array_ptr->)=Date array:K8:20) | (Type:C295($Array_ptr->)=Integer array:K8:18) | (Type:C295($Array_ptr->)=LongInt array:K8:19) | (Type:C295($Array_ptr->)=Real array:K8:17))
		ARRAY TEXT:C222($List_atxt; Size of array:C274($Array_ptr->))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($List_atxt))
			$List_atxt{$loop_L}:=String:C10($Array_ptr->{$loop_L})
		End for 
		
	: ((Type:C295($Array_ptr->)=String array:K8:15) | (Type:C295($Array_ptr->)=Text array:K8:16))
		ARRAY TEXT:C222($List_atxt; Size of array:C274($Array_ptr->))
		For ($loop_L; 1; Size of array:C274($List_atxt))
			$List_atxt{$loop_L}:=$Array_ptr->{$loop_L}
		End for 
		
End case 
If (Size of array:C274($List_atxt)>0)
	$popupmenu_txt:=Char:C90(1)+$List_atxt{1}
	For ($loop_L; 2; Size of array:C274($List_atxt))
		$popupmenu_txt:=$popupmenu_txt+";"+Char:C90(1)+$List_atxt{$loop_L}
	End for 
	
End if 

$0:=$popupmenu_txt
//End ut_ArrayToPopupMenu