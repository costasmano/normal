If (False:C215)
	//Object Method: [Cons Inspection];"Cslt Insp In".btnConsInspDel 
	// Modified by: Costas Manousakis-(Designer)-(8/7/14 15:30:36)
	Mods_2014_08_bug
	//  `Moved the Delete Record after the LogDeletion
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete this record?"; "Yes"; "No")
	If (ok=1)
		If (Not:C34(Is new record:C668([Cons Inspection:64])))
			LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Cons Inspection:64]BIN:1; ->[Cons Inspection:64]ConsInspectionID:32; 1)
		End if 
		DELETE RECORD:C58([Cons Inspection:64])
		CANCEL:C270
	End if 
End if 
