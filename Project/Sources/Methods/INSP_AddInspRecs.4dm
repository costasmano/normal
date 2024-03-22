//%attributes = {"invisible":true}
//Method: INSP_AddInspRecs
//Description
//
// Parameters
// $1 : $Table_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/12/13, 16:53:25
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(1/11/17 16:08:11)
	Mods_2017_01
	//  `make current user TL only if they are TL or DBIE
	// Modified by: Costas Manousakis-(Designer)-(1/16/17 10:24:56)
	Mods_2017_01
	//  `fix select SQL to use [] around  <>CurrentUser_PID
	// Modified by: Costas Manousakis-(Designer)-(3/18/19 14:30:00)
	Mods_2019_03_bug
	//  `use NTI_GroupSuffix for the personnel group for DBIE in tunnel inspections
End if 
//
C_POINTER:C301($1; $Table_ptr)
$Table_ptr:=$1

C_TEXT:C284($vsInspType)
$vsInspType:="???"
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$vsInspType:=$2
End if 

C_TEXT:C284($tableName_txt)

$tableName_txt:=Table name:C256($Table_ptr)
Case of 
	: ($tableName_txt=Table name:C256(->[Combined Inspections:90]))
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
		
	: ($tableName_txt=Table name:C256(->[Inspections:27]))
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
		
		If ([Inspections:27]Insp Type:6="T@")
			
			[Inspections:27]DBrInspEngr:3:=GRP_GetGroupRepID("TunnelInspEng"+NTI_GroupSuffix([Bridge MHD NBIS:1]InspResp:173; [Bridge MHD NBIS:1]Item2:60))
			
			If ([Inspections:27]DBrInspEngr:3>0)
				LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
			Else 
				LogChanges(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
			End if 
			
		End if 
		
	: ($tableName_txt=Table name:C256(->[BMS Inspections:44]))
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
		
	: ($tableName_txt=Table name:C256(->[TunnelInspection:152]))
		CREATE RECORD:C68([TunnelInspection:152])
		Inc_Sequence("TunnelInspection"; ->[TunnelInspection:152]TunnelInspID_L:15)
		[TunnelInspection:152]InspID:1:=[Inspections:27]InspID:2
		LogNewRecord(->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2; "TunnelInspection")
		
		TNL_SIA_Insp("SIA2INSP")
		
		PushChange(1; ->[TunnelInspection:152]Ceiling_Rtg_s:5)
		PushChange(1; ->[TunnelInspection:152]Cleanliness_Rtg_s:11)
		PushChange(1; ->[TunnelInspection:152]CrossPassage_Rtg_s:7)
		PushChange(1; ->[TunnelInspection:152]Egress_Rtg_s:8)
		PushChange(1; ->[TunnelInspection:152]Roadway_Rtg_s:4)
		PushChange(1; ->[TunnelInspection:152]Structural_Rtg_s:3)
		PushChange(1; ->[TunnelInspection:152]SupplyAirDuct_Rtg_s:6)
		PushChange(1; ->[TunnelInspection:152]UtilityRoom_Rtg_s:9)
		PushChange(1; ->[TunnelInspection:152]Wetness_Rtg_s:10)
		
		PushChange(1; ->[TunnelInspection:152]AirMeter_s:12)
		PushChange(1; ->[TunnelInspection:152]EscapeAir_s:13)
		PushChange(1; ->[TunnelInspection:152]ScissorLift_s:14)
		
		PushChange(1; ->[TunnelInspection:152]Ceiling_Prev_Rtg_s:18)
		PushChange(1; ->[TunnelInspection:152]Cleanliness_Prev_Rtg_s:24)
		PushChange(1; ->[TunnelInspection:152]CrossPassage_Prev_Rtg_s:20)
		PushChange(1; ->[TunnelInspection:152]Egress_Prev_Rtg_s:21)
		PushChange(1; ->[TunnelInspection:152]Roadway_Prev_Rtg_s:17)
		PushChange(1; ->[TunnelInspection:152]Structural_Prev_Rtg_s:16)
		PushChange(1; ->[TunnelInspection:152]SupplyAirDuct_Prev_Rtg_s:19)
		PushChange(1; ->[TunnelInspection:152]UtilityRoom_Prev_Rtg_s:22)
		PushChange(1; ->[TunnelInspection:152]Wetness_Prev_Rtg_s:23)
		
		FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
		[TunnelInspection:152]QA_QC_L:2:=TNL_QAQCEngr_L(String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60)))
		
		If ([TunnelInspection:152]QA_QC_L:2>0)
			LogLink(->[TunnelInspection:152]QA_QC_L:2; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2; ->[Personnel:42]Person ID:1)
		Else 
			LogChanges(->[TunnelInspection:152]QA_QC_L:2; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
		End if 
		
End case 

//End INSP_AddInspRecs