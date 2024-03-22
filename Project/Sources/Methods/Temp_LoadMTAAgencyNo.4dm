//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/08/06, 09:51:56
	// ----------------------------------------------------
	// Method: Temp_LoadMTAAgencyNo
	// Description
	// Load from file with two tab-separated columns of
	// BIN and Agency Number from the turnpike
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
If (Current user:C182="Designer")
	C_TIME:C306($dImportFile; $dImportRpt)
	C_TEXT:C284($tBIN; $tAgencyNo)
	C_LONGINT:C283($RecsRead; $RecsUpd; $RecsErr)
	$dImportFile:=Open document:C264(""; "TEXT")  //prompt user for input file
	$RecsRead:=0
	$RecsUpd:=0
	$RecsErr:=0
	If (OK=1)
		
		CUT NAMED SELECTION:C334([Bridge MHD NBIS:1]; "PREMTAIMPORT")
		$dImportRpt:=Create document:C266(Document+".log")
		//_ O _SET DOCUMENT TYPE(Document;"TEXT")
		//_ O _SET DOCUMENT CREATOR(Document;"!Rch")
		RECEIVE PACKET:C104($dImportFile; $tBIN; <>sTAB)
		While (Ok=1)
			$RecsRead:=$RecsRead+1
			RECEIVE PACKET:C104($dImportFile; $tAgencyNo; <>sCR)
			SEND PACKET:C103($dImportRpt; ($tBIN+<>sTAB+$tAgencyNo+<>sTAB))
			If (Length:C16($tBIN)>3)
				$tBIN:=Substring:C12($tBIN; (1+Length:C16($tBIN)-3))
			End if 
			
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$tBIN)
			Case of 
				: (Records in selection:C76([Bridge MHD NBIS:1])=0)
					SEND PACKET:C103($dImportRpt; ("Not found!!"+<>sCR))
					$RecsErr:=$RecsErr+1
				: (Records in selection:C76([Bridge MHD NBIS:1])>1)
					$RecsErr:=$RecsErr+1
					SEND PACKET:C103($dImportRpt; ("Too many found!!"+<>sCR))
				: ([Bridge MHD NBIS:1]InspResp:173#"MTA")
					$RecsErr:=$RecsErr+1
					SEND PACKET:C103($dImportRpt; ("Found non-MTA!!"+<>sCR))
				: ((Records in selection:C76([Bridge MHD NBIS:1])=1) & ([Bridge MHD NBIS:1]InspResp:173="MTA"))
					$tAgencyNo:=Substring:C12(f_TrimStr($tAgencyNo; True:C214; True:C214); 1; 20)
					If ([Bridge MHD NBIS:1]AgencyBrNo:209=$tAgencyNo)
						SEND PACKET:C103($dImportRpt; ([Bridge MHD NBIS:1]AgencyBrNo:209+<>sTAB+$tAgencyNo+<>sTAB+"NO CHANGE"+<>sCR))
					Else 
						$RecsUpd:=$RecsUpd+1
						SEND PACKET:C103($dImportRpt; ([Bridge MHD NBIS:1]AgencyBrNo:209+<>sTAB+$tAgencyNo+<>sTAB+"OK"+<>sCR))
						InitChangeStack(1)
						[Bridge MHD NBIS:1]AgencyBrNo:209:=$tAgencyNo
						PushChange(1; ->[Bridge MHD NBIS:1]AgencyBrNo:209)
						FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
						SAVE RECORD:C53([Bridge MHD NBIS:1])
					End if 
					
				Else 
					SEND PACKET:C103($dImportRpt; ("Something else wrong!!!"+<>sCR))
					
			End case 
			RECEIVE PACKET:C104($dImportFile; $tBIN; <>sTAB)
		End while 
		
		CLOSE DOCUMENT:C267($dImportFile)
		CLOSE DOCUMENT:C267($dImportRpt)
		USE NAMED SELECTION:C332("PREMTAIMPORT")
		ALERT:C41("Read "+String:C10($RecsRead)+" lines - Updated "+String:C10($RecsUpd)+" records - There were Errors "+String:C10($RecsErr))
	End if 
	
End if 