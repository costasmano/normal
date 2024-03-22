//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/24/10, 11:42:12
	// ----------------------------------------------------
	// Method: ut_loadRRElements
	
	// Description
	//  ` Import RR elements for RRO bridge Inspections
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
	//` RR
	Mods_2011_06  // CJ Miller`06/20/11, 10:31:28      ` Type all local variables for v11
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	vsForward:=<>Forward
	C_TEXT:C284($importFile_txt; $reportFile_txt; $Error_txt)
	C_TEXT:C284($Cat_txt; $Date_txt; $Desc_txt; $ElNo_txt; $fullLbl_txt; $FullLblArch_txt; $IsParent_txt; $modBy_txt; $Parent_txt; $Prefix_txt; $Part_txt)
	C_LONGINT:C283($ElNo_i; $Parent_i)  //Command Replaced was o_C_INTEGER
	C_DATE:C307($Date_d)
	C_BOOLEAN:C305($IsParent_b; $LogChanges_b)
	C_TIME:C306($Import_t; $report_t)
	C_LONGINT:C283($counter_L)
	$Import_t:=Open document:C264(""; "TEXT"; Read mode:K24:5)
	If (OK=1)
		CONFIRM:C162("Is there a header row"; "Yes"; "No")
		If (OK=1)
			RECEIVE PACKET:C104($Import_t; $Cat_txt; Char:C90(Carriage return:K15:38))
		End if 
		$importFile_txt:=Document
		CONFIRM:C162("Add Activity Log records for the new Elements?"; "ADD"; "NO")
		$LogChanges_b:=(OK=1)
		$reportFile_txt:=$importFile_txt+"_importReport"
		$report_t:=Create document:C266($reportFile_txt)
		SHORT_MESSAGE("Loading...")
		$counter_L:=0
		C_BOOLEAN:C305($DoneReading_b)
		$DoneReading_b:=False:C215
		While (Not:C34($DoneReading_b))
			RECEIVE PACKET:C104($Import_t; $Cat_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $Date_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $Desc_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $ElNo_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $fullLbl_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $FullLblArch_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $IsParent_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $modBy_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $Parent_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $Part_txt; <>sTab)
			RECEIVE PACKET:C104($Import_t; $Prefix_txt; <>sCR)
			$counter_L:=$counter_L+1
			MESSAGE:C88(String:C10($counter_L)+",")
			$Error_txt:=<>sTab+$Cat_txt+<>sTab+$Date_txt+<>sTab+$Desc_txt+<>sTab+$ElNo_txt+<>sTab+$fullLbl_txt+<>sTab+$FullLblArch_txt+<>sTab+$IsParent_txt+<>sTab+$modBy_txt+<>sTab+$Parent_txt+<>sTab+$Part_txt+<>sTab+$Prefix_txt+<>sCR
			$ElNo_i:=Num:C11($ElNo_txt)
			$Parent_i:=Num:C11($Parent_txt)
			$Date_d:=Date:C102($Date_txt)
			$IsParent_b:=($IsParent_txt="TRUE")
			$Desc_txt:=Replace string:C233($Desc_txt; <>sQU; "")
			If ($ElNo_i>0)
				QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=$ElNo_i)
				C_BOOLEAN:C305($ApplyChanges_b)
				$ApplyChanges_b:=False:C215
				If (Records in selection:C76([ElementDict:30])=1)
					If (ut_LoadRecordInteractive(->[ElementDict:30]))
						$ApplyChanges_b:=True:C214
					Else 
						CONFIRM:C162("Element Dictionary record for Element "+String:C10($ElNo_i)+" is locked!!! Continue?"; "Continue"; "Stop")
						$DoneReading_b:=(OK=0)
					End if 
					
				Else 
					CREATE RECORD:C68([ElementDict:30])
					[ElementDict:30]ElementNo:1:=$ElNo_i
					If ($LogChanges_b)
						LogNewRecord(->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 0; "ElementDict")
					End if 
					
					$ApplyChanges_b:=True:C214
					
				End if 
				If ($ApplyChanges_b)
					[ElementDict:30]Category:3:=$Cat_txt
					[ElementDict:30]DateCreated:6:=$Date_d
					[ElementDict:30]Description:2:=$Desc_txt
					[ElementDict:30]FullLabel:13:=$fullLbl_txt
					[ElementDict:30]FullLabelArch:14:=$FullLblArch_txt
					[ElementDict:30]IsParent:5:=$IsParent_b
					[ElementDict:30]ModifiedBy:10:=$modBy_txt
					[ElementDict:30]Parent:4:=$Parent_i
					[ElementDict:30]Part:12:=$Part_txt
					[ElementDict:30]Prefix:11:=$Prefix_txt
					If ($LogChanges_b)
						ARRAY POINTER:C280(ptr_Changes; 0; 0)
						InitChangeStack(1)
						PushChange(1; ->[ElementDict:30]Category:3)
						PushChange(1; ->[ElementDict:30]DateCreated:6)
						PushChange(1; ->[ElementDict:30]Description:2)
						PushChange(1; ->[ElementDict:30]FullLabel:13)
						PushChange(1; ->[ElementDict:30]FullLabelArch:14)
						PushChange(1; ->[ElementDict:30]IsParent:5)
						PushChange(1; ->[ElementDict:30]ModifiedBy:10)
						PushChange(1; ->[ElementDict:30]Parent:4)
						PushChange(1; ->[ElementDict:30]Part:12)
						PushChange(1; ->[ElementDict:30]Prefix:11)
						FlushGrpChgs(1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; ->[ElementDict:30]ElementNo:1; 0)
					End if 
					SAVE RECORD:C53([ElementDict:30])
				End if 
				
			Else 
				If (OK=0)
					$DoneReading_b:=True:C214
				Else 
					SEND PACKET:C103($report_t; "Bad Element at ["+$Error_txt)
					CONFIRM:C162("Bad Element at ["+$Error_txt; "Continue"; "Stop")
					$DoneReading_b:=(OK=0)
				End if 
				
			End if 
			
		End while 
		CLOSE DOCUMENT:C267($report_t)
		CLOSE WINDOW:C154
	End if 
	CLOSE DOCUMENT:C267($Import_t)
End if 