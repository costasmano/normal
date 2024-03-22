//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/15, 12:41:45
//----------------------------------------------------
//Method: ut_TruncateActivityLogInTest
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/16/15 12:41:52)
	
End if 

If (Not:C34(Is compiled mode:C492))
	C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
	C_LONGINT:C283($TableNumber_l; $FieldLoop_L; $Type_l; $Length_l)
	$TableNumber_l:=Table:C252(->[Activity Log:59])
	ARRAY LONGINT:C221($IndexedFields_AL; 0)
	For ($FieldLoop_l; 1; Get last field number:C255($TableNumber_l))
		
		GET FIELD PROPERTIES:C258($TableNumber_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		If ($Indexed_b)
			APPEND TO ARRAY:C911($IndexedFields_AL; $FieldLoop_l)
			
			
		End if 
		
	End for 
	
	CONFIRM:C162("Are you sure you want to truncate [Activity Log] table?")
	If (OK=1)
		C_POINTER:C301($Field_ptr)
		For ($FieldLoop_l; 1; Size of array:C274($IndexedFields_AL))
			$Field_ptr:=Field:C253($TableNumber_l; $IndexedFields_AL{$FieldLoop_l})
			SET INDEX:C344($Field_ptr->; False:C215; *)
		End for 
		READ WRITE:C146([Activity Log:59])
		TRUNCATE TABLE:C1051([Activity Log:59])
		For ($FieldLoop_l; 1; Size of array:C274($IndexedFields_AL))
			$Field_ptr:=Field:C253($TableNumber_l; $IndexedFields_AL{$FieldLoop_l})
			SET INDEX:C344($Field_ptr->; True:C214; *)
		End for 
		
	End if 
Else 
	
	
	ALERT:C41("You can not run this method in a compiled DB")
End if 
//End ut_TruncateActivityLogInTest

