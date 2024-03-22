//%attributes = {"invisible":true}
If (False:C215)
	//Temp_FixFileIDRes
	//fix the FileIDRes table to
	//Will have to make sure do it only once- by adding a record in FileIDRes table 
	//data :  Destination:="Table has been fixed"; FileNumber:=1
	If (Records in table:C83([FileIDRes Table:60])>0)
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4="Table has been fixed")
		If (Records in selection:C76([FileIDRes Table:60])=0)
			//has not been fixed yet
			ALL RECORDS:C47([FileIDRes Table:60])
			C_LONGINT:C283($vlNrecs; $i; $k)
			$vlNrecs:=Records in selection:C76([FileIDRes Table:60])
			ARRAY LONGINT:C221($alTno; $vlNrecs)
			ARRAY TEXT:C222($asLID; $vlNrecs)  //Command Replaced was o_ARRAY string length was 80
			ARRAY TEXT:C222($asDID; $vlNrecs)  //Command Replaced was o_ARRAY string length was 80
			ARRAY TEXT:C222($asDest; $vlNrecs)  //Command Replaced was o_ARRAY string length was 80
			ARRAY TEXT:C222($asIDCheck; $vlNrecs)  //Command Replaced was o_ARRAY string length was 250
			C_TEXT:C284($vsIDCheck)  // Command Replaced was o_C_STRING length was 250
			C_TEXT:C284($vsNewDest)  // Command Replaced was o_C_STRING length was 80
			SELECTION TO ARRAY:C260([FileIDRes Table:60]File Number:1; $alTno; [FileIDRes Table:60]Local ID:2; $asLID; [FileIDRes Table:60]Destination ID:3; $asDID; [FileIDRes Table:60]Destination:4; $asDest)
			For ($i; 1; $vlNrecs)
				$asIDCheck{$i}:=String:C10($alTno{$i}; "0000000")+"-"+$asLID{$i}+"-"+$asDest{$i}
			End for 
			For ($i; 1; $vlNrecs)
				If ($asDest{$i}="Here")
					//dest was here -add one for server
					$vsNewDest:=<>Destination
				Else 
					//dest was server - add one for here      
					$vsNewDest:="Here"
				End if 
				$vsIDCheck:=String:C10($alTno{$i}; "0000000")+"-"+$asDID{$i}+"-"+$vsNewDest
				$k:=Find in array:C230($asIDCheck; $vsIDCheck)
				If ($k=-1)  //make sure there is not another one
					CREATE RECORD:C68([FileIDRes Table:60])
					[FileIDRes Table:60]File Number:1:=$alTno{$i}
					[FileIDRes Table:60]Local ID:2:=$asDID{$i}
					[FileIDRes Table:60]Destination ID:3:=$asLID{$i}
					[FileIDRes Table:60]Destination:4:=$vsNewDest
					SAVE RECORD:C53([FileIDRes Table:60])
				End if 
				
			End for 
			
			//done- mark we did it  
			CREATE RECORD:C68([FileIDRes Table:60])
			[FileIDRes Table:60]File Number:1:=1
			[FileIDRes Table:60]Destination:4:="Table has been fixed"
			SAVE RECORD:C53([FileIDRes Table:60])
			UNLOAD RECORD:C212([FileIDRes Table:60])
			//FLUSH CACHE  //save things
			REDUCE SELECTION:C351([FileIDRes Table:60]; 0)
		End if 
	End if 
End if 
