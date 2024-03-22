If (False:C215)
	
	
	Mods_2004_CM12
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		asElmtSftyPulldwnName:=Find in array:C230(alElmtSftyPulldwnID; [ElementsSafety:29]ElmSafetyID:7)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (alElmtSftyPulldwnID{asElmtSftyPulldwnName}#[ElementsSafety:29]ElmSafetyID:7)
			If (Modified record:C314([ElementsSafety:29]))
				TimeStamp_ut(->[ElementsSafety:29]; ->[ElementsSafety:29]DateCreated:16; ->[ElementsSafety:29]TimeCreated:17; ->[ElementsSafety:29]DateModified:18; ->[ElementsSafety:29]TimeModified:19)
				[ElementsSafety:29]Modified By:14:=Current user:C182
				PushChange(2; ->[ElementsSafety:29]Modified By:14)
				PushChange(2; ->[ElementsSafety:29]DateModified:18)
				PushChange(2; ->[ElementsSafety:29]TimeModified:19)
				
				bElmNotValidated:=False:C215
				//##Save changes made to file
				FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
				
				SAVE RECORD:C53([ElementsSafety:29])
			End if 
			
			GOTO SELECTED RECORD:C245([ElementsSafety:29]; asElmtSftyPulldwnName)
			LOAD RECORD:C52([ElementsSafety:29])
			MODIFY RECORD:C57([ElementsSafety:29])
			CANCEL:C270
		End if 
End case 