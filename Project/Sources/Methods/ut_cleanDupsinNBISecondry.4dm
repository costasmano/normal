//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/26/11, 08:45:41
	// ----------------------------------------------------
	// Method: ut_cleanDupsinNBISecondry
	// Description
	//  ` clean duplicate records in NBIS Secondary
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_10
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	CONFIRM:C162("You are about to delete duplicates in the [NBIS Secondary] table! Continue?"; "Continue"; "Cancel")
	If (OK=1)
		
		ALL RECORDS:C47([NBIS Secondary:3])
		C_LONGINT:C283($recs_L)
		$recs_L:=Records in selection:C76([NBIS Secondary:3])
		ARRAY TEXT:C222($BINs_atxt; $recs_L)
		ARRAY TEXT:C222($Item5s_atxt; $recs_L)
		ARRAY LONGINT:C221($RecNos_aL; $recs_L)
		SELECTION TO ARRAY:C260([NBIS Secondary:3]; $RecNos_aL; [NBIS Secondary:3]BIN:1; $BINs_atxt; [NBIS Secondary:3]Item5:4; $Item5s_atxt)
		ARRAY LONGINT:C221($Dups_aL; 0)
		
		C_LONGINT:C283($loop_L; $Find_L)
		For ($loop_L; 1; Size of array:C274($RecNos_aL))
			$BINs_atxt{$loop_L}:=$BINs_atxt{$loop_L}+$Item5s_atxt{$loop_L}
		End for 
		For ($loop_L; 1; (Size of array:C274($RecNos_aL)-1))
			$Find_L:=Find in array:C230($BINs_atxt; $BINs_atxt{$loop_L}; ($loop_L+1))
			If ($Find_L>0)
				APPEND TO ARRAY:C911($Dups_aL; $RecNos_aL{$loop_L})
			End if 
			
		End for 
		
		CREATE SELECTION FROM ARRAY:C640([NBIS Secondary:3]; $Dups_aL; "DuplicateSecondary")
		
		USE NAMED SELECTION:C332("DuplicateSecondary")
		CLEAR NAMED SELECTION:C333("DuplicateSecondary")
		If (Records in selection:C76([NBIS Secondary:3])>0)
			CONFIRM:C162("Ready to delete "+String:C10(Records in selection:C76([NBIS Secondary:3]))+" records in [NBIS Secondary] table?")
			If (Ok=1)
				DELETE SELECTION:C66([NBIS Secondary:3])
			End if 
			
		End if 
		
	End if 
	
End if 