//%attributes = {"invisible":true}
//Method: TNL_AddInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/12/13, 17:19:05
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
C_TEXT:C284($vsInspType)  // Command Replaced was o_C_STRING length was 3
//Add a Pontis Inspection
C_BOOLEAN:C305(vAddBlank)

vAddBlank:=True:C214
$vsInspType:=GetInspType

If ($vsInspType#"")
	INSP_Read_Write_Tables("WRITE")
	READ ONLY:C145([TunnelInfo:151])
	QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	//Add a record for a new combined inspection  
	
	INSP_AddInspRecs(->[Combined Inspections:90]; $vsInspType)
	
	//Changed Dec-2001
	FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")
	
	INSP_AddInspRecs(->[Inspections:27]; $vsInspType)
	
	INSP_AddInspRecs(->[TunnelInspection:152]; $vsInspType)
	SAVE RECORD:C53([Inspections:27])
	SAVE RECORD:C53([Combined Inspections:90])
	SAVE RECORD:C53([TunnelInspection:152])
	PUSH RECORD:C176([Inspections:27])
	PUSH RECORD:C176([Combined Inspections:90])
	PUSH RECORD:C176([TunnelInspection:152])
	
	SET CURSOR:C469(4)
	SHORT_MESSAGE("Configuring Inspection...")
	G_AddDefInspElmts
	CLOSE WINDOW:C154
	
	POP RECORD:C177([Combined Inspections:90])
	ONE RECORD SELECT:C189([Combined Inspections:90])
	POP RECORD:C177([Inspections:27])
	POP RECORD:C177([TunnelInspection:152])
	
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
//End TNL_AddInspection