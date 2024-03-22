If (False:C215)
	//Form Method: [Inspections];"BlankCombinedStarter"
	
	//Used to open the required input form depending on the inspection type
	Mods_2005_CM06
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 10:31:49)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/27/2006 14:05:58)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(11/3/06 17:26:14)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(12/4/07 14:20:57)
	Mods_2007_CM_5401  //make sure the Bridge MHD NBIS record is in readonly mode so we don't lock it
	//  `  `Also hide the 'Press this button' button until we exit the form...
	// Modified by: costasmanousakis-(Designer)-(12/20/07 12:18:35)
	Mods_2007_CM_5401
	//Set  [Element Cat] [ElementDict] tables to read only
	// Modified by: costasmanousakis-(Designer)-(5/1/08 16:51:40)
	Mods_2008_CM_5403
	//  `Allow access to users belonging to MHDInspectionROAccess group when
	//  `the inspection has been completed
	// Modified by: costasmanousakis-(Designer)-(2/16/09 11:58:16)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:53:22)
	Mods_2009_04
	//Call method G_InitInspVars here instead of in the input form methods
	// Modified by: costasmanousakis-(Designer)-(4/21/09 20:11:32)
	Mods_2009_04
	//Place WildCard around "MHD BMS External" for new .4Dx extensions 
	//Removed the .comp at the District X BMS.comp string.
	// Modified by: costasmanousakis-(Designer)-(11/18/09 11:12:07)
	Mods_2009_11
	//Added user group InspectionAllAccess to allow access to all inspections.
	//Per request of S.Eslinger
	// Modified by: costasmanousakis-(Designer)-(6/11/10 08:42:18)
	Mods_2010_06
	//  `Allow Access to Freeze Thaw inspections if they are approved by the DBIE
	// Modified by: costasmanousakis-(Designer)-(9/28/10 09:43:43)
	Mods_2010_09
	//  `Use new method INSP_UserAllowed
	// Modified by: costasmanousakis-(Designer)-(1/19/11 09:04:39)
	Mods_2011_01
	//` RR
	// Modified by: Costas Manousakis-(Designer)-(5/8/12 17:20:05)
	Mods_2012_05
	//  `Added Flood DVF inspection type
	Mods_2012_12  //r001 ` Add code for new inspection types
	//Modified by: Charles Miller (12/13/12 14:03:34)
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 15:34:50)
	Mods_2012_12
	//  `added code for RRS RRF RRD RRO Inspection types
	// Modified by: Costas Manousakis-(Designer)-(1/16/13 14:19:36)
	Mods_2013_01
	//  `added code to unload [RAILBridgeInfo] if loaded;
	//  `added code to unload field trip records also at the end
	// Modified by: Costas Manousakis-(Designer)-(4/16/13 14:50:21)
	Mods_2013_04
	//  `Tunnels
	// Modified by: Costas Manousakis-(Designer)-(5/24/13 17:06:40)
	Mods_2013_05
	//  `changed READ WRITE (*) at the end of load and Unload to  INSP_Read_Write_Tables ("WRITE")  
	// Modified by: Costas Manousakis-(Designer)-(10/17/13 11:32:35)
	Mods_2013_10
	//  `place the input form name in a variable- use dialog to load inspection if table is in read only mode
	// Modified by: Costas Manousakis-(Designer)-(2/27/14 17:12:52)
	Mods_2014_02
	//  `New Freeze thaw form
	// Modified by: manousakisc (1/5/2015)
	Mods_2015_01
	//  `Added Tunnel damage type "TDA"
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 15:12:29)
	Mods_2015_02
	//  `Added Tunnel Other type "TOT"
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can not double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
	// Modified by: Costas Manousakis-(Designer)-(5/3/19 13:42:34)
	Mods_2019_05
	//  `removed "DVA" type - not used
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 10:57:26)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(BlankExitBtn; False:C215)
		READ ONLY:C145([Bridge MHD NBIS:1])  //Mods_2007_CM_5401
		READ ONLY:C145([RAILBridgeInfo:37])
		READ ONLY:C145([TunnelInfo:151])
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		UNLOAD RECORD:C212([Bridge MHD NBIS:1])
		LOAD RECORD:C52([Bridge MHD NBIS:1])
		QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		If (Is record loaded:C669([RAILBridgeInfo:37]))
			UNLOAD RECORD:C212([RAILBridgeInfo:37])
			LOAD RECORD:C52([RAILBridgeInfo:37])
		End if 
		READ ONLY:C145([Inspection Type:31])
		If (Is record loaded:C669([Inspection Type:31]))
			UNLOAD RECORD:C212([Inspection Type:31])
			LOAD RECORD:C52([Inspection Type:31])
		End if 
		
		C_BOOLEAN:C305($Configured)
		C_TEXT:C284($Form_txt)
		$Configured:=True:C214
		$Form_txt:=InspectionTypeToForm
		$Configured:=Not:C34($Form_txt="Not Configured")
		If ($Configured=True:C214)
			//Define inspection fonts      
			G_SetInspFont
			C_TEXT:C284($vsSaveForward)  // Command Replaced was o_C_STRING length was 80
			C_BOOLEAN:C305($vbUserAllowed)
			
			//allow access if User is in group or if Inspection is approved.
			$vbUserAllowed:=INSP_UserAllowed
			If ($vbUserAllowed)
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				If ([Combined Inspections:90]NBISInspID:2#[Inspections:27]InspID:2)
					//Get the correct Combined record
					QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
					If (Records in selection:C76([Combined Inspections:90])=1)
						GOTO SELECTED RECORD:C245([Combined Inspections:90]; 1)
					End if 
				End if 
				
				LOAD RECORD:C52([Combined Inspections:90])
				C_BOOLEAN:C305(vblnCombinedInspection)
				vblnCombinedInspection:=True:C214
				COPY NAMED SELECTION:C331([Combined Inspections:90]; "curCombinedInspection")
				//RELATE ONE([Combined Inspections]NBISInspID)
				RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
				C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
				vCurrentPontisID_L:=[BMS Inspections:44]Inspection ID:1
				vCurrentCombID_L:=[Combined Inspections:90]ID:6
				
				$vsSaveForward:=vsForward
				//  //Added to change Forward address per maintenance responsibility      
				//If (Structure file="MHD BMS External@")
				//If ([Bridge MHD NBIS]InspResp="DIST@")
				//vsForward:="District "+Substring([Bridge MHD NBIS]InspResp;5;1)+" BMS"
				//End if 
				//End if 
				
				READ ONLY:C145([Element Cat:32])
				READ ONLY:C145([ElementDict:30])
				
				//## Initialize transfer data
				InitChangeStack(1)  //For [Inspections] record
				InitChangeStack(2)  //for sub-elements
				InitChangeStack(3)  //for bms inspections record
				InitChangeStack(4)  //for combined inspections record
				
				G_InitInspVars  //Start needed variables
				InDoubleClick_B:=False:C215
				//Enter using the chosen input form    
				If (Read only state:C362([Inspections:27]))
					DIALOG:C40([Inspections:27]; $form_txt)
				Else 
					vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
					FORM SET INPUT:C55([Inspections:27]; $form_txt)
					MODIFY RECORD:C57([Inspections:27])
				End if 
				InDoubleClick_B:=False:C215
				//Reset the input form to this one
				FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")
				vblnCombinedInspection:=False:C215
				// need to check if we are still in a transaction
				If (In transaction:C397)
					CANCEL TRANSACTION:C241
				End if 
				CANCEL:C270  // get out of this form
				UNLOAD RECORD:C212([Inspections:27])
				UNLOAD RECORD:C212([BMS Inspections:44])
				UNLOAD RECORD:C212([Combined Inspections:90])
				UNLOAD RECORD:C212([ElementsSafety:29])  //Mods_2007_CM_5401
				UNLOAD RECORD:C212([Standard Photos:36])
				UNLOAD RECORD:C212([Cond Units:45])
				UNLOAD RECORD:C212([Field Trip:43])
				UNLOAD RECORD:C212([BMS Field Trip:56])
				UNLOAD RECORD:C212([TunnelInspection:152])
				
				//added to clear locks on [activity log] table
				If (Is record loaded:C669([Activity Log:59]))
					UNLOAD RECORD:C212([Activity Log:59])
				End if 
				
				//restore Forward
				vsForward:=$vsSaveForward
				//SET AUTOMATIC RELATIONS(True;True)
			Else 
				ALERT:C41("Not allowed to open this Inspection")
				CANCEL:C270  //exit form
				UNLOAD RECORD:C212([Inspections:27])
			End if   //if user allowed
			OBJECT SET VISIBLE:C603(BlankExitBtn; True:C214)
		Else 
			//This should not happen the way things are set up,
			// but just in case..    
			ALERT:C41("Please use the Configure button for this inspection form!")
			CANCEL:C270  //get out of this form
			UNLOAD RECORD:C212([Inspections:27])
		End if 
		//INSP_Read_Write_Tables ("WRITE")  //Mods_2007_CM_5401
		CANCEL:C270
	: (Form event code:C388=On Unload:K2:2)
		INSP_Read_Write_Tables("WRITE")  //Mods_2007_CM_5401
End case 