If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(2/16/2006 09:19:02)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(12/11/09 09:57:46)
	Mods_2009_12
	//Added  better descriptions for the prompt.
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($msg_txt; $assgn_txt; $invoice_txt)
	$assgn_txt:=""
	$invoice_txt:=""
	$msg_txt:="Are you sure you want to delete the whole Contract #"+[Contract_Maintenance:97]ContractNo:1+"?"
	C_LONGINT:C283($numAssignements_L; $numInvoices_L; $numTransfers_L)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $numAssignements_L)
	QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $numInvoices_L)
	QUERY:C277([Invoice_Maintenance:95]; [Invoice_Maintenance:95]ContractNo:3=[Contract_Maintenance:97]ContractNo:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($numAssignements_L>0)
		$assgn_txt:=String:C10($numAssignements_L)+" Assignment(s)"
	End if 
	If ($numInvoices_L>0)
		$invoice_txt:=String:C10($numInvoices_L)+" Invoice(s)"
	End if 
	If (($numAssignements_L>0) & ($numInvoices_L>0))
		$msg_txt:=$msg_txt+<>sCR+"It has : "
		If ($numAssignements_L>0)
			$msg_txt:=$msg_txt+<>sCR+$assgn_txt
		End if 
		If ($numInvoices_L>0)
			$msg_txt:=$msg_txt+<>sCR+$invoice_txt
		End if 
		
	End if 
	
	
	CONFIRM:C162($msg_txt; "Yes"; "No")
	If (OK=1)
		ARRAY LONGINT:C221($TempRecNumbers_arr; 0)
		LONGINT ARRAY FROM SELECTION:C647(pfile->; $TempRecNumbers_arr)
		C_LONGINT:C283($CurrentRecNum_L; $CurrRecNumPos_L)
		$CurrentRecNum_L:=Record number:C243(Current form table:C627->)
		$CurrRecNumPos_L:=Find in array:C230($TempRecNumbers_arr; $CurrentRecNum_L)
		DELETE FROM ARRAY:C228($TempRecNumbers_arr; $CurrRecNumPos_L)
		
		DELETE RECORD:C58([Contract_Maintenance:97])
		
		If (False:C215)
			If (Not:C34(Is new record:C668([Contract_Maintenance:97])))
				LogDeletion(->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; ->[Contract_Maintenance:97]ContractID:2; 1)
			End if 
		End if 
		
		CANCEL:C270
		
		CREATE SELECTION FROM ARRAY:C640(pfile->; $TempRecNumbers_arr)
	End if 
End if 