//%attributes = {"invisible":true}
//Method: INSP_WPConversionLoop
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/17/21, 17:02:32
	// ----------------------------------------------------
	//Created : 
	//Mods_2021_06
	
	//creates processes launching method :
	INSP_ConvertInspections
End if 
//

READ ONLY:C145(*)
ALL RECORDS:C47([Inspections:27])
ORDER BY:C49([Inspections:27]; [Inspections:27]InspID:2; >)

C_BOOLEAN:C305($Complete_B; $ProcessComplete_B; $CanStart1_B; $CanStart2_B; $oneDone_b)
C_LONGINT:C283($Start_L; $Stop_L; $Count_L; $ProcessID1_L; $ProcessID2_L; $ProcessState1_L; $ProcessState2_L; $ProcessID_L; $NumConcurrent; $processCount_L)
C_TEXT:C284($ProcessName1_txt; $ProcessName2_txt)

C_TIME:C306($ProcessTime1_tm; $ProcessTime2_tm)
C_BOOLEAN:C305($Go_b)
$Count_L:=Num:C11(Request:C163("group inspections by "; "2000"))
$Go_b:=(OK=1) & ($Count_L>0)
$NumConcurrent:=Num:C11(Request:C163("number concurrent processes"; "4"))
$Go_b:=$Go_b & (OK=1) & ($NumConcurrent>0)
$Start_L:=Num:C11(Request:C163("# records "+String:C10(Records in selection:C76([Inspections:27]))+", start from record # "; "1"))
$Go_b:=$Go_b & (OK=1)

If (Not:C34($Go_b))
	ALERT:C41("Canceled out of one of the requests or a required value was zero or less! Aborting")
Else 
	If ($Start_L>0)
	Else 
		ALERT:C41("Starting record # set to 1")
		$Start_L:=1
	End if 
	
	ARRAY BOOLEAN:C223($ConvStart_ab; $NumConcurrent)
	ARRAY LONGINT:C221($procIDs_aL; $NumConcurrent)
	ARRAY TEXT:C222($ProcNames_atxt; $NumConcurrent)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ConvStart_ab))
		$ConvStart_ab{$loop_L}:=True:C214
	End for 
	
	$Complete_B:=False:C215
	$processCount_L:=0
	C_BLOB:C604($RecsBlob_x)
	//start the bar
	C_OBJECT:C1216($progress_o)
	C_LONGINT:C283($loopCount_L; $numRecs_L)
	$numRecs_L:=(Records in selection:C76([Inspections:27])-$Start_L+1)
	$loopCount_L:=$numRecs_L\$Count_L
	If ($numRecs_L%$Count_L>0)
		$loopCount_L:=$loopCount_L+1
	End if 
	$progress_o:=ProgressNew("WP Conversion Loop"; $loopCount_L; True:C214; " group"; 3)
	
	C_TEXT:C284($logFolder_txt; $logFile_txt)
	$logFolder_txt:=System folder:C487(Documents folder:K41:18)+"WPConversion"
	If (Test path name:C476($logFolder_txt)#Is a folder:K24:2)
		CREATE FOLDER:C475($logFolder_txt)
	End if 
	$logFile_txt:=$logFolder_txt+Folder separator:K24:12+Current method name:C684+"-"+\
		Replace string:C233(String:C10(Current date:C33; ISO date:K1:8; Current time:C178); ":"; "-")+".csv"
	C_TIME:C306($logfile_t)
	$logfile_t:=Create document:C266($logFile_txt)
	SEND PACKET:C103($logfile_t; "Number of inspection records,"+String:C10(Records in selection:C76([Inspections:27]))+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103($logfile_t; "start from rec #,"+String:C10($Start_L)+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103($logfile_t; "grouped by,"+String:C10($Count_L)+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103($logfile_t; "# concurrent proc,"+String:C10($NumConcurrent)+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103($logfile_t; "# total loops,"+String:C10($loopCount_L)+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103($logfile_t; "datetime"+","+"action"+","+\
		"loop"+","+"startC"+","+"stopC"+","+"ProcName"+","+"array"+","+"ProcNum"+Char:C90(Carriage return:K15:38))
	
	Repeat 
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($ConvStart_ab))
			If ($ConvStart_ab{$loop_L})
				$processCount_L:=$processCount_L+1
				UpdateProgressNew($progress_o; $processCount_L)
				
				ARRAY LONGINT:C221($RecordNumbers_AL; 0)
				$Stop_L:=$Start_L+$Count_L-1
				SELECTION RANGE TO ARRAY:C368($Start_L; $Stop_L; [Inspections:27]; $RecordNumbers_AL)
				VARIABLE TO BLOB:C532($RecordNumbers_AL; $RecsBlob_x)
				$ProcNames_atxt{$loop_L}:="InspConvert"+String:C10($processCount_L)
				$ProcessID_L:=New process:C317("INSP_ConvertInspections"; 0; $ProcNames_atxt{$loop_L}; $RecsBlob_x)
				SEND PACKET:C103($logfile_t; String:C10(Current date:C33; ISO date:K1:8; Current time:C178)+","+"Launch"+","+\
					String:C10($processCount_L)+","+\
					String:C10($Start_L)+","+\
					String:C10($Stop_L)+","+\
					$ProcNames_atxt{$loop_L}+","+\
					String:C10(Size of array:C274($RecordNumbers_AL))+","+String:C10($ProcessID_L)+Char:C90(Carriage return:K15:38))
				$Start_L:=$Stop_L+1
				$procIDs_aL{$loop_L}:=$ProcessID_L
				$ConvStart_ab{$loop_L}:=False:C215
				If ($Start_L>Records in selection:C76([Inspections:27]))
					$Complete_B:=True:C214
					$loop_L:=Size of array:C274($ConvStart_ab)+1
				End if 
				
			End if 
			
			//check if progress stopped
			If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
				//abort loop and flag we're done
				$Complete_B:=True:C214
				$loop_L:=Size of array:C274($ConvStart_ab)+1
			End if 
			
		End for 
		
		If (Not:C34($Complete_B))
			$oneDone_b:=False:C215
			Repeat 
				SEND PACKET:C103($logfile_t; String:C10(Current date:C33; ISO date:K1:8; Current time:C178)+","+"Waiting"+Char:C90(Carriage return:K15:38))
				DELAY PROCESS:C323(Current process:C322; 600)
				
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($procIDs_aL))
					PROCESS PROPERTIES:C336($procIDs_aL{$loop_L}; $ProcessName1_txt; $ProcessState1_L; $ProcessTime1_tm)
					If (($ProcessName1_txt#$ProcNames_atxt{$loop_L}) | ($ProcessState1_L<0))
						$oneDone_b:=True:C214
						$ConvStart_ab{$loop_L}:=True:C214
					End if 
					
				End for 
				//check if progress stopped
				If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
					//abort loop
					$Complete_B:=True:C214
					$oneDone_b:=True:C214
					SEND PACKET:C103($logfile_t; String:C10(Current date:C33; ISO date:K1:8; Current time:C178)+","+"Aborting"+Char:C90(Carriage return:K15:38))
				End if 
				
			Until ($oneDone_b)
			
			If (Not:C34($Complete_B))
				SEND PACKET:C103($logfile_t; String:C10(Current date:C33; ISO date:K1:8; Current time:C178)+","+"FoundOneCompleted"+Char:C90(Carriage return:K15:38))
			End if 
			
		End if 
		
	Until ($Complete_B)
	
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	
	CLOSE DOCUMENT:C267($logfile_t)
	SHOW ON DISK:C922($logFile_txt)
End if 

//End INSP_WPConversionLoop