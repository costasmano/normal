If (False:C215)
	
	Mods_2004_CM12
	
	
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Clicked:K2:4)
	C_BOOLEAN:C305($vbOldValue; $vbDoChange; $vbItm8CodeNBI)
	$vbOldValue:=Old:C35(Self:C308->)
	$vbItm8CodeNBI:=(Position:C15([Bridge MHD NBIS:1]Item8 BridgeCat:207; "-NBI-634-")>0)
	C_TEXT:C284($msg)
	$vbDoChange:=True:C214
	Case of 
		: (Self:C308->)  //Switch to NBI
			If (Not:C34($vbItm8CodeNBI))
				$msg:="Moving Bridge to the NBI List"
				$msg:=$msg+<>sCR+"while Bridge Category Code ("+[Bridge MHD NBIS:1]Item8 BridgeCat:207+") is a non-NBI type!!"
				$msg:=$msg+<>sCR+<>sCR+"Please Select a proper Bridge Category code first!"
				//ALERT($msg)
				C_TEXT:C284($vsCont; $vsChgFHWA)  // Command Replaced was o_C_STRING length was 15
				C_LONGINT:C283($viPromptRes)  //Command Replaced was o_C_INTEGER
				$viPromptRes:=ut_3Option_Confirm($msg; "Change to NBI"; "Change to 634")
				Case of 
					: ($viPromptRes=1)  //change to NBI
						[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; "NBI"; 13)
						PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
						[Bridge MHD NBIS:1]Item8 BridgeCat:207:="NBI"
						PushChange(1; ->[Bridge MHD NBIS:1]Item8 BridgeCat:207)
						
					: ($viPromptRes=2)  //change to 634
						[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; "634"; 13)
						PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
						[Bridge MHD NBIS:1]Item8 BridgeCat:207:="634"
						PushChange(1; ->[Bridge MHD NBIS:1]Item8 BridgeCat:207)
						
					: ($viPromptRes=3)
						$vbDoChange:=False:C215
						
				End case 
				
				
			End if 
			
		: (Not:C34(Self:C308->))
			If ($vbItm8CodeNBI)
				$msg:="You are Moving this Bridge Record off the NBI List"
				$msg:=$msg+<>sCR+"while the Bridge Category Code ("+[Bridge MHD NBIS:1]Item8 BridgeCat:207+") is an NBI type!!"
				$msg:=$msg+<>sCR+<>sCR+"Please Select a correct Bridge Category code first in the ID input tab!"
				ALERT:C41($msg)
				$vbDoChange:=False:C215
			End if 
			
	End case 
	If ($vbDoChange)
		PushChange(1; Self:C308)
	Else 
		Self:C308->:=$vbOldValue
		REJECT:C38(Self:C308->)
	End if 
End if 