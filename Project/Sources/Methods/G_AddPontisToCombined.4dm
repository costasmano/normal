//%attributes = {"invisible":true}
If (False:C215)
	Mods_2005_CM06
	Mods_2005_CM09
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(4/19/2006 15:50:10)
	Mods_2006_CMy2
	// Modified by: Costas Manousakis-(Designer)-(4/10/14 16:36:36)
	Mods_2014_04
	//  `removed check for app version (◊LNK_CHANGE_Vers ) - use LogLink for all cases
	// Modified by: Costas Manousakis-(Designer)-(3/23/15 16:53:51)
	Mods_2015_03
	//  `do Link entries only if values are > 0
End if 

//Do a check first
If ([Combined Inspections:90]BMSInspID:3>0)
	ALERT:C41("There is already a Pontis inspection!")
Else 
	SET CURSOR:C469(4)
	CREATE RECORD:C68([BMS Inspections:44])
	Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
	[Combined Inspections:90]BMSInspID:3:=[BMS Inspections:44]Inspection ID:1
	
	[BMS Inspections:44]BIN:2:=[Bridge MHD NBIS:1]BIN:3
	[BMS Inspections:44]Insp Date:4:=[Combined Inspections:90]InspDate:4
	[BMS Inspections:44]Span Group No:3:=1
	[BMS Inspections:44]Metric:14:=False:C215  //Change this default after all old inspections are entered.
	[BMS Inspections:44]Agency:13:=[Inspections:27]Agency:156
	[BMS Inspections:44]TeamLeader:6:=[Inspections:27]TeamLeader:4
	[BMS Inspections:44]DBrInspEngr:5:=[Inspections:27]DBrInspEngr:3
	TimeStamp_ut(->[BMS Inspections:44]; ->[BMS Inspections:44]DateCreated:8; ->[BMS Inspections:44]TimeCreated:9; ->[BMS Inspections:44]DateModified:10; ->[BMS Inspections:44]TimeModified:11)
	[BMS Inspections:44]Modified By:7:=Current user:C182
	
	//This record must be saved at the beginning to prevent [Cond Units] records
	//from being orphaned by a cancel.
	//Implementing transactions might be a better method.
	SAVE RECORD:C53([BMS Inspections:44])
	SAVE RECORD:C53([Combined Inspections:90])
	
	//Record the log.
	LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; "Pontis Insp ID")
	//This is a relative field
	LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
	InitChangeStack(3)
	PushChange(3; ->[BMS Inspections:44]Insp Date:4)
	PushChange(3; ->[BMS Inspections:44]Span Group No:3)
	PushChange(3; ->[BMS Inspections:44]Modified By:7)
	PushChange(3; ->[BMS Inspections:44]DateCreated:8)
	PushChange(3; ->[BMS Inspections:44]TimeCreated:9)
	PushChange(3; ->[BMS Inspections:44]Metric:14)
	PushChange(3; ->[BMS Inspections:44]Agency:13)
	FlushGrpChgs(3; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
	//these must be as LNK records.
	If ([BMS Inspections:44]DBrInspEngr:5>0)
		LogLink(->[BMS Inspections:44]DBrInspEngr:5; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
	End if 
	If ([BMS Inspections:44]TeamLeader:6>0)
		LogLink(->[BMS Inspections:44]TeamLeader:6; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
	End if 
	
	ARRAY INTEGER:C220($aInspTmMbrIDs; 0)
	C_LONGINT:C283($i)
	SELECTION TO ARRAY:C260([Field Trip:43]Person ID:2; $aInspTmMbrIDs)
	For ($i; 1; Size of array:C274($aInspTmMbrIDs))
		CREATE RECORD:C68([BMS Field Trip:56])
		[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
		[BMS Field Trip:56]Person ID:2:=$aInspTmMbrIDs{$i}
		LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
		SAVE RECORD:C53([BMS Field Trip:56])
	End for 
	//enable buttons
	OBJECT SET ENABLED:C1123(tbMetric; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(tbEnglish; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(bAddCU; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	//disable  the Add Pontis button
	OBJECT SET ENABLED:C1123(*; "DE AddPontis@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	//Enable the Copy Elements button
	OBJECT SET ENABLED:C1123(*; "DE CopyPontisInspection@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	SET CURSOR:C469(0)
End if 