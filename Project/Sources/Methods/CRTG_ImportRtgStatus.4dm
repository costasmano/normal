//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/13/10, 19:51:00
	// ----------------------------------------------------
	// Method: CRTG_ImportRtgStatus
	// Description
	//  ` import data from the Rating Status spreadsheet
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_06
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($task_txt; $Match_txt)
C_TEXT:C284(CRTGIMP_Here_txt; CRTGIMP_RecentD_txt; CRTGIMP_BrNo_txt; CRTGIMP_colo_txt; CRTGIMP_cons_txt; CRTGIMP_Rec1_txt; CRTGIMP_Rec2_txt; CRTGIMP_Rec3_txt; CRTGIMP_Rec4_txt; CRTGIMP_Ret1_txt; CRTGIMP_Ret2_txt; CRTGIMP_Ret3_txt; CRTGIMP_Ret4_txt; CRTGIMP_proc_txt; CRTGIMP_Repmo_txt; CRTGIMP_type_txt)
C_TIME:C306(CRTGIMP_Import_t; CRTGIMP_report_t)
C_TEXT:C284($importFile_txt; $reportFile_txt; CRTGIMP_Error_txt)
C_DATE:C307($Rec1_d; $rec2_d; $rec3_d; $rec4_d; $Ret1_d; $ret2_d; $ret3_d; $ret4_d; $proc_d; $Repmo_d; $chk_Ret2_d; $Achk_Ret2_d)
C_DATE:C307($chk_Rec1_d; $chk_rec2_d; $chk_rec3_d; $chk_rec4_d; $chk_Ret1_d; $chk_re22_d; $chk_ret3_d; $chk_ret4_d; $chk_proc_d)
C_DATE:C307($Achk_Rec1_d; $Achk_rec2_d; $Achk_rec3_d; $Achk_rec4_d; $Achk_Ret1_d; $Achk_re22_d; $Achk_ret3_d; $Achk_ret4_d; $Achk_proc_d)
C_TEXT:C284($Achk_Color_txt)
C_LONGINT:C283($Paren_L; $Counter_L; $TotalSize_L)
C_TEXT:C284($Chg_txt; $matchRec_txt; $ChgType_txt)
C_TEXT:C284($BIN_txt)
$task_txt:="RUN"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$task_txt:=$1
End if 

Case of 
	: ($task_txt="COMPARE")
		C_POINTER:C301($2; $3; $5; $6; $7)
		C_TEXT:C284($4)
		If (($2->)#($3->))
			Case of 
				: (Type:C295($5->)=Is date:K8:7)
					$7->:=$7->+$4+String:C10($5->)+"#"+String:C10($6->)
					If ($6->=!00-00-00!)  //make change only when db data is "null"
						$6->:=$5->
						$7->:=$7->+" !!!"
					End if 
					$7->:=$7->+<>sTAB
					
				: (Type:C295($5->)=Is text:K8:3) | (Type:C295($5->)=Is string var:K8:2)
					$7->:=$7->+$4+$5->+"#"+$6->+<>sTAB
					
			End case 
			
		Else 
		End if 
		
	: ($task_txt="ADDTOMILES")
		C_POINTER:C301($2)
		If ($2->#!00-00-00!)
			APPEND TO ARRAY:C911(CRTGIMP_milestoneDates_ad; $2->)
			APPEND TO ARRAY:C911(CRTGIMP_Milestones_atxt; Field name:C257($2))
		End if 
		
		
	: ($task_txt="CHECKRATING")
		C_POINTER:C301($2)
		
		$2->:=""
		ARRAY DATE:C224(CRTGIMP_milestoneDates_ad; 0)
		ARRAY TEXT:C222(CRTGIMP_Milestones_atxt; 0)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]RepSubmit1:23)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentInHouseRev1:36)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentBackToConslt1:33)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]RepSubmit2:31)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentInHouseRev2:37)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentBackToConslt2:34)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]RepSubmit3:41)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentInHouseRev3:38)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentBackToConslt3:35)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]RepSubmit4:52)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentInHouseRev4:53)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]SentBackToConslt4:62)
		CRTG_ImportRtgStatus("ADDTOMILES"; ->[Conslt Rating:63]NBISLetter:26)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; Size of array:C274(CRTGIMP_milestoneDates_ad))
			If (CRTGIMP_milestoneDates_ad{$loop_L}<CRTGIMP_milestoneDates_ad{$loop_L-1})
				$2->:=$2->+" "+CRTGIMP_Milestones_atxt{$loop_L}+"("+String:C10(CRTGIMP_milestoneDates_ad{$loop_L})+") less "+CRTGIMP_Milestones_atxt{$loop_L-1}+"("+String:C10(CRTGIMP_milestoneDates_ad{$loop_L-1})+")"
			End if 
			
		End for 
		
	: ($task_txt="LOADRECORD")
		$Rec1_d:=Date:C102(CRTGIMP_Rec1_txt)
		$rec2_d:=Date:C102(CRTGIMP_Rec2_txt)
		$rec3_d:=Date:C102(CRTGIMP_Rec3_txt)
		$rec4_d:=Date:C102(CRTGIMP_Rec4_txt)
		$Ret1_d:=Date:C102(CRTGIMP_Ret1_txt)
		$ret2_d:=Date:C102(CRTGIMP_Ret2_txt)
		$ret3_d:=Date:C102(CRTGIMP_Ret3_txt)
		$ret4_d:=Date:C102(CRTGIMP_Ret4_txt)
		$proc_d:=Date:C102(CRTGIMP_proc_txt)
		$Repmo_d:=Date:C102(CRTGIMP_Repmo_txt)
		$chk_Rec1_d:=Add to date:C393(!00-00-00!; Year of:C25($Rec1_d); Month of:C24($Rec1_d); 1)
		$chk_Rec2_d:=Add to date:C393(!00-00-00!; Year of:C25($rec2_d); Month of:C24($rec2_d); 1)
		$chk_Rec3_d:=Add to date:C393(!00-00-00!; Year of:C25($rec3_d); Month of:C24($rec3_d); 1)
		$chk_Rec4_d:=Add to date:C393(!00-00-00!; Year of:C25($rec4_d); Month of:C24($rec4_d); 1)
		$chk_Ret1_d:=Add to date:C393(!00-00-00!; Year of:C25($Ret1_d); Month of:C24($Ret1_d); 1)
		$chk_Ret2_d:=Add to date:C393(!00-00-00!; Year of:C25($ret2_d); Month of:C24($ret2_d); 1)
		$chk_Ret3_d:=Add to date:C393(!00-00-00!; Year of:C25($ret3_d); Month of:C24($ret3_d); 1)
		$chk_Ret4_d:=Add to date:C393(!00-00-00!; Year of:C25($ret4_d); Month of:C24($ret4_d); 1)
		$chk_proc_d:=Add to date:C393(!00-00-00!; Year of:C25($proc_d); Month of:C24($proc_d); 1)
		$Chg_txt:=""
		If (ut_LoadRecordInteractive(->[Conslt Rating:63]))
			$Achk_Rec1_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentInHouseRev1:36); Month of:C24([Conslt Rating:63]SentInHouseRev1:36); 1)
			$Achk_Rec2_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentInHouseRev2:37); Month of:C24([Conslt Rating:63]SentInHouseRev2:37); 1)
			$Achk_Rec3_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentInHouseRev3:38); Month of:C24([Conslt Rating:63]SentInHouseRev3:38); 1)
			$Achk_Rec4_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentInHouseRev4:53); Month of:C24([Conslt Rating:63]SentInHouseRev4:53); 1)
			$Achk_Ret1_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentBackToConslt1:33); Month of:C24([Conslt Rating:63]SentBackToConslt1:33); 1)
			$Achk_Ret2_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentBackToConslt2:34); Month of:C24([Conslt Rating:63]SentBackToConslt2:34); 1)
			$Achk_Ret3_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentBackToConslt3:35); Month of:C24([Conslt Rating:63]SentBackToConslt3:35); 1)
			$Achk_Ret4_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]SentBackToConslt4:62); Month of:C24([Conslt Rating:63]SentBackToConslt4:62); 1)
			$Achk_proc_d:=Add to date:C393(!00-00-00!; Year of:C25([Conslt Rating:63]NBISLetter:26); Month of:C24([Conslt Rating:63]NBISLetter:26); 1)
			$Achk_Color_txt:=Substring:C12([Conslt Rating:63]CRtgColor:46; 1; 1)
			$matchRec_txt:=" < "+[Conslt Rating:63]AssignRatCons:5+" Rec1: "+String:C10([Conslt Rating:63]SentInHouseRev1:36)+" NBILet :"+String:C10([Conslt Rating:63]NBISLetter:26)+"> "+<>sTAB
			InitChangeStack(1)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Color_txt; ->CRTGIMP_colo_txt; "colo_txt "; ->CRTGIMP_colo_txt; ->$Achk_Color_txt; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_proc_d; ->$chk_proc_d; "proc "; ->$proc_d; ->[Conslt Rating:63]NBISLetter:26; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Rec1_d; ->$chk_Rec1_d; "Rec1 "; ->$Rec1_d; ->[Conslt Rating:63]SentInHouseRev1:36; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Ret1_d; ->$chk_Ret1_d; "Ret1 "; ->$Ret1_d; ->[Conslt Rating:63]SentBackToConslt1:33; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Rec2_d; ->$chk_Rec2_d; "Rec2 "; ->$Rec2_d; ->[Conslt Rating:63]SentInHouseRev2:37; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Ret2_d; ->$chk_Ret2_d; "Ret2 "; ->$Ret2_d; ->[Conslt Rating:63]SentBackToConslt2:34; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Rec3_d; ->$chk_Rec3_d; "Rec3 "; ->$Rec3_d; ->[Conslt Rating:63]SentInHouseRev3:38; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Ret3_d; ->$chk_Ret3_d; "Ret3 "; ->$Ret3_d; ->[Conslt Rating:63]SentBackToConslt3:35; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Rec4_d; ->$chk_Rec4_d; "Rec4 "; ->$Rec4_d; ->[Conslt Rating:63]SentInHouseRev4:53; ->$Chg_txt)
			CRTG_ImportRtgStatus("COMPARE"; ->$Achk_Ret4_d; ->$chk_Ret4_d; "Ret4 "; ->$Ret4_d; ->[Conslt Rating:63]SentBackToConslt4:62; ->$Chg_txt)
			[Conslt Rating:63]BridgeType:63:=CRTGIMP_type_txt
			[Conslt Rating:63]ReportDate:64:=Date:C102(CRTGIMP_Repmo_txt)
			PushChange(1; ->[Conslt Rating:63]BridgeType:63)
			PushChange(1; ->[Conslt Rating:63]ReportDate:64)
			CRTG_RecentAction(->[Conslt Rating:63]RecentAction:71; ->[Conslt Rating:63]IsRtgHere:70)
			PushChange(1; ->[Conslt Rating:63]RecentAction:71)
			PushChange(1; ->[Conslt Rating:63]IsRtgHere:70)
			$ChgType_txt:=""
			If ($Chg_txt#"")
				If (Position:C15("colo_txt "; $Chg_txt)>0)
					$ChgType_txt:="ColorDiff "
				End if 
				If (Position:C15("!!!"; $Chg_txt)>0)
					$ChgType_txt:=$ChgType_txt+"DB Change "
				End if 
				SEND PACKET:C103(CRTGIMP_report_t; "Data Diff "+$ChgType_txt+" for BIN at "+<>sTAB+CRTGIMP_Error_txt+<>sTAB+$matchRec_txt+$Chg_txt)
			Else 
				SEND PACKET:C103(CRTGIMP_report_t; "No Diffs for BIN at "+<>sTAB+CRTGIMP_Error_txt+<>sTAB+$matchRec_txt)
			End if 
			CRTG_ImportRtgStatus("CHECKRATING"; ->$ChgType_txt)
			If ($ChgType_txt#"")
				SEND PACKET:C103(CRTGIMP_report_t; (<>sTAB+$ChgType_txt))
			End if 
			SEND PACKET:C103(CRTGIMP_report_t; <>sCR)
			If (CRTGIMP_SaveChanges_b)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Conslt Rating:63]BIN:1; ->[Conslt Rating:63]ConsltRatingID:42; 1)
				OK:=1
				SAVE RECORD:C53([Conslt Rating:63])
			End if 
		Else 
			SEND PACKET:C103(CRTGIMP_report_t; "Could not load record for "+<>sTAB+CRTGIMP_Error_txt+<>sCR)
		End if 
		
	: ($task_txt="RUN")
		READ ONLY:C145(*)
		CRTGIMP_Import_t:=Open document:C264(""; "TEXT")
		If (OK=1)
			$importFile_txt:=Document
			$reportFile_txt:=$importFile_txt+"_importReport"
			CRTGIMP_report_t:=Create document:C266($reportFile_txt)
			<>ProgressPID:=StartProgress("Rating Import"; "NONE"; "Reading Import Data"; "# Bytes Remaining")
			$Counter_L:=0
			$TotalSize_L:=Get document size:C479($importFile_txt)
			ARRAY POINTER:C280(ptr_changes; 0; 0)
			UpdateProgress(1; $TotalSize_L)
			CONFIRM:C162("SAVE CHANGES TO DB?"; "SAVE"; "Don't SAVE")
			C_BOOLEAN:C305(CRTGIMP_SaveChanges_b)
			CRTGIMP_SaveChanges_b:=(OK=1)
			SEND PACKET:C103(CRTGIMP_report_t; "MsgTYpe"+<>sTAB+"CRTGIMP_BrNo_txt"+<>sTab+"CRTGIMP_Here_txt"+<>sTab+"CRTGIMP_RecentD_txt"+<>sTab+"CRTGIMP_Rec1_txt"+<>sTab+"CRTGIMP_colo_txt"+<>sTab+"CRTGIMP_cons_txt"+<>sTab+"CRTGIMP_Repmo_txt")
			SEND PACKET:C103(CRTGIMP_report_t; <>sTAB+"C1"+<>sTAB+"C2"+<>sTAB+"C3"+<>sTAB+"C4"+<>sTAB+"C5"+<>sTAB+"C6"+<>sTAB+"C7"+<>sTAB+"C8"+<>sTAB+"C9"+<>sCR)
			While (OK=1)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Here_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_RecentD_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_BrNo_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_colo_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_cons_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Rec1_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Rec2_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Rec3_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Rec4_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Ret1_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Ret2_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Ret3_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Ret4_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_proc_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_Repmo_txt; <>sTab)
				RECEIVE PACKET:C104(CRTGIMP_Import_t; CRTGIMP_type_txt; <>sCR)
				$Counter_L:=$Counter_L+Length:C16(CRTGIMP_Here_txt+CRTGIMP_RecentD_txt+CRTGIMP_BrNo_txt+CRTGIMP_colo_txt+CRTGIMP_cons_txt)+Length:C16(CRTGIMP_Rec1_txt+CRTGIMP_Rec2_txt+CRTGIMP_Rec3_txt+CRTGIMP_Rec4_txt)+Length:C16(CRTGIMP_Ret1_txt+CRTGIMP_Ret2_txt+CRTGIMP_Ret3_txt+CRTGIMP_Ret4_txt)+Length:C16(CRTGIMP_proc_txt+CRTGIMP_Repmo_txt+CRTGIMP_type_txt)+16
				UpdateProgress($Counter_L; $TotalSize_L)
				CRTGIMP_Here_txt:=Replace string:C233(CRTGIMP_Here_txt; " "; "")
				CRTGIMP_RecentD_txt:=Replace string:C233(CRTGIMP_RecentD_txt; " "; "")
				CRTGIMP_colo_txt:=Replace string:C233(CRTGIMP_colo_txt; " "; "")
				CRTGIMP_Rec1_txt:=Replace string:C233(CRTGIMP_Rec1_txt; " "; "")
				CRTGIMP_Rec2_txt:=Replace string:C233(CRTGIMP_Rec2_txt; " "; "")
				CRTGIMP_Rec2_txt:=Replace string:C233(CRTGIMP_Rec2_txt; " "; "")
				CRTGIMP_Rec4_txt:=Replace string:C233(CRTGIMP_Rec4_txt; " "; "")
				CRTGIMP_Ret1_txt:=Replace string:C233(CRTGIMP_Ret1_txt; " "; "")
				CRTGIMP_Ret2_txt:=Replace string:C233(CRTGIMP_Ret2_txt; " "; "")
				CRTGIMP_Ret3_txt:=Replace string:C233(CRTGIMP_Ret3_txt; " "; "")
				CRTGIMP_Ret4_txt:=Replace string:C233(CRTGIMP_Ret4_txt; " "; "")
				CRTGIMP_proc_txt:=Replace string:C233(CRTGIMP_proc_txt; " "; "")
				CRTGIMP_Repmo_txt:=Replace string:C233(CRTGIMP_Repmo_txt; " "; "")
				CRTGIMP_Error_txt:=CRTGIMP_BrNo_txt+<>sTab+CRTGIMP_Here_txt+<>sTab+CRTGIMP_RecentD_txt+<>sTab+CRTGIMP_Rec1_txt+<>sTab+CRTGIMP_colo_txt+<>sTab+CRTGIMP_cons_txt+<>sTab+CRTGIMP_Repmo_txt
				//find valid bin
				$Paren_L:=Position:C15("("; CRTGIMP_BrNo_txt)
				If (($Paren_L>0) & (CRTGIMP_Here_txt#"C"))
					$BIN_txt:=Substring:C12(CRTGIMP_BrNo_txt; ($Paren_L+1); 3)
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_txt)
					If (Records in selection:C76([Bridge MHD NBIS:1])=1)
						QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]BIN:1=$BIN_txt)
						Case of 
							: (Records in selection:C76([Conslt Rating:63])=0)
								SEND PACKET:C103(CRTGIMP_report_t; "No Rating Record at "+<>sTab+CRTGIMP_Error_txt+<>sCR)
							: (Records in selection:C76([Conslt Rating:63])=1)
								CRTG_ImportRtgStatus("LOADRECORD")
								
							: (Records in selection:C76([Conslt Rating:63])>1)
								SEND PACKET:C103(CRTGIMP_report_t; "Multiple rating records "+String:C10(Records in selection:C76([Conslt Rating:63]))+" for BIN at "+<>sTAB+CRTGIMP_Error_txt+<>sTAB)
								FIRST RECORD:C50([Conslt Rating:63])
								$Match_txt:=<>sTab
								ARRAY TEXT:C222($Matches_atxt; Records in selection:C76([Conslt Rating:63]))
								ARRAY DATE:C224($SentInH1_ad; Records in selection:C76([Conslt Rating:63]))
								ARRAY LONGINT:C221($DateDiff_aL; Records in selection:C76([Conslt Rating:63]))
								ARRAY LONGINT:C221($RatingRecs_aL; Records in selection:C76([Conslt Rating:63]))
								While (Not:C34(End selection:C36([Conslt Rating:63])))
									$Matches_atxt{Selected record number:C246([Conslt Rating:63])}:=" < "+[Conslt Rating:63]AssignRatCons:5+" Rec1: "+String:C10([Conslt Rating:63]SentInHouseRev1:36)+" NBILet :"+String:C10([Conslt Rating:63]NBISLetter:26)+"> "+<>sTAB
									$SentInH1_ad{Selected record number:C246([Conslt Rating:63])}:=[Conslt Rating:63]SentInHouseRev1:36
									$DateDiff_aL{Selected record number:C246([Conslt Rating:63])}:=Abs:C99([Conslt Rating:63]SentInHouseRev1:36-Date:C102(CRTGIMP_Rec1_txt))
									$RatingRecs_aL{Selected record number:C246([Conslt Rating:63])}:=Selected record number:C246([Conslt Rating:63])
									NEXT RECORD:C51([Conslt Rating:63])
								End while 
								SORT ARRAY:C229($DateDiff_aL; $Matches_atxt; $RatingRecs_aL)
								If ($DateDiff_aL{1}<5)
									$Match_txt:="Match!"+<>sTab
								End if 
								SEND PACKET:C103(CRTGIMP_report_t; $Match_txt)
								C_LONGINT:C283($loop_L)
								For ($loop_L; 1; Size of array:C274($Matches_atxt))
									SEND PACKET:C103(CRTGIMP_report_t; $Matches_atxt{$loop_L})
								End for 
								SEND PACKET:C103(CRTGIMP_report_t; <>sCR)
								If ($Match_txt="Match@")
									GOTO SELECTED RECORD:C245([Conslt Rating:63]; $RatingRecs_aL{1})
									CRTG_ImportRtgStatus("LOADRECORD")
								End if 
								
							Else 
								
						End case 
						
					Else 
						SEND PACKET:C103(CRTGIMP_report_t; "Bad BIN at "+<>sTab+CRTGIMP_Error_txt+<>sCR)
					End if 
					
				End if 
				UNLOAD RECORD:C212([Conslt Rating:63])
			End while 
			POST OUTSIDE CALL:C329(<>ProgressPID)
			CLOSE DOCUMENT:C267(CRTGIMP_report_t)
		End if 
		CLOSE DOCUMENT:C267(CRTGIMP_Import_t)
		READ WRITE:C146(*)
		
	: ($task_txt="UPDATERECENTACTION")
		//All by itself to update the [Conslt Rating]RecentAction and [Conslt Rating]IsRtgHere fields
		ALL RECORDS:C47([Conslt Rating:63])
		QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]AssignStatus:43="Active"; *)
		QUERY:C277([Conslt Rating:63];  | ; [Conslt Rating:63]AssignStatus:43="Completed"; *)
		QUERY SELECTION:C341([Conslt Rating:63]; [Conslt Rating:63]IsRtgHere:70="")
		FIRST RECORD:C50([Conslt Rating:63])
		While (Not:C34(End selection:C36([Conslt Rating:63])))
			If (ut_LoadRecordInteractive(->[Conslt Rating:63]))
				CRTG_RecentAction(->[Conslt Rating:63]RecentAction:71; ->[Conslt Rating:63]IsRtgHere:70)
				If ([Conslt Rating:63]RecentAction:71#Old:C35([Conslt Rating:63]RecentAction:71)) | ([Conslt Rating:63]IsRtgHere:70#Old:C35([Conslt Rating:63]IsRtgHere:70))
					SAVE RECORD:C53([Conslt Rating:63])
				End if 
			End if 
			NEXT RECORD:C51([Conslt Rating:63])
		End while 
		
End case 