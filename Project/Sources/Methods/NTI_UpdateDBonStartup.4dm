//%attributes = {"invisible":true}
//Method: NTI_UpdateDBonStartup
//Description
// update the DEFS table from XML files in resources on startup.
// runs on startup either server, or standalone - not client.
// will mark in parameters table the date and time in parameter "NTI_DEFSUPDATE"
// if parameter is found or value is blank it will not do the update.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/04/18, 16:14:36
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
	Mods_2021_04  //Make sure no display when on server
	//Modified by: CJ (4/8/21 16:09:56)
End if 
//

Case of 
	: (Application type:C494=4D Server:K5:6) | (Application type:C494=4D Volume desktop:K5:2)
		
		
		QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="NTI_DEFSUPDATE")
		If ((Records in selection:C76([Parameters:107])=0) | ([Parameters:107]Value:3=""))
			C_TEXT:C284($NTI_DEFECT_ELEM_TREE; $NTI_DEFECT_LANG_TREE)
			$NTI_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("TIN"; "Element_DefectTree.xml")
			$NTI_DEFECT_LANG_TREE:=ut_DOM_LoadXML("TIN"; "Defect_Language.xml")
			C_BOOLEAN:C305($Updated_b)
			C_TEXT:C284($TimeStamp_txt)
			$TimeStamp_txt:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
			$TimeStamp_txt:=Replace string:C233($TimeStamp_txt; ":"; "_")
			C_OBJECT:C1216($progress_o)
			//start the bar
			If (Application type:C494#4D Server:K5:6)
				C_OBJECT:C1216($progress_o)
				$progress_o:=ProgressNew("Updating NTI Element definitions"; 1; False:C215; " table [NTI_ELEM_DEFS]"; 0)
			End if 
			$Updated_b:=NTI_UpdateDBfromXML($NTI_DEFECT_ELEM_TREE; $NTI_DEFECT_LANG_TREE; \
				Get 4D folder:C485(Logs folder:K5:19)+"NTI_DEFSUPDATE_"+$TimeStamp_txt+".txt")
			If ($Updated_b)
				//update progress
				If (Application type:C494#4D Server:K5:6)
					UpdateProgressNew($progress_o; 1)
				End if 
				QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="NTI_DEFSUPDATE")
				If (Records in selection:C76([Parameters:107])=0)
					CREATE RECORD:C68([Parameters:107])
					[Parameters:107]ParamCode:1:="NTI_DEFSUPDATE"
					[Parameters:107]Value:3:=$TimeStamp_txt
					SAVE RECORD:C53([Parameters:107])
					UNLOAD RECORD:C212([Parameters:107])
				Else 
					If (ut_LoadRecordInteractive(->[Parameters:107]))
						[Parameters:107]Value:3:=$TimeStamp_txt
						SAVE RECORD:C53([Parameters:107])
						UNLOAD RECORD:C212([Parameters:107])
					Else 
						If (Application type:C494#4D Server:K5:6)
							ALERT:C41("Could not update Parameter record NTI_DEFSUPDATE")
						End if 
					End if 
					
				End if 
			End if 
			
			//quit progress
			If (Application type:C494#4D Server:K5:6)
				Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
			End if 
		End if 
		
End case 


//End NTI_UpdateDBonStartup