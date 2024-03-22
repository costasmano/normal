//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/29/07, 16:21:18
	// ----------------------------------------------------
	// Method: INSP_DiveDates2SIA
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/18/07 20:48:15)
	Mods_2007_CM_5401
End if 
C_BOOLEAN:C305($RecordLoaded_b; $Save93B_b; $SaveUW_SpeC_b)
$SaveUW_SpeC_b:=False:C215
$Save93B_b:=False:C215
C_TEXT:C284($msg)
$msg:="Approving an "+[Inspection Type:31]Description:2+" Inspection - "
Case of 
	: (([Inspections:27]Insp Type:6="DVE") | ([Inspections:27]Insp Type:6="DVL"))  //Dive Routine or LowCL Inspection
		//save related data to BIN
		$Save93B_b:=True:C214
		If ([Bridge MHD NBIS:1]UWSpInspFreq:213>0)
			//if there is a spec memb freq. save the routine date as a spec memb also         
			$SaveUW_SpeC_b:=True:C214
			$msg:=$msg+"Saving Item93B and UW Special Memb. Insp date to NBI Record BIN : "
		Else 
			$msg:=$msg+"Saving Item93B to NBI Record BIN : "
		End if 
		
	: ([Inspections:27]Insp Type:6="DVS")  //Dive Spec Memb Inspection
		//save related data to BIN
		$SaveUW_SpeC_b:=True:C214
		$msg:=$msg+" Saving UW Spec Member Date to NBI record BIN : "
		
End case 

$msg:=$msg+[Bridge MHD NBIS:1]BIN:3+" BDEPT : "+[Bridge MHD NBIS:1]BDEPT:1
//must save NBI record
$RecordLoaded_b:=ut_LoadRecordInteractive(->[Bridge MHD NBIS:1])
If ($RecordLoaded_b)
	ALERT:C41($msg)
	InitChangeStack(1)
	If ($Save93B_b)
		[Bridge MHD NBIS:1]Item93B:170:=[Inspections:27]Insp Date:78
		PushChange(1; ->[Bridge MHD NBIS:1]Item93B:170)
	End if 
	If ($SaveUW_SpeC_b)
		[Bridge MHD NBIS:1]UWSpInspDate:214:=[Inspections:27]Insp Date:78
		PushChange(1; ->[Bridge MHD NBIS:1]UWSpInspDate:214)
	End if 
	If (INSP_CheckSpcMfrFreq("UW"))
		PushChange(1; ->[Bridge MHD NBIS:1]UWSpInsp:212)
		PushChange(1; ->[Bridge MHD NBIS:1]UWSpInspFreq:213)
	End if 
	
	FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
	
	SAVE RECORD:C53([Bridge MHD NBIS:1])
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
Else 
	C_TEXT:C284($MSG_TXT)
	$MSG_TXT:="COULD NOT LOAD BRIDGE RECORD WITH WRITE ACCESS !!!"+<>SCR
	$MSG_TXT:=$MSG_TXT+"CHANGES WERE NOT TRANSFERED AND HAVE TO BE DO"+"NE MANUALLY!!"
	ALERT:C41($MSG_TXT)
End if 