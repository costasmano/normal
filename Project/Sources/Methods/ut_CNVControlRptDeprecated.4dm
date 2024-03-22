//%attributes = {"invisible":true}

// >> ----------------------------------------------------
// >> User name(OS): Chuck Miller
// >> Date and time: 04/14/16, 14:05:25
// >> ----------------------------------------------------
// >> Method: ut_CNVControlResetPicture
// >> Description
// >> 
// >> Parameters
// >> ----------------------------------------------------
If (False:C215)
	// >> 
	// >> Modified by: Chuck Miller(4/14/16 14:05:26)
	
End if 
Compiler_CNV
READ ONLY:C145(*)

//C_LONGINT($Width_L;$Height_L)
//
//GET FORM PROPERTIES("ConvertPicture";$Width_L;$Height_L)
//$win:=ut_OpenNewWindow ($Width_L;$Height_L;0;Plain form window ;"Create Standard Photo Selection for Update")
//DIALOG("ConvertPicture")
//CLOSE WINDOW($win)



C_LONGINT:C283($RecordCount_L; $ProcID_L; $MyLoop_L)



$ProcID_L:=Execute on server:C373("ut_CNV_NewReportDepracated"; 0; "Report Deprecated"+String:C10(Current process:C322))
APPEND TO ARRAY:C911(<>CNV_UpdatePictProcessIDs_aL; $ProcID_L)
APPEND TO ARRAY:C911(<>CNV_ProcessName_atxt; "Report Deprecated"+String:C10(Current process:C322))
ut_LaunchCNVStop
DELAY PROCESS:C323(Current process:C322; 360)
$RecordCount_L:=Records in table:C83([Standard Photos:36])
C_REAL:C285($Complete_R)

$Complete_R:=0

C_LONGINT:C283($CurrentLoop_L; $Comparison_L; $Numerator_L)
C_LONGINT:C283(CurrentLoop_L)
C_LONGINT:C283($StartTick_L; $EndTick_L; $win)
$StartTick_L:=Tickcount:C458

$win:=ut_OpenNewWindow(500; 200; 5; 4; "Checking for Deprecated [Standard Photos]")
C_TIME:C306($RemainingTime_tm; $StartTime_tm)
$StartTime_tm:=Current time:C178

Repeat 
	
	C_LONGINT:C283($State_L)
	
	$State_L:=CNV_returnProcessState($ProcID_L; "Report Deprecated"+String:C10(Current process:C322))
	
	If ($State_L<0)
		$MyLoop_L:=-99999
	Else 
		GET PROCESS VARIABLE:C371($ProcID_L; CurrentLoop_L; $MyLoop_L)
		If ($MyLoop_L>50)
			
			
			GOTO XY:C161(5; 2)
			MESSAGE:C88("Updating "+String:C10($MyLoop_L)+" out of "+String:C10($RecordCount_L))
			GOTO XY:C161(5; 5)
			//MESSAGE("Processing record number "+String(CNV_RecordNumber_aL{$MyLoop_L}))
			
			GOTO XY:C161(5; 7)
			$RemainingTime_tm:=(($RecordCount_L/$MyLoop_L)-1)*(Current time:C178-$StartTime_tm)
			MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
			GOTO XY:C161(5; 9)
			MESSAGE:C88("Elapsed time is "+Time string:C180(Current time:C178-$StartTime_tm))
			
			
		End if 
		If ($MyLoop_L>0)
			DELAY PROCESS:C323(Current process:C322; 1020)
		End if 
	End if 
Until ($MyLoop_L=-99999)
CLOSE WINDOW:C154($win)


$MyLoop_L:=-8888
SET PROCESS VARIABLE:C370($ProcID_L; CurrentLoop_L; $MyLoop_L)



// End ut_CNVControlResetPicture

