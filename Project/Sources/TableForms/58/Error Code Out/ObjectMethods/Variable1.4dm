//SC vValue on layout [Error Codes];"Error Code Out".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

If (Form event code:C388=On Load:K2:1)
	vValue:=BinErr([Error Codes:58]Err Bit:2)
End if 