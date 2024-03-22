//[Bridge MHD NBIS]Item56

C_REAL:C285(i56save)
C_TEXT:C284($CR)  // Command Replaced was o_C_STRING length was 1

$CR:=Char:C90(13)
Case of 
	: (Form event code:C388=On Load:K2:1)
		i56save:=[Bridge MHD NBIS:1]Item56:112
	: (Form event code:C388=On Data Change:K2:15)
		If (([Bridge MHD NBIS:1]Item56:112=99.9) | ([Bridge MHD NBIS:1]Item56:112=99.8) | ([Bridge MHD NBIS:1]Item56:112<=0))
			ALERT:C41("Please put in a value less than 99.8 and"+$CR+"greater than 00.0 for a valid left lateral underclearance!")
			[Bridge MHD NBIS:1]Item56:112:=i56save
		Else 
			uItem56a:=0
			uItem56b:=0
			uItem56c:=0
			uItem56d:=1
		End if 
		PushChange(1; Self:C308)
End case 