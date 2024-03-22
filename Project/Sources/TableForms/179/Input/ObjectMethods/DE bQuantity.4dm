Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=1
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		[PON_ELEM_INSP:179]ELEM_QorP:29:=True:C214
		PON_ELEMINPUTIL("QUANTPERCENT")
End case 

//End Object Method: [PON_ELEM_INSP].Input.bQuantity