If (False:C215)
	//Object Method: [LSS_Inventory].CustomSearch.LSS_SearchTwnCode_txt 
	// Modified by: Costas Manousakis-(Designer)-(1/28/16 21:03:04)
	Mods_2016_01_bug
	//  `replaced use of LSS_Townname_atxt , etc with global variables aTownName_, ◊aBDEPT, ◊aDistrict
End if 

C_LONGINT:C283($twnindx_L; $subtwnIndx_L)
LSS_SearchTwnCode_txt:=Replace string:C233(LSS_SearchTwnCode_txt; "_"; "")

Case of 
	: (Length:C16(LSS_SearchTwnCode_txt)=3)
		
		$twnindx_L:=Find in array:C230(<>aBDEPT; LSS_SearchTwnCode_txt)
		If ($twnindx_L>0)
			$subtwnIndx_L:=Find in array:C230(aTownName_; <>aTownName{$twnindx_L})
			If ($subtwnIndx_L>0)
				aTownName_:=$subtwnIndx_L
				LSS_SearchDistr_aL:=1+Num:C11(<>aDistrict{$twnindx_L})
			Else 
				C_TEXT:C284($msg_txt)
				$msg_txt:="Town "+<>aTownName{$twnindx_L}+" ("+LSS_SearchTwnCode_txt+") not in current selected district "+String:C10(LSS_SearchDistr_aL{LSS_SearchDistr_aL})
				$msg_txt:=$msg_txt+".   Continue?"
				CONFIRM:C162($msg_txt; "Continue"; "Cancel")
				If (OK=1)
					//switch to new district
					LSS_SearchDistr_aL:=1+Num:C11(<>aDistrict{$twnindx_L})
					//now we have to repopulate aTownName_ with towns from that district
					ARRAY TEXT:C222(aTownName_; 0)  //Command Replaced was o_ARRAY string length was 20
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274(<>aTownName))
						If (Num:C11(<>aDistrict{$loop_L})=LSS_SearchDistr_aL{LSS_SearchDistr_aL})
							APPEND TO ARRAY:C911(aTownName_; <>aTownName{$loop_L})
						End if 
					End for 
					$subtwnIndx_L:=Find in array:C230(aTownName_; <>aTownName{$twnindx_L})
					aTownName_:=$subtwnIndx_L
				Else 
					LSS_SearchTwnCode_txt:=""
					aTownName_:=0
					//LSS_SearchDistr_aL:=0 keep the district
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Invalid Town Code Entered ["+LSS_SearchTwnCode_txt+"]")
			aTownName_:=0
			GOTO OBJECT:C206(*; "LSS_SearchTwnCode_txt")
		End if 
	: (Length:C16(LSS_SearchTwnCode_txt)=0)
		LSS_SearchTwnCode_txt:=""
		aTownName_:=0
		//LSS_SearchDistr_aL:=0
	Else 
		ALERT:C41("Incomplete Town Code entered  ["+LSS_SearchTwnCode_txt+"]")
		aTownName_:=0
		GOTO OBJECT:C206(*; "LSS_SearchTwnCode_txt")
		
End case 