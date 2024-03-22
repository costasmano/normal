If (False:C215)
	//"BlankStarter" Form method
	//Used to open the required input form depending on the inspection type
	Mods_2004_CM05
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(4/21/09 20:11:32)
	Mods_2009_04
	//Place WildCard around "MHD BMS External" for new .4Dx extensions 
	//Removed the .comp at the District X BMS.comp string.
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_BOOLEAN:C305($Configured)
		
		$Configured:=True:C214
		Case of 
			: ([Inspections:27]Insp Type:6="RTN")
				FORM SET INPUT:C55([Inspections:27]; "Routine Form")
			: ([Inspections:27]Insp Type:6="RTA")
				//INPUT FORM([Inspections];"Routine Arch")
				FORM SET INPUT:C55([Inspections:27]; "Routine Form")
			: ([Inspections:27]Insp Type:6="FCR")
				FORM SET INPUT:C55([Inspections:27]; "Critical Member")
			: ([Inspections:27]Insp Type:6="CMI")
				FORM SET INPUT:C55([Inspections:27]; "Critical Member")
			: ([Inspections:27]Insp Type:6="OTH")
				FORM SET INPUT:C55([Inspections:27]; "Critical Member")
			: ([Inspections:27]Insp Type:6="CUL")
				FORM SET INPUT:C55([Inspections:27]; "Culvert Form")
			: ([Inspections:27]Insp Type:6="CLD")
				FORM SET INPUT:C55([Inspections:27]; "Closed Bridge")
			: ([Inspections:27]Insp Type:6="DAM")
				FORM SET INPUT:C55([Inspections:27]; "Damage Form")
			: ([Inspections:27]Insp Type:6="DVE")
				FORM SET INPUT:C55([Inspections:27]; "Dive Form")
			: ([Inspections:27]Insp Type:6="DVL")
				FORM SET INPUT:C55([Inspections:27]; "Dive LowCL")
			: ([Inspections:27]Insp Type:6="DVS")
				FORM SET INPUT:C55([Inspections:27]; "Underwater Special Member")
			Else 
				$Configured:=False:C215
		End case 
		
		If ($Configured=True:C214)
			//Define inspection fonts      
			G_SetInspFont
			C_TEXT:C284($vsSaveForward)  // Command Replaced was o_C_STRING length was 80
			C_BOOLEAN:C305($vbUserAllowed)
			
			$vbUserAllowed:=User in group:C338(Current user:C182; "MHDInspectionRWAccess")
			//allow access if User is in group or if Inspection is approved.
			$vbUserAllowed:=($vbUserAllowed | ([Inspections:27]InspApproved:167=BMS Approved))
			If ($vbUserAllowed)
				$vsSaveForward:=vsForward
				//Added to change Forward address per maintenance responsibility      
				If (Structure file:C489="MHD BMS External@")
					If ([Bridge MHD NBIS:1]InspResp:173="DIST@")
						vsForward:="District "+Substring:C12([Bridge MHD NBIS:1]InspResp:173; 5; 1)+" BMS"
					End if 
				End if 
				
				//Enter using the chosen input form    
				MODIFY RECORD:C57([Inspections:27])
				//Reset the input form to this one
				FORM SET INPUT:C55([Inspections:27]; "BlankStarter")
				// need to check if we are still in a transaction
				If (In transaction:C397)
					CANCEL TRANSACTION:C241
				End if 
				CANCEL:C270  // get out of this form
				UNLOAD RECORD:C212([Inspections:27])
				//added to clear locks on [activity log] table
				If (Is record loaded:C669([Activity Log:59]))
					UNLOAD RECORD:C212([Activity Log:59])
				End if 
				//restore Forward
				vsForward:=$vsSaveForward
			Else 
				ALERT:C41("Not allowed to open this Inspection")
				CANCEL:C270  //exit form
				UNLOAD RECORD:C212([Inspections:27])
			End if   //if user allowed
		Else 
			//This should not happen the way things are set up,
			// but just in case..    
			ALERT:C41("Please use the Configure button for this inspection form!")
			CANCEL:C270  //get out of this form
			UNLOAD RECORD:C212([Inspections:27])
		End if 
		
End case 