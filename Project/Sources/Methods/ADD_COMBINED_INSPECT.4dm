//%attributes = {"invisible":true}
//ADD_COMBINED_INSPECT
//Add a new NBIS inspection and Pontis report
If (False:C215)
	//Author: Albert Leung, 2004
	//
	Mods_2005_CM06
	Mods_2005_CM09
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(11/17/05 15:03:37)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(8/20/08 08:17:27)
	Mods_2008_CM_5404
	//  `Use Method INSP_UpdateInspList
	// Modified by: costasmanousakis-(Designer)-(3/10/09 14:27:55)
	Mods_2009_03
	//  `Use the current user as the default team leader
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 11:51:45)
	Mods_2013_01
	//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before creating new inspection
	// Modified by: Costas Manousakis-(Designer)-(5/22/13 16:36:57)
	Mods_2013_05
	//  `replaced ut_Read_Write_Tables with  INSP_Read_Write_Tables
	// Modified by: Costas Manousakis-(Designer)-(11/14/13 09:52:32)
	Mods_2013_11
	//  `screen inspections created here if they are for tunnel records
	// Modified by: Costas Manousakis-(Designer)-(1/11/17 16:08:11)
	Mods_2017_01
	//  `make current user TL only if they are TL or DBIE
	// Modified by: Costas Manousakis-(Designer)-(1/16/17 10:24:56)
	Mods_2017_01
	//  `fix select SQL to use [] around  <>CurrentUser_PID
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2022-03-18 15:27:12)
	Mods_2022_03
	//  `use <>CurrentUser_PID for call to Synch_ReturnForward : Team leader is not known yet.
End if 
C_TEXT:C284($vsInspType)  // Command Replaced was o_C_STRING length was 3
//Add a Pontis Inspection
C_BOOLEAN:C305(vAddBlank)
$vsInspType:=""

vAddBlank:=True:C214
$vsInspType:=GetInspType
//screen inspections created here if they are for tunnel records
If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS"))
	
	If ($vsInspType="R@") | ($vsInspType="CUL") | ($vsInspType="CMI") | ($vsInspType="FCR")
		READ ONLY:C145([Inspection Type:31])
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$vsInspType)
		CONFIRM:C162("Are you sure you want to create a "+[Inspection Type:31]Description:2+" Inspection for a TUNNEL record? You can create Tunnel inspections from the <Tunnel Inspections> module on the Bridge Input screen."; "Continue"; "Cancel")
		If (Ok=1)
		Else 
			$vsInspType:=""
		End if 
	End if 
	
End if 

If ($vsInspType#"")
	INSP_Read_Write_Tables("WRITE")
	
	vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; $vsInspType; <>CurrentUser_PID)
	//Add a record for a new combined inspection  
	
	CREATE RECORD:C68([Combined Inspections:90])
	Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
	//2004-08-03 ASL
	//This should be a fixed parent record and relative local record
	InitChangeStack(1)
	[Combined Inspections:90]InspDate:4:=Current date:C33(*)
	[Combined Inspections:90]BIN:1:=[Bridge MHD NBIS:1]BIN:3
	[Combined Inspections:90]InspType:5:=$vsInspType
	SAVE RECORD:C53([Combined Inspections:90])
	PushChange(1; ->[Combined Inspections:90]InspType:5)
	If (False:C215)
		LogChanges(->[Combined Inspections:90]BIN:1; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
	End if 
	PushChange(1; ->[Combined Inspections:90]InspType:5)
	PushChange(1; ->[Combined Inspections:90]InspDate:4)
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1; "CombinedInspections")
	FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
	
	//Changed Dec-2001
	FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")
	CREATE RECORD:C68([Inspections:27])
	//Set default values
	Inc_Sequence("Inspections"; ->[Inspections:27]InspID:2)
	[Inspections:27]BIN:1:=[Bridge MHD NBIS:1]BIN:3
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; "Inspections")
	[Combined Inspections:90]NBISInspID:2:=[Inspections:27]InspID:2
	//This is a relative field
	LogLink(->[Combined Inspections:90]NBISInspID:2; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
	[Inspections:27]Insp Type:6:=$vsInspType
	PushChange(1; ->[Inspections:27]Insp Type:6)
	[Inspections:27]InspReviewed:12:=BMS Not Reviewed
	PushChange(1; ->[Inspections:27]InspReviewed:12)
	[Inspections:27]InspApproved:167:=BMS Not Reviewed
	PushChange(1; ->[Inspections:27]InspApproved:167)
	[Inspections:27]InspComplete:168:=False:C215
	PushChange(1; ->[Inspections:27]InspComplete:168)
	[Inspections:27]Insp Date:78:=Current date:C33(*)
	PushChange(1; ->[Inspections:27]Insp Date:78)
	
	G_SIA2Inspection  //get SIA data into [Inspections] fields  
	//Need a creation date before saving
	[Inspections:27]DateCreated:135:=Current date:C33(*)  //Add the difference between the server date
	PushChange(1; ->[Inspections:27]DateCreated:135)
	[Inspections:27]TimeCreated:136:=Current time:C178(*)  //Add the difference between the server time
	PushChange(1; ->[Inspections:27]TimeCreated:136)
	[Inspections:27]Modified By:134:=Current user:C182
	PushChange(1; ->[Inspections:27]Modified By:134)
	
	FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
	
	If (<>CurrentUser_PID>0)
		C_LONGINT:C283($JobCode_L)
		Begin SQL
			select [Personnel].[Job Code] from [Personnel] where [Personnel].[Person ID] = :[<>CurrentUser_PID] into :$JobCode_L ;
		End SQL
		If ($JobCode_L=2) | ($JobCode_L=1)  //TL or DBIE
			[Inspections:27]TeamLeader:4:=<>CurrentUser_PID
			LogLink(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
		End if 
	End if 
	
	SAVE RECORD:C53([Inspections:27])
	SAVE RECORD:C53([Combined Inspections:90])
	PUSH RECORD:C176([Inspections:27])
	PUSH RECORD:C176([Combined Inspections:90])
	
	SET CURSOR:C469(4)
	SHORT_MESSAGE("Configuring Inspection...")
	G_AddDefInspElmts
	CLOSE WINDOW:C154
	
	POP RECORD:C177([Combined Inspections:90])
	ONE RECORD SELECT:C189([Combined Inspections:90])
	POP RECORD:C177([Inspections:27])
	//Create the BMS inspection
	Case of 
		: (([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL"))
			//This is a new record.    -Add Pontis inspection
			CREATE RECORD:C68([BMS Inspections:44])
			Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
			[Combined Inspections:90]BMSInspID:3:=[BMS Inspections:44]Inspection ID:1
			
			[BMS Inspections:44]BIN:2:=[Bridge MHD NBIS:1]BIN:3
			[BMS Inspections:44]Insp Date:4:=Current date:C33(*)
			[BMS Inspections:44]Span Group No:3:=1
			[BMS Inspections:44]Metric:14:=False:C215  //Change this default after all old inspections are entered.
			[BMS Inspections:44]Agency:13:=[Inspections:27]Agency:156
			TimeStamp_ut(->[BMS Inspections:44]; ->[BMS Inspections:44]DateCreated:8; ->[BMS Inspections:44]TimeCreated:9; ->[BMS Inspections:44]DateModified:10; ->[BMS Inspections:44]TimeModified:11)
			[BMS Inspections:44]Modified By:7:=Current user:C182
			[BMS Inspections:44]TeamLeader:6:=[Inspections:27]TeamLeader:4
			
			//This record must be saved at the beginning to prevent [Cond Units] records
			//from being orphaned by a cancel.
			//Implementing transactions might be a better method.
			SAVE RECORD:C53([BMS Inspections:44])
			SAVE RECORD:C53([Combined Inspections:90])
			COPY NAMED SELECTION:C331([Combined Inspections:90]; "curCombinedInspection")
			
			//Record the log.
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; "Pontis Insp ID")
			//This is a relative field
			LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			InitChangeStack(1)
			PushChange(1; ->[BMS Inspections:44]Insp Date:4)
			PushChange(1; ->[BMS Inspections:44]Span Group No:3)
			PushChange(1; ->[BMS Inspections:44]DBrInspEngr:5)
			PushChange(1; ->[BMS Inspections:44]Modified By:7)
			PushChange(1; ->[BMS Inspections:44]DateCreated:8)
			PushChange(1; ->[BMS Inspections:44]TimeCreated:9)
			PushChange(1; ->[BMS Inspections:44]Metric:14)
			PushChange(1; ->[BMS Inspections:44]Agency:13)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
			LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
		Else 
			//No Pontis inspection for other Inspection types,
			//no [BMS Inspections] record will be created.
			[Combined Inspections:90]BMSInspID:3:=-1
			SAVE RECORD:C53([Combined Inspections:90])
			//This is a relative field
			LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			
	End case 
	
	SET CURSOR:C469(0)
	MODIFY RECORD:C57([Inspections:27])
	
	INSP_UpdateInspList
End if 