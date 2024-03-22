If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/16/2006 09:19:02)
	Mods_2006_CM03
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to Delete this Contract Record?"; "DELETE"; "NO")
	If (OK=0)
		ARRAY LONGINT:C221($TempRecNumbers_arr; 0)
		LONGINT ARRAY FROM SELECTION:C647(pfile->; $TempRecNumbers_arr)
		C_LONGINT:C283($CurrentRecNum_L; $CurrRecNumPos_L)
		$CurrentRecNum_L:=Record number:C243(Current form table:C627->)
		$CurrRecNumPos_L:=Find in array:C230($TempRecNumbers_arr; $CurrentRecNum_L)
		DELETE FROM ARRAY:C228($TempRecNumbers_arr; $CurrRecNumPos_L)
		
		DELETE RECORD:C58([DCM_Contracts:136])
		
		If (False:C215)
			If (Not:C34(Is new record:C668([DCM_Contracts:136])))
				LogDeletion(->[DCM_Contracts:136]ContractID:2; ->[DCM_Contracts:136]ContractID:2; ->[DCM_Contracts:136]ContractID:2; 1)
			End if 
		End if 
		
		ACCEPT:C269
		
		CREATE SELECTION FROM ARRAY:C640(pfile->; $TempRecNumbers_arr)
	End if 
End if 