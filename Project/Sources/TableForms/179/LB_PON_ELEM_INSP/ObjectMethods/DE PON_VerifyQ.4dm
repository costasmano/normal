C_TEXT:C284($ErrMsg_txt)
$ErrMsg_txt:=PON_VerifyNBEQuantities
If ($ErrMsg_txt#"")
	ut_BigAlert($ErrMsg_txt)
Else 
	ALERT:C41("No Quantity Errors found!")
End if 