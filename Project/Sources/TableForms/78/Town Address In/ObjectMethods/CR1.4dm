
Case of 
	: (Form event code:C388=On Mouse Enter:K2:33) | (Form event code:C388=On Mouse Leave:K2:34)
		ut_GenericHelp_OM("Add a line to the Street field")
		
	: (Form event code:C388=On Clicked:K2:4)
		[Town Address:78]Street:5:=[Town Address:78]Street:5+"\r"
		GOTO OBJECT:C206([Town Address:78]Street:5)
		POST KEY:C465(Right arrow key:K12:17)
End case 
