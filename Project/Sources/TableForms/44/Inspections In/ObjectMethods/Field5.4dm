//SC [BMS Inspections]Insp Date on layout [BMS Inspections];"Inspections In".
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		If ([BMS Inspections:44]Inspection ID:1=0)
			//This is a new record.    
			[BMS Inspections:44]Insp Date:4:=Current date:C33(*)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
		Case of 
			: ([BMS Inspections:44]Insp Date:4>Current date:C33(*))
				ALERT:C41("The date "+String:C10([BMS Inspections:44]Insp Date:4)+" is in the future."+<>sCR+"Please correct it.")
				GOTO OBJECT:C206([BMS Inspections:44]Insp Date:4)
			: ([BMS Inspections:44]Insp Date:4<!1992-01-01!)
				ALERT:C41("The date "+String:C10([BMS Inspections:44]Insp Date:4)+" is too old."+<>sCR+"Please correct it.")
				GOTO OBJECT:C206([BMS Inspections:44]Insp Date:4)
			Else 
				PushChange(1; ->[BMS Inspections:44]Insp Date:4)
		End case 
End case 