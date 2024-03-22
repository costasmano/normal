C_BOOLEAN:C305($customise)
C_TEXT:C284($objectName)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (True:C214)  //   dynamic clock sample
			Self:C308->:=0  // dynamic clock will display current time
		Else   // static clock sample
			Self:C308->:=?09:30:00?  // static clock -> will display 09:30:00
		End if 
End case 

$customise:=False:C215

If ($customise)
	$objectName:=OBJECT Get name:C1087(Object current:K67:2)
	TimePicker LCD SET COLOR($objectName; 0; 0; 200)  // Blue
	TimePicker LCD DISPLAY SECONDS($objectName; False:C215)  // do not display seconds
End if 
