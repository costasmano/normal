//%attributes = {"invisible":true}
// Method: SIA_Item8Category_OM
// Description
// Created to be called from two forms
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/22/09, 09:00:47
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: Costas Manousakis-(Designer)-(8/19/13 17:16:42)
	Mods_2013_08
	//  `use element 0 to display the  "Select...." prompt
	// Modified by: Costas Manousakis-(Designer)-(5/29/18 11:38:04)
	Mods_2018_05
	//  `removed reference to vIt8BrCatDes
	
End if 

//C_TEXT(vIt8BrCatDes)// Command Replaced was o_C_STRING length was 60

REDRAW:C174(aIt8BrCatDes_)
Case of 
	: ((Form event code:C388=On Load:K2:1) | (aIt8BrCatDes_=0))
		aIt8BrCatDes_:=Find in array:C230(aIt8BrCatCode_; Substring:C12([Bridge MHD NBIS:1]Item8:206; 13; 3))
		If (aIt8BrCatDes_<=0)  //Just in case nothing was found in array
			aIt8BrCatDes_:=0
			//vIt8BrCatDes:="Select Bridge Category..."
			aIt8BrCatDes_{0}:="Select Bridge Category..."
		Else 
			//vIt8BrCatDes:=aIt8BrCatDes_{aIt8BrCatDes_}
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($vsNewCode)  // Command Replaced was o_C_STRING length was 3
		C_BOOLEAN:C305($vbChangeItem8; $vbChangeFHWA; $vbChangeFHWA_to)
		
		$vsNewCode:=aIt8BrCatCode_{aIt8BrCatDes_}
		$vbChangeItem8:=True:C214
		$vbChangeFHWA:=False:C215
		C_TEXT:C284($msg)
		C_TEXT:C284($vsCont; $vsChgFHWA)  // Command Replaced was o_C_STRING length was 15
		C_LONGINT:C283($viPromptRes)  //Command Replaced was o_C_INTEGER
		$vsCont:="Continue"
		
		Case of 
			: (($vsNewCode="NBI") | ($vsNewCode="634"))
				//switcing to NBI type 
				If (Not:C34([Bridge MHD NBIS:1]FHWARecord:174))
					$msg:="Switching Bridge Category Code to an NBI Category Type"
					$msg:=$msg+<>sCR+"while Bridge Record is not on NBI List!!"
					$msg:=$msg+<>sCR+<>sCR+"Continue only with the Item8 Change, or"
					$msg:=$msg+<>sCR+"Put Bridge Record on the NBI List also?"
					//$msg:=Uppercase($msg)
					$vsChgFHWA:="Put on NBI"
					$viPromptRes:=ut_3Option_Confirm($msg; $vsCont; $vsChgFHWA)
					$vbChangeItem8:=($viPromptRes#3)  //cancel is 3
					If ($viPromptRes=2)
						$vbChangeFHWA:=True:C214
						$vbChangeFHWA_to:=True:C214
					End if 
					
				End if 
				
			: (($vsNewCode#"NBI") & ($vsNewCode#"634"))
				If ([Bridge MHD NBIS:1]FHWARecord:174)
					$msg:="Switching Bridge Category Code to a non-NBI category Type"
					$msg:=$msg+<>sCR+"while Bridge Record is on the NBI List!"
					$msg:=$msg+<>sCR+<>sCR+"Continue only with the Item8 Change, or"
					$msg:=$msg+<>sCR+"Take Record off the NBI List also?"
					
					$vsChgFHWA:="Take off NBI"
					$viPromptRes:=ut_3Option_Confirm($msg; $vsCont; $vsChgFHWA)
					$vbChangeItem8:=($viPromptRes#3)  //cancel is 3
					If ($viPromptRes=2)
						$vbChangeFHWA:=True:C214
						$vbChangeFHWA_to:=False:C215
					End if 
				End if 
				
		End case 
		
		If ($vbChangeItem8)
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; aIt8BrCatCode_{aIt8BrCatDes_}; 13)
			PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
			
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BDEPT:1; 1)
			PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
			
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BIN:3; 7)
			PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
			
			[Bridge MHD NBIS:1]Item8 BridgeCat:207:=aIt8BrCatCode_{aIt8BrCatDes_}
			PushChange(1; ->[Bridge MHD NBIS:1]Item8 BridgeCat:207)
			
			//vIt8BrCatDes:=aIt8BrCatDes_{aIt8BrCatDes_}
		Else 
			//Leave array the way it was
			aIt8BrCatDes_:=Find in array:C230(aIt8BrCatCode_; Substring:C12([Bridge MHD NBIS:1]Item8:206; 13; 3))
			REDRAW:C174(aIt8BrCatDes_)
		End if 
		If ($vbChangeFHWA)
			[Bridge MHD NBIS:1]FHWARecord:174:=$vbChangeFHWA_to
			PushChange(1; ->[Bridge MHD NBIS:1]FHWARecord:174)
		End if 
		
End case 