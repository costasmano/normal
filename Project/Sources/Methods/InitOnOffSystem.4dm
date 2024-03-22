//%attributes = {"invisible":true}
If (False:C215)
	//procedure: InitOnOffSystem
	//purpose: set the Boolean fields for On and OffSystem
	//created: 1/10/98
	//by: Albert Leung
	
	ARRAY TEXT:C222($aItem26; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY BOOLEAN:C223($aOn; 0)
	C_LONGINT:C283($i)
	
	MessageNM("Loading Item 26…")
	
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item26:120; $aItem26)
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]OnSystem:138; $aOn)
	For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
		$aOn{$i}:=(Position:C15($aItem26{$i}; ".08.09.19.")<1)
	End for 
	
	CLOSE WINDOW:C154
	MessageNM("Saving changes…")
	
	START TRANSACTION:C239
	
	ARRAY TO SELECTION:C261($aOn; [Bridge MHD NBIS:1]OnSystem:138)
	
	CLOSE WINDOW:C154
	
	If (Records in set:C195("LockedSet")=0)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
		ALERT:C41("Some records were in use. Changes not saved!")
	End if 
End if 
If (False:C215)
	If (False:C215)
		// ----------------------------------------------------
		// User name (OS): costasmanousakis
		// User name (4D): Designer
		// Date and time: 03/30/06, 12:07:11
		// ----------------------------------------------------
		// Method: InitOnOffSystem
		// Description
		// 
		// 
		// Parameters
		// ----------------------------------------------------
		
	End if 
	
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	MessageNM("Updating On Off Records …")
	While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
		Case of 
			: (QR_Item26OnOff="ON")
				If (Not:C34([Bridge MHD NBIS:1]OnSystem:138))
					ut_LoadRecord(->[Bridge MHD NBIS:1])
					[Bridge MHD NBIS:1]OnSystem:138:=True:C214
					LogChanges(->[Bridge MHD NBIS:1]OnSystem:138; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
					SAVE RECORD:C53([Bridge MHD NBIS:1])
					MESSAGE:C88("BIN "+[Bridge MHD NBIS:1]BIN:3+" to On"+<>sCR)
					UNLOAD RECORD:C212([Bridge MHD NBIS:1])
				End if 
				
			: (QR_Item26OnOff="OFF")
				If ([Bridge MHD NBIS:1]OnSystem:138)
					ut_LoadRecord(->[Bridge MHD NBIS:1])
					[Bridge MHD NBIS:1]OnSystem:138:=False:C215
					LogChanges(->[Bridge MHD NBIS:1]OnSystem:138; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
					SAVE RECORD:C53([Bridge MHD NBIS:1])
					MESSAGE:C88("BIN "+[Bridge MHD NBIS:1]BIN:3+" to Off"+<>sCR)
					UNLOAD RECORD:C212([Bridge MHD NBIS:1])
				End if 
				
		End case 
		
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End while 
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
	
	CLOSE WINDOW:C154
End if 
