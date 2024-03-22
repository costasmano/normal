If (False:C215)
	Mods_2005_CM06
	Mods_2011_06  // CJ Miller`06/20/11, 11:32:59      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (aBMS_Descr#Size of array:C274(aBMS_Descr))
			C_LONGINT:C283($NewID; $MYID)
			$NewID:=aBMS_IDs{aBMS_Descr}
			If ([Combined Inspections:90]BMSInspID:3#$NewID)
				//Now find the old comb inpection 
				$MYID:=[Combined Inspections:90]ID:6
				C_BOOLEAN:C305($vbDoSwitch)
				$vbDoSwitch:=False:C215
				COPY NAMED SELECTION:C331([Combined Inspections:90]; "CombinedsBefore")
				PUSH RECORD:C176([Combined Inspections:90])
				
				QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BMSInspID:3=$NewID; *)
				QUERY:C277([Combined Inspections:90];  & ; [Combined Inspections:90]ID:6#$MYID)
				Case of 
					: (Records in selection:C76([Combined Inspections:90])=1)
						LOAD RECORD:C52([Combined Inspections:90])
						If ([Combined Inspections:90]InspType:5#"PON")
							//Not a Pontis            
							CONFIRM:C162("Other NBI inspection ID :"+String:C10([Combined Inspections:90]NBISInspID:2)+" Has link to this Pontis. Do switch?")
							If (OK=1)
								[Combined Inspections:90]BMSInspID:3:=-1
								LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
								$vbDoSwitch:=True:C214
							End if 
							
						Else 
							//just another Pontis inspection -> delete it
							QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
							If (Records in selection:C76([Inspections:27])=1)
								LOAD RECORD:C52([Inspections:27])
								LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
								DELETE RECORD:C58([Inspections:27])
							End if 
							LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
							DELETE RECORD:C58([Combined Inspections:90])
							$vbDoSwitch:=True:C214
						End if 
					: (Records in selection:C76([Combined Inspections:90])=0)
						$vbDoSwitch:=True:C214
					Else 
						ALERT:C41("Multiple Other Combined for same BMS Insp ID :"+String:C10($NewID))
				End case 
				
				USE NAMED SELECTION:C332("CombinedsBefore")
				CLEAR NAMED SELECTION:C333("CombinedsBefore")
				POP RECORD:C177([Combined Inspections:90])
				LOAD RECORD:C52([Combined Inspections:90])
				If ($vbDoSwitch)
					[Combined Inspections:90]BMSInspID:3:=$NewID
					LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
					SAVE RECORD:C53([Combined Inspections:90])
				End if 
			End if 
		End if 
End case 