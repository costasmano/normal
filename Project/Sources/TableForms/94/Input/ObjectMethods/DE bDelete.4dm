CONFIRM:C162("Delete This Part of the Invoice ?")
If (OK=1)
	DELETE RECORD:C58(Current form table:C627->)
	CANCEL:C270
End if 