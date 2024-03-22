//%attributes = {"invisible":true}
C_TIME:C306($dImportFile)
C_TEXT:C284($tBuffer)
C_LONGINT:C283($acounter)

//close the input file
//CLOSE DOCUMENT($dImportFile)
$dImportFile:=Open document:C264(""; "TEXT")  //prompt user for input file
C_LONGINT:C283($recNum)  //Command Replaced was o_C_INTEGER

If (OK=1)
	$acounter:=1
	$recNum:=1
	While ($recNum<441)
		RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
		Case of 
			: ($acounter=1)
				CREATE RECORD:C68([Town Address:78])
				InitChangeStack(1)
				
				[Town Address:78]AddressedTo:3:=$tBuffer
				PushChange(1; ->[Town Address:78]AddressedTo:3)
				
			: ($acounter=2)
				[Town Address:78]Street:5:=$tBuffer
				PushChange(1; ->[Town Address:78]Street:5)
				
			: ($acounter=3)
				[Town Address:78]TownName:2:=$tBuffer
				PushChange(1; ->[Town Address:78]TownName:2)
				
				[Town Address:78]OfficialTownName:4:="Town of "+$tBuffer
				PushChange(1; ->[Town Address:78]OfficialTownName:4)
				
			: ($acounter=4)
				[Town Address:78]State:6:="MA"
				PushChange(1; ->[Town Address:78]State:6)
				
			: ($acounter=5)
				[Town Address:78]Zip:7:=$tBuffer
				PushChange(1; ->[Town Address:78]Zip:7)
				
			: ($acounter=6)
				[Town Address:78]ContactFName:8:=$tBuffer
				PushChange(1; ->[Town Address:78]ContactFName:8)
				
			: ($acounter=7)
				[Town Address:78]ContactLName:9:=$tBuffer
				PushChange(1; ->[Town Address:78]ContactLName:9)
				
			: ($acounter=8)
				[Town Address:78]ContactTitle:11:=$tBuffer
				PushChange(1; ->[Town Address:78]ContactTitle:11)
				Inc_Sequence("TownAddress"; ->[Town Address:78]TownAddressID:1)
				SAVE RECORD:C53([Town Address:78])
				LogNewRecord(->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; 4; "TownAddress")
				FlushGrpChgs(1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; ->[Town Address:78]TownAddressID:1; 1)
				$acounter:=0
		End case 
		$acounter:=$acounter+1
		$recNum:=$recNum+1
	End while 
	
	//close the input file
	CLOSE DOCUMENT:C267($dImportFile)
End if 