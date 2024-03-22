//%attributes = {"invisible":true}
//Method: DEV_DisableButton_fix
//Description
// Fix the _ o _DISABLE BUTTON and _ o _ENABLE BUTTON commands in all methods
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/20/17
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	
	CONFIRM:C162("Quit all current progress bars?")
	If (OK=1)
		Progress QUIT(0)
	End if 
	
	CONFIRM:C162("Proceed with replacing all _o_DISABLE and _o_ENABLE commands?")
	
	If (OK=1)
		ARRAY TEXT:C222($allMethods_atxt; 0)
		
		METHOD GET PATHS:C1163(Path all objects:K72:16; $allMethods_atxt)
		SORT ARRAY:C229($allMethods_atxt)
		
		//ut_DisplayArray (->$allMethods_atxt;"all methods "+String(Size of array($allMethods_atxt));"name")
		C_LONGINT:C283($progr_L)
		
		$progr_L:=Progress New
		Progress SET TITLE($progr_L; "scanning "+String:C10(Size of array:C274($allMethods_atxt))+" methods.")
		Progress SET BUTTON ENABLED($progr_L; True:C214)
		
		C_BOOLEAN:C305($disable_b; $newMeth_b)
		C_TEXT:C284($meth_txt; $newMeth_txt; $cmts_txt)
		ARRAY LONGINT:C221($start_aL; 0)
		ARRAY LONGINT:C221($len_aL; 0)
		ARRAY TEXT:C222($MethodsFixed_atxt; 0)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($allMethods_atxt))
			Progress SET PROGRESS($progr_L; ($loop_L/Size of array:C274($allMethods_atxt)))
			
			$newMeth_b:=False:C215
			METHOD GET CODE:C1190($allMethods_atxt{$loop_L}; $meth_txt)
			C_LONGINT:C283($loop_L; $start_L)
			$start_L:=1
			Repeat 
				$disable_b:=Match regex:C1019("\r(_o_DISABLE BUTTON)(\\()(.*)(\\))(.*)\r"; $meth_txt; $start_L; $start_aL; $len_aL)
				
				If ($disable_b)
					//ALERT("Old command = "+Substring($meth_txt;$start_aL{0};$len_aL{0})+Char(13)+"Variable ="+Substring($meth_txt;$start_aL{3};$len_aL{3})+Char(13)+"New command ="+"OBJECT SET ENABLED("+Substring($meth_txt;$start_aL{3};$len_aL{3})+"; false)")
					
					//meth_txt:=Replace string($meth_txt;Substring($meth_txt;$start_aL{0};$len_aL{0});"OBJECT SET ENABLED("+Substring($meth_txt;$start_aL{3};$len_aL{3})+"; false)\r")
					//$meth_txt:=Substring($meth_txt;1;($start_aL{0}-1))+"OBJECT SET ENABLED("+Substring($meth_txt;$start_aL{3};$len_aL{3})+"; false)\r"+Substring($meth_txt;($start_aL{0}+$len_aL{0}))
					$cmts_txt:=""
					If (Size of array:C274($start_aL)=5)
						$cmts_txt:=Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})
					End if 
					$meth_txt:=Substring:C12($meth_txt; 1; ($start_aL{0}))+"` CommandReplaced "+Substring:C12($meth_txt; $start_aL{0}+1; ($len_aL{0}-1))+"OBJECT SET ENABLED("+Substring:C12($meth_txt; $start_aL{3}; $len_aL{3})+"; false)"+$cmts_txt+"\r"+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
					$start_L:=$start_aL{0}+$len_aL{0}+Length:C16("` CommandReplaced ")
					$newMeth_b:=True:C214
				End if 
				
			Until (Not:C34($disable_b))
			
			$start_L:=1
			
			Repeat 
				$disable_b:=Match regex:C1019("\r(_o_ENABLE BUTTON)(\\()(.*)(\\))(.*)\r"; $meth_txt; $start_L; $start_aL; $len_aL)
				
				If ($disable_b)
					//ALERT("Old command = "+Substring($meth_txt;$start_aL{0};$len_aL{0})+Char(13)+"Variable ="+Substring($meth_txt;$start_aL{3};$len_aL{3})+Char(13)+"New command ="+"OBJECT SET ENABLED("+Substring($meth_txt;$start_aL{3};$len_aL{3})+"; false)")
					
					//meth_txt:=Replace string($meth_txt;Substring($meth_txt;$start_aL{0};$len_aL{0});"OBJECT SET ENABLED("+Substring($meth_txt;$start_aL{3};$len_aL{3})+"; false)\r")
					
					//$meth_txt:=Substring($meth_txt;1;($start_aL{0}-1))+"OBJECT SET ENABLED("+Substring($meth_txt;$start_aL{3};$len_aL{3})+"; True)\r"+Substring($meth_txt;($start_aL{0}+$len_aL{0}))
					$cmts_txt:=""
					If (Size of array:C274($start_aL)=5)
						$cmts_txt:=Substring:C12($meth_txt; $start_aL{5}; $len_aL{5})
					End if 
					$meth_txt:=Substring:C12($meth_txt; 1; ($start_aL{0}))+"` CommandReplaced "+Substring:C12($meth_txt; $start_aL{0}+1; ($len_aL{0}-1))+"OBJECT SET ENABLED("+Substring:C12($meth_txt; $start_aL{3}; $len_aL{3})+"; True)"+$cmts_txt+"\r"+Substring:C12($meth_txt; ($start_aL{0}+$len_aL{0}))
					$start_L:=$start_aL{0}+$len_aL{0}+Length:C16("` CommandReplaced ")
					$newMeth_b:=True:C214
				End if 
				
			Until (Not:C34($disable_b))
			
			If ($newMeth_b)
				Progress SET MESSAGE($progr_L; $allMethods_atxt{$loop_L})
				ALERT:C41("Changed method "+$allMethods_atxt{$loop_L})
				METHOD SET CODE:C1194($allMethods_atxt{$loop_L}; $meth_txt)
				ut_SaveMethod($allMethods_atxt{$loop_L})
				APPEND TO ARRAY:C911($MethodsFixed_atxt; $allMethods_atxt{$loop_L})
			End if 
			If (Progress Stopped($progr_L))
				$loop_L:=Size of array:C274($allMethods_atxt)+1
			End if 
		End for 
		
		Progress QUIT($progr_L)
		
		If (Size of array:C274($MethodsFixed_atxt)>0)
			
			C_LONGINT:C283($meth_L)
			
			Repeat 
				$meth_L:=G_PickFromList(->$MethodsFixed_atxt; "Pick a method from modified "+String:C10(Size of array:C274($MethodsFixed_atxt)))
				If ($meth_L>0)
					METHOD OPEN PATH:C1213($MethodsFixed_atxt{$meth_L})
				End if 
				
			Until (OK=0)
			
			
		Else 
			ALERT:C41("No Methods were modified!")
		End if 
	End if 
	
End if 
//End DEV_DisableButton_fix