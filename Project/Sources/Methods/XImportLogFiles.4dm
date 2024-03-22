//%attributes = {"invisible":true}
//Method: XImportLogFiles
//Description
// import exported log files from a folder
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jul 15, 2022, 17:29:34
	Mods_2022_07
	// ----------------------------------------------------
	
End if 

C_LONGINT:C283($vlNbActLog; $vlNbOwnerData; $i; $j; $k; $Interval)
C_TEXT:C284($folder; $vsTag; $Log_txt)
$folder:=Select folder:C670("choose folder with archivelogfiles"; 4)
If (OK=1)
	
	CONFIRM:C162("Close out any open progress bars?")
	If (ok=1)
		Progress QUIT(0)
		
	End if 
	
	ARRAY TEXT:C222($files_atxt; 0)
	
	DOCUMENT LIST:C474($folder; $files_atxt; Absolute path:K24:14+Ignore invisible:K24:16)
	C_LONGINT:C283($file_; $filesprogress)
	$filesprogress:=Progress New
	Progress SET TITLE($filesprogress; String:C10(Size of array:C274($files_atxt))+"-"+$folder)
	Progress SET BUTTON ENABLED($filesprogress; True:C214)
	C_LONGINT:C283($actlogCount_L)
	$actlogCount_L:=0
	
	For ($file_; 1; Size of array:C274($files_atxt))
		//try to import each file
		SET CHANNEL:C77(10; $files_atxt{$file_})
		RECEIVE VARIABLE:C81($vsTag)
		$Log_txt:=$files_atxt{$file_}+"_"+Generate UUID:C1066+"_log.txt"
		Progress SET MESSAGE($filesprogress; String:C10($file_)+"-"+Replace string:C233($files_atxt{$file_}; $folder; ""))
		C_BOOLEAN:C305($continueImport_b)
		$continueImport_b:=True:C214  //assume ok
		If ($vsTag="NBISARCHIVE@")  //Is this the right tag?
			//check of there is additiona info in the tag
			$vsTag:=Replace string:C233($vsTag; "NBISARCHIVE"; "")
			If ($vsTag#"")
				C_OBJECT:C1216($info_o)
				C_TEXT:C284($currErrmthd_txt)
				$currErrmthd_txt:=Method called on error:C704
				C_BOOLEAN:C305(4DError_b)
				4DError_b:=False:C215
				ON ERR CALL:C155("4D_Errors")
				$info_o:=JSON Parse:C1218($vsTag; Is object:K8:27)
				ON ERR CALL:C155($currErrmthd_txt)
				4DError_b:=False:C215
				
				If (False:C215)
					If (4DError_b)
						G_MyConfirm("Error Parsing info after NBISARCHIVE tag\n"+$vsTag+"\rContinue with import?")
						$continueImport_b:=(OK=1)
						
					Else 
						G_MyConfirm("Info attached to the NBISARCHIVE tag\n"+JSON Stringify:C1217($info_o; *)+"\rContinue with import?")
						$continueImport_b:=(OK=1)
						
					End if 
					
				End if 
				
			End if 
			
			If ($continueImport_b)
				C_TIME:C306($log_t)
				
				$log_t:=Create document:C266($Log_txt)
				
				RECEIVE VARIABLE:C81($vlNbActLog)  //Find out how many records are stored here.
				SEND PACKET:C103($log_t; "Loading into data file "+Data file:C490+<>sCR)
				SEND PACKET:C103($log_t; "Start time is : "+String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+<>sCR)
				SEND PACKET:C103($log_t; "Contents are : "+String:C10($vlNbActLog)+" records"+<>sCR)
				C_BOOLEAN:C305(4DError_b)
				If ($vlNbActLog>0)
					$actlogCount_L:=$actlogCount_L+1
					
					C_LONGINT:C283($progress_L; $StartRefID_L; $EndRefID_L; $StartMilliSec_L; $startRefIgnore_L; $EndRefIgnore_L; \
						$startIgnoreCount_L; $EndIgnoreCount_L)
					$StartRefID_L:=0
					$EndRefID_L:=0
					$progress_L:=Progress New
					Progress SET TITLE($progress_L; "Importing "+String:C10($vlNbActLog; "###,###,###,###")+" Activity Log Records")
					//<>ProgressPID:=StartProgress ("";"None";"Importing Archive Log")
					$Interval:=MaxNum(MinNum(Int:C8($vlNbActLog/40); 20); 2)  // get an update interval between 2 and 20
					//UpdateProgress (1;$vlNbActLog)  // start the progress bar...      
					Progress SET PROGRESS($progress_L; 0)
					Progress SET BUTTON ENABLED($progress_L; True:C214)
					$StartMilliSec_L:=Milliseconds:C459
					ON ERR CALL:C155("4D_Errors")
					C_BOOLEAN:C305($KeepLoading_b; $IgnoreError_b; $SaveOwners_b)
					$KeepLoading_b:=True:C214
					$SaveOwners_b:=True:C214
					$IgnoreError_b:=True:C214  //ignore errors such as dupl key errors
					For ($i; 1; $vlNbActLog)
						RECEIVE RECORD:C79([Activity Log:59])
						If ($StartRefID_L=0)
							$StartRefID_L:=[Activity Log:59]RefID:28
							SEND PACKET:C103($log_t; "Start RefID = "+String:C10($StartRefID_L)+<>sCR)
						End if 
						[Activity Log:59]Activity_Log_UUIDKey_s:29:=Generate UUID:C1066
						SAVE RECORD:C53([Activity Log:59])
						
						Case of 
							: (Not:C34(4DError_b))
								$SaveOwners_b:=True:C214
								$KeepLoading_b:=True:C214
								
							: (4DError_b & Not:C34($IgnoreError_b))
								CONFIRM:C162("Error during Act Log save! Ignore further errors or abort?"; "Ignore"; "Abort")
								$IgnoreError_b:=(OK=1)
								$KeepLoading_b:=(OK=1)
								$SaveOwners_b:=False:C215
							: (4DError_b & $IgnoreError_b)
								$SaveOwners_b:=False:C215
						End case 
						
						If (4DError_b & $IgnoreError_b)
							If ($startRefIgnore_L=0)
								$startIgnoreCount_L:=$i
								$startRefIgnore_L:=[Activity Log:59]RefID:28
							End if 
							$EndRefIgnore_L:=[Activity Log:59]RefID:28
							$EndIgnoreCount_L:=$i
							4DError_b:=False:C215  //reset it for next time
						End if 
						
						If ($KeepLoading_b)
							$EndRefID_L:=[Activity Log:59]RefID:28
							RECEIVE VARIABLE:C81($vlNbOwnerData)  //Find out how many owner records there are
							If ($vlNbOwnerData>0)
								For ($j; 1; $vlNbOwnerData)
									RECEIVE RECORD:C79([Owners of Data:62])
									If ($SaveOwners_b)
										[Owners of Data:62]Owners_of_Data_UUIDKey_s:3:=Generate UUID:C1066
										SAVE RECORD:C53([Owners of Data:62])
									End if 
								End for 
							End if 
							$k:=$k+1
							If ($k%$Interval=0)  //Don't slow down things just to display
								//UpdateProgress ($i;$vlNbActLog)
								Progress SET PROGRESS($progress_L; ($i/$vlNbActLog))
								C_LONGINT:C283($DT_L; $RemainingMilli_L)
								$DT_L:=Milliseconds:C459-$StartMilliSec_L
								C_REAL:C285($RRR_r)
								$RRR_r:=($DT_L/$i)*($vlNbActLog-$i)
								$RemainingMilli_L:=$RRR_r
								
								Progress SET MESSAGE($progress_L; String:C10($i; "###,###,###,###")+" of "+String:C10($vlNbActLog; "###,###,###,###")+" Est time left: "+FN_MilliSec2TimeStr($RemainingMilli_L))
								
							End if 
							If ($k%200=0)
								//FLUSH CACHE
							End if 
							4DError_b:=False:C215  //reset it for next time
							
							If (Progress Stopped($progress_L) | Progress Stopped($filesprogress))
								$i:=$vlNbActLog+1
							End if 
							
						Else 
							//exit loop
							$i:=$vlNbActLog+1
						End if 
					End for 
					If ($startRefIgnore_L>0)
						SEND PACKET:C103($log_t; "Ignored Starting RefID = "+String:C10($startRefIgnore_L)+" Line "+String:C10($startIgnoreCount_L)+<>sCR)
						SEND PACKET:C103($log_t; "Ignored Ending RefID = "+String:C10($EndRefIgnore_L)+" Line "+String:C10($EndIgnoreCount_L)+<>sCR)
					End if 
					
					SEND PACKET:C103($log_t; "End RefID = "+String:C10($EndRefID_L)+<>sCR)
					SEND PACKET:C103($log_t; "End time is : "+String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+<>sCR)
					Progress QUIT($progress_L)
				Else 
					//ALERT("There are no Activity Log records stored here")
				End if 
				CLOSE DOCUMENT:C267($log_t)  //close log
				
			End if 
			
		Else 
			//ALERT("This is not an Activity Log archive")
		End if 
		SET CHANNEL:C77(11)  //Close the document  
		
		If (Progress Stopped($filesprogress))
			$file_:=Size of array:C274($files_atxt)+1
		End if 
		
	End for 
	
	Progress QUIT($filesprogress)
	
	ALERT:C41("Finsihed loading "+String:C10($actlogCount_L)+" files from folder "+$folder)
End if 

//
//End XImportLogFiles   
