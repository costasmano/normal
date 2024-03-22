If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Sure"; "Cancel")
	If (OK=1)
		If (ZSPRPT_LogActivity_b)
			If (Not:C34(Is new record:C668([zSpecialReports:106])))
				LogDeletion(->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; 0)
			End if 
		End if 
		DELETE RECORD:C58([zSpecialReports:106])
		CANCEL:C270
	End if 
End if 