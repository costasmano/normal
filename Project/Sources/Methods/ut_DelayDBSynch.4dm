//%attributes = {"invisible":true}
//Method: ut_DelayDBSynch
//Description
// Set up to run a data  transfer at a later time. will open a dialog displaying a count down
// until the time to run the data transfer.
// will spawn a process named the same as the one createdd  from M_exec_transfer, so that two transfers do not occur at the same time
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/29/16, 17:33:04
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	// launches process with method
	ut_RunDBSynch
	
	// Modified by: Costas Manousakis-(Designer)-(5/26/20 19:03:25)
	Mods_2020_05
	//  `modified to allow transfers at a given interval.
	// Modified by: Costas Manousakis-(Designer)-(7/27/20 17:36:18)
	Mods_2020_07_bug
	//  `added IDLE after each delay process command
	//  `use system parameter DELAYDBSYNCPARAM (JSON object) for testing purposes compiled 
	//  `object properties "method" (default "ut_RunDBSynch"), "processname" (default "Data Transfer")
	// Modified by: Costas Manousakis-(Designer)-(8/12/20 15:54:29)
	Mods_2020_08_bug
	//  `fixes with catching of OK variable when dialogs/confirms close - added send to debug clipboard
	// Modified by: Costas Manousakis-(Designer)-(4/26/21 15:21:42)
	Mods_2021_04
	//  `Removed all send to clipboard commands
	// Modified by: Costas Manousakis-(Designer)-(6/14/21 20:05:41)
	Mods_2021_06_bug
	//  `use AddToDateTime to find the next launch date and time
	//  `add use of system parameter TransfExcludeTimes to specify a time span when trsnfers should not be run
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:43:11)
	Mods_2023_04
	//  `Removed IDLE after Delay process
End if 
//

C_LONGINT:C283($win_W_L; $win__H_L)
C_TEXT:C284(vsDialogTxt)
C_TEXT:C284(vsPassword; $Password)  // Command Replaced was C_STRING length was 80
C_DATE:C307(vDate)
C_TIME:C306(v_1_195_tm; $timeToAdd)
C_LONGINT:C283(v_1_006_L)  //use rank from bridge table for interval in minutes
C_TEXT:C284($Method_txt; $MyProcessName_txt; $ProcName_txt; $Parameter_txt)
$Method_txt:=ut_GetSysParamAttribute("DELAYDBSYNCPARAM"; "method"; "ut_RunDBSynch")
$MyProcessName_txt:=ut_GetSysParamAttribute("DELAYDBSYNCPARAM"; "processname"; "Data Transfer")
If ($MyProcessName_txt="Data Transfer")
	
	//Verify Tx Lock -only needed if doing a Data Transfer
	If ((<>LockUserTx) & (<>TxUserName#Current user:C182))
		
		ALERT:C41("Sorry! You are not authorized to send or receive any data!")
		ABORT:C156
	End if 
	
End if 

//get the password and date and time
FORM GET PROPERTIES:C674("DelayedTransfer"; $win_W_L; $win__H_L)

vsDialogTxt:=Current user:C182+", you are scheduling to do a "+$MyProcessName_txt+" at a later time."+Char:C90(13)+Char:C90(13)
vsDialogTxt:=vsDialogTxt+Uppercase:C13("Make sure that all input screens are closed, otherwise you might loose data!!")+Char:C90(13)

vsDialogTxt:=vsDialogTxt+Uppercase:C13("Also Make sure that there will be no conflict with the scheduled backup on the server.")+Char:C90(13)+Char:C90(13)
vsDialogTxt:=vsDialogTxt+"Enter your password and date and time for the "+$MyProcessName_txt+"."
NewWindow($win_W_L; $win__H_L; 0; Plain window:K34:13; "Delayed "+$MyProcessName_txt)
DIALOG:C40("DelayedTransfer")
CLOSE WINDOW:C154
If (OK=1)
	C_BOOLEAN:C305($keepGoing_b; $dlogOK_b)
	$keepGoing_b:=True:C214
	$Password:=vsPassword
	vsPassword:=""
	C_TEXT:C284($excludeTimes_txt)
	C_TIME:C306($startExclude_t; $endExclude_t)
	$startExclude_t:=?02:00:00?
	$endExclude_t:=?05:00:00?
	$excludeTimes_txt:=ut_GetSysParameter("TransfExcludeTimes")
	If ($excludeTimes_txt#"")
		C_OBJECT:C1216($excludeTimes_o)
		C_BOOLEAN:C305(4DError_b)
		C_TEXT:C284($lastMethOnError)
		$lastMethOnError:=Method called on error:C704
		4DError_b:=False:C215
		ON ERR CALL:C155("4D_Errors")
		
		$excludeTimes_o:=JSON Parse:C1218($excludeTimes_txt; Is object:K8:27)
		
		ON ERR CALL:C155($lastMethOnError)
		
		If (4DError_b)
			4DError_b:=False:C215  // 
			ALERT:C41("System parameter TransfExcludeTimes is badly formed!\r"+\
				"Transfer exclude time defaults to between "+String:C10($startExclude_t)+" and "+String:C10($endExclude_t)+".")
		Else 
			ARRAY TEXT:C222($ObjProps_atxt; 0)
			OB GET PROPERTY NAMES:C1232($excludeTimes_o; $ObjProps_atxt)
			C_LONGINT:C283($startIndx_L; $endIndx_L)
			$startIndx_L:=Find in array:C230($ObjProps_atxt; "startExclude")
			$endIndx_L:=Find in array:C230($ObjProps_atxt; "endExclude")
			
			Case of 
				: ($startIndx_L>0) & ($endIndx_L>0)
					//both are here
					$startExclude_t:=OB Get:C1224($excludeTimes_o; "startExclude"; Is time:K8:8)
					$endExclude_t:=OB Get:C1224($excludeTimes_o; "endExclude"; Is time:K8:8)
				: ($startIndx_L>0)
					//only start
					$startExclude_t:=OB Get:C1224($excludeTimes_o; "startExclude"; Is time:K8:8)
					ALERT:C41("System parameter TransfExcludeTimes does not contain the end of exclude time!\r"+\
						"Transfer exclude time defaults to between "+String:C10($startExclude_t)+" and "+String:C10($endExclude_t)+".")
				: ($endIndx_L>0)
					//only end
					$endExclude_t:=OB Get:C1224($excludeTimes_o; "endExclude"; Is time:K8:8)
					ALERT:C41("System parameter TransfExcludeTimes does not contain the start of exclude time!\r"+\
						"Transfer exclude time defaults to between "+String:C10($startExclude_t)+" and "+String:C10($endExclude_t)+".")
				Else 
					//neither
					ALERT:C41("System parameter TransfExcludeTimes does not contain required attributes!\r"+\
						"Transfer exclude time defaults to between "+String:C10($startExclude_t)+" and "+String:C10($endExclude_t)+".")
			End case 
			
		End if 
		
	End if 
	C_TEXT:C284($targetTime_txt)
	If (v_1_195_tm>=$startExclude_t) & (v_1_195_tm<=$endExclude_t)
		v_1_195_tm:=$endExclude_t+60  //Start one minute (60 secs) after end of exclude time
		ALERT:C41("Transfer start time set to "+String:C10(v_1_195_tm)+" to avoid exclusion time!")
	End if 
	$targetTime_txt:=ISODateTime(vDate; v_1_195_tm)
	$timeToAdd:=60*v_1_006_L  // convert the interval minutes to a time var
	
	C_BOOLEAN:C305($TimeUp_b; $run_b)
	C_TEXT:C284($timecheck_txt)
	//wait unitl the time is up
	FORM GET PROPERTIES:C674("CountDownTimer"; $win_W_L; $win__H_L)
	//ut_Send2Clipboard (String(Tickcount)+" "+"Starting  \r";"Clear")
	
	Repeat   //start of launch cycle
		vsDialogTxt:=$MyProcessName_txt+" scheduled for "+String:C10(vDate)+" "+String:C10(v_1_195_tm)
		vsDialogTxt:=vsDialogTxt+Char:C90(13)+"Approx time left :"
		C_TIME:C306(vTimeM)
		vTimeM:=v_1_195_tm
		NewWindow($win_W_L; $win__H_L; 0; Plain window:K34:13; "Delayed "+$MyProcessName_txt)
		//ut_Send2Clipboard (String(Tickcount)+" "+"opened window - starting dialog "+"\r")
		DIALOG:C40("CountDownTimer")
		$dlogOK_b:=(OK=1)  // need to capture it here because adding to clipboard sets it to 1
		//ut_Send2Clipboard (String(Tickcount)+" "+"exiting dialog "+"\r")
		CLOSE WINDOW:C154
		If ($dlogOK_b)
			If (Not:C34(<>fQuit))
				C_LONGINT:C283($Lpid)
				//time to run the one that starts it use name $MyProcessName_txt so that if it's running already it will just bring it to front
				
				If ($MyProcessName_txt="Data Transfer")
					$Lpid:=LSpawnProcess($Method_txt; <>LStackSize; $MyProcessName_txt; True:C214; False:C215; $Password)  // data transfer needs the pw
					
				Else 
					$Lpid:=LSpawnProcess($Method_txt; <>LStackSize; $MyProcessName_txt; True:C214; False:C215)
					
				End if 
				
				//ut_Send2Clipboard (String(Tickcount)+" "+"started process "+String($Lpid)+"\r")
				//wait for process called $MyProcessName_txt to end
				//start the bar
				C_OBJECT:C1216($progress_o)
				$progress_o:=ProgressNew("Waiting for "+$MyProcessName_txt+" to end"; 100000000; True:C214; ""; 0)
				//ut_Send2Clipboard (String(Tickcount)+" "+"started progress bar \r")
				C_TIME:C306($nextTime_tm)
				$nextTime_tm:=Current time:C178+10
				Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Will start checking at "+String:C10($nextTime_tm))
				//ut_Send2Clipboard (String(Tickcount)+" "+"set message \r")
				//wait for 10 seconds to start the check..
				DELAY PROCESS:C323(Current process:C322; (10*60))  //wait 10 seconds
				//IDLE
				//ut_Send2Clipboard (String(Tickcount)+" "+"done delay 10 sec \r")
				C_BOOLEAN:C305($checkingTranfer_b; $abortCheck_b)
				$abortCheck_b:=False:C215
				$checkingTranfer_b:=False:C215
				C_LONGINT:C283($count)
				$count:=0
				Repeat   //start of waiting for transfers to end cycle
					
					$count:=$count+1
					//update progress
					Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Test #"+String:C10($count))
					C_LONGINT:C283($procLoop_L; $procState_L; $ProcTime_L)
					C_BOOLEAN:C305($procFound_b; $stillRunning_b)
					$stillRunning_b:=False:C215
					$procFound_b:=False:C215
					//ut_Send2Clipboard (String(Tickcount)+" "+"checking "+String(Count tasks)+" tasks \r")
					
					For ($procLoop_L; 1; Count tasks:C335)
						PROCESS PROPERTIES:C336($procLoop_L; $ProcName_txt; $procState_L; $ProcTime_L)
						//ut_Send2Clipboard (String(Tickcount)+" "+"checking task "+String($procLoop_L)+" name "+$ProcName_txt+" state "+String($procState_L)+" \r")
						
						If ($ProcName_txt=$MyProcessName_txt)
							Case of 
								: ($procState_L=Aborted:K13:1)
								: ($procState_L=Does not exist:K13:3)
								Else 
									$stillRunning_b:=True:C214
							End case 
							//found a matching process - exit the loop
							$procLoop_L:=Count tasks:C335+1
							//ut_Send2Clipboard (String(Tickcount)+" "+"found matching task - exiting check loop"+" \r")
							
						End if 
						
					End for 
					
					//check if user stopped progress bar
					If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
						//abort loop
						ALERT:C41("Canceling "+$MyProcessName_txt+" on interval")
						$abortCheck_b:=True:C214
					Else 
						If ($stillRunning_b)
							Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); \
								"Test #"+String:C10($count)+": "+$MyProcessName_txt+" running at "+String:C10(Current time:C178)+", will check after 20 sec")
							//ut_Send2Clipboard (String(Tickcount)+" "+"still running wait 20 sec"+" \r")
							//process still running - try again after 20 seconds
							DELAY PROCESS:C323(Current process:C322; (20*60))  //wait 20 seconds
							//ut_Send2Clipboard (String(Tickcount)+" "+"done wait 20 sec"+" \r")
							//IDLE
						Else 
							// process is done or not found - exit 
							Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); \
								"Test #"+String:C10($count)+": "+$MyProcessName_txt+" complete or aborted!")
							//ut_Send2Clipboard (String(Tickcount)+" "+"process done "+" \r")
							$checkingTranfer_b:=True:C214
						End if 
					End if 
					
				Until ($checkingTranfer_b | $abortCheck_b)  //end of waiting
				
				//ut_Send2Clipboard (String(Tickcount)+" "+"Exit repeat "+" \r")
				
				//quit progress
				Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
				//ut_Send2Clipboard (String(Tickcount)+" "+"quit progress bar "+" \r")
				
				//calculate next time starting from now
				v_1_195_tm:=Current time:C178
				vDate:=Current date:C33
				AddToDateTime(->vDate; ->v_1_195_tm; 0; 0; 0; $timeToAdd)
				If (v_1_195_tm>=$startExclude_t) & (v_1_195_tm<=$endExclude_t)
					v_1_195_tm:=$endExclude_t+60  //Start one minute (60 secs) after end of exclude time
				End if 
				
				//ut_Send2Clipboard (String(Tickcount)+" "+"set next time "+String(v_1_195_tm)+" next date "+String(vDate)+" \r")
				
				Case of 
					: (<>fQuit)
						$keepGoing_b:=False:C215
					: ($abortCheck_b)
						$keepGoing_b:=False:C215
				End case 
				
			Else 
				ALERT:C41($MyProcessName_txt+" scheduled on "+String:C10(vDate)+" - "+String:C10(v_1_195_tm)+" is being cancelled because application is quiting!")
				$keepGoing_b:=False:C215
			End if 
		Else 
			//user canceled the count down timer
			CONFIRM:C162("Cancel all "+$MyProcessName_txt+" at interval?"; "Cancel"; "Continue")
			$dlogOK_b:=(OK=1)  // need to capture it here because adding to clipboard sets it to 1
			//ut_Send2Clipboard (String(Tickcount)+" "+"set next time "+String(v_1_195_tm)+" next date "+String(vDate)+" \r")
			
			If ($dlogOK_b)
				$keepGoing_b:=False:C215
			Else 
			End if 
		End if 
		
	Until (Not:C34($keepGoing_b))  //end of launch cycle
	
End if 
//End ut_DelayDBSynch