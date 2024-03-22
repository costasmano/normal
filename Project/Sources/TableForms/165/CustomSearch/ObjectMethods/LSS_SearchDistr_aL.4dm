If (False:C215)
	//Object Method: [LSS_Inventory].CustomSearch.LSS_SearchDistr_aL 
	// Modified by: Costas Manousakis-(Designer)-(1/28/16 21:03:04)
	Mods_2016_01_bug
	//  `replaced LSS_Townname_atxt , etc with  variables aTownName_, ◊aBDEPT, ◊aDistrict`
	//  `use the District dropdown to narrow down the list of towns.
End if 

If (LSS_SearchDistr_aL>0)
	
	If (Num:C11(LSS_SearchDistr_aL{LSS_SearchDistr_aL})>0)
		If (aTownName_>0)
			C_LONGINT:C283($twnindx_L)
			$twnindx_L:=Find in array:C230(<>aTownName; aTownName_{aTownName_})
			
			If (Num:C11(<>aDistrict{$twnindx_L})#(LSS_SearchDistr_aL{LSS_SearchDistr_aL}))
				C_TEXT:C284($msg_txt)
				$msg_txt:="You chose District "+String:C10(LSS_SearchDistr_aL{LSS_SearchDistr_aL})+" which does not match District "+String:C10(Num:C11(<>aDistrict{$twnindx_L}))+" of Selected Town "+aTownName_{aTownName_}
				$msg_txt:=$msg_txt+".  Continue and the Town name will be reset, or stay in District "+String:C10(Num:C11(<>aDistrict{$twnindx_L}))+"?"
				CONFIRM:C162($msg_txt; "Continue"; "Stay in D"+String:C10(Num:C11(<>aDistrict{$twnindx_L})))
				If (OK=1)
					aTownName_:=0
					ARRAY TEXT:C222(aTownName_; 0)  //Command Replaced was o_ARRAY string length was 20
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274(<>aTownName))
						If (Num:C11(<>aDistrict{$loop_L})=LSS_SearchDistr_aL{LSS_SearchDistr_aL})
							APPEND TO ARRAY:C911(aTownName_; <>aTownName{$loop_L})
						End if 
					End for 
					LSS_SearchTwnCode_txt:=""
				Else 
					
					LSS_SearchDistr_aL:=1+Num:C11(<>aDistrict{$twnindx_L})
					
				End if 
				
			End if 
		Else 
			//reset the townlist
			ARRAY TEXT:C222(aTownName_; 0)  //Command Replaced was o_ARRAY string length was 20
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(<>aTownName))
				If (Num:C11(<>aDistrict{$loop_L})=LSS_SearchDistr_aL{LSS_SearchDistr_aL})
					APPEND TO ARRAY:C911(aTownName_; <>aTownName{$loop_L})
				End if 
			End for 
			aTownName_:=0
		End if 
	Else 
		//picked first entry - no distr : town list will switch to all towns
		
		If (Size of array:C274(aTownName_)#Size of array:C274(<>aTownName))
			//we have a subset - should we set the town list to all towns ; do this only if there is a town selected
			C_TEXT:C284($TwnName_txt)
			C_BOOLEAN:C305($refresh_b)
			If (aTownName_>0)
				//a town is selected 
				$TwnName_txt:=aTownName_{aTownName_}
				CONFIRM:C162("Change the Town list to display all Towns in Mass.?")
				$refresh_b:=(OK=1)
			Else 
				//no town - just change the list
				$TwnName_txt:=""
				$refresh_b:=True:C214
			End if 
			
			If ($refresh_b)
				COPY ARRAY:C226(<>aTownName; aTownName_)
				If ($TwnName_txt#"")
					//pick the old town
					C_LONGINT:C283($twnindx_L)
					aTownName_:=Find in array:C230(aTownName_; $TwnName_txt)
				Else 
					aTownName_:=0
				End if 
			End if 
		Else 
			//same list - no need to do anything
		End if 
		
	End if 
	
End if 

//End Object Method: [LSS_Inventory].CustomSearch.LSS_SearchDistr_aL