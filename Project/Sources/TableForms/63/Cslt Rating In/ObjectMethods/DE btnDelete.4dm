If (False:C215)
	//Object Method: [Conslt Rating]."Cslt Rating In".btnDeleteCRtg 
	// Modified by: Costas Manousakis-(Designer)-(8/8/14 09:43:58)
	Mods_2014_08_bug
	//  `Moved the Delete Record after the LogDeletion
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		If (Not:C34(Is new record:C668([Conslt Rating:63])))
			LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Conslt Rating:63]BIN:1; ->[Conslt Rating:63]ConsltRatingID:42; 1)
		End if 
		DELETE RECORD:C58([Conslt Rating:63])
		CANCEL:C270
	End if 
End if 