Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TIME:C306($FilePicked)
		$FilePicked:=Open document:C264(""; "TEXT")
		If (OK=1)
			Self:C308->:=Document
		End if 
		
End case 
