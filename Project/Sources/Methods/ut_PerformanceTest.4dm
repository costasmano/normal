//%attributes = {"invisible":true}
//Method: ut_PerformanceTest
//Description
//  Project method: ut_PerformanceTest
//  Copyright ©2004 Knowledge Sharing Systems, Inc. All rights reserved.
//  Created: 1/29/04
//  Developer: swright
//  Parameters:
//    $1 = action string
//    $2 and others = optional string
//  Returns:
//    none
//  Description:
//    Performs a series of tests with the server to determine network performance
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/06/15, 09:33:14
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
	C_TEXT:C284(ut_PerformanceTest; $1)  // was length of 20
	C_TEXT:C284(ut_PerformanceTest; ${2})  // was length of 20
	//  Modifications:
	//
	// Modified by: Costas Manousakis-(Designer)-(1/13/17 10:37:07)
	Mods_2017_01
	//  `move the request to mail right before sending - no need for the last alert now
	// Modified by: Costas Manousakis-(Designer)-(1/24/20 17:32:10)
	Mods_2020_01
	//  `added ip addresses and name of struct file on server
End if 
//

C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(${2})  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($sAction)  // Command Replaced was o_C_STRING length was 20
C_BLOB:C604(ut_TestBlob)
C_TEXT:C284(ut_sStatus)  // Command Replaced was o_C_STRING length was 10
C_LONGINT:C283(ut_iPerformanceProcess)
C_LONGINT:C283($iSmallSize; $iMediumSize; $iLargeSize; $i)
C_LONGINT:C283($iSmallAvg; $iMediumAvg; $iLargeAvg)
C_LONGINT:C283($iSmallLow; $iMediumLow; $iLargeLow)
C_LONGINT:C283($iSmallHi; $iMediumHi; $iLargeHi)
C_LONGINT:C283($iStartMils; $iEndMils)
C_TEXT:C284($tSizes; $tTestData; $tRecipient; $tSubject; $tBody; $tSizeStore)
If (Count parameters:C259=0)
	$sAction:="init"
Else   //  all other calls have at least one parameter, the action to do
	//ALERT("Params "+String(Count parameters)+" 1 :<"+$1+">")
	$sAction:=$1
	If ($sAction="")
		$sAction:="init"  //just in case
	End if 
End if 
//tRACE
Case of 
	: ($sAction="init")
		$tSizes:=Request:C163("Enter Small, Medium, & Large sizes in K..."; "0.125/512/2000")
		If (OK=1)
			C_TEXT:C284($serverIP_txt; $MyIP_txt; $mask)
			C_LONGINT:C283($Errcode_L)
			$serverIP_txt:=ut_ReturnServerIP
			$Errcode_L:=IT_MyTCPAddr($MyIP_txt; $mask)
			SHORT_MESSAGE("Commencing performance test")
			$tSizeStore:=$tSizes
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Sizes: "+$tSizes)
			$i:=Position:C15("/"; $tSizes)
			$iSmallSize:=1024*Num:C11(Substring:C12($tSizes; 1; $i-1))
			$tSizes:=Substring:C12($tSizes; $i+1)
			$i:=Position:C15("/"; $tSizes)
			$iMediumSize:=Num:C11(Substring:C12($tSizes; 1; $i-1))
			$tSizes:=Substring:C12($tSizes; $i+1)
			$iLargeSize:=Num:C11($tSizes)
			// client starts new process on server
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Starting server process")
			ut_iPerformanceProcess:=Execute on server:C373("ut_PerformanceTest"; 0; "Performance Test"; "onServer")
			// server process inits, set status to "ready" and idles waiting on "done"
			// client tests sever process status until process is "ready"
			ut_sStatus:=""
			While (ut_sStatus#"ready")
				DELAY PROCESS:C323(Current process:C322; 5*60)  //  wait 5 seconds
				GET PROCESS VARIABLE:C371(ut_iPerformanceProcess; ut_sStatus; ut_sStatus)
			End while 
			// client builds small, medium & large test blobs and puts them to the server process then gets them back
			// client captures timing data between each set/get
			ARRAY LONGINT:C221($aiSmall; 10)
			ARRAY LONGINT:C221($aiMedium; 10)
			ARRAY LONGINT:C221($aiLarge; 10)
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Building small test data")
			$tTestData:=("X"*$iSmallSize)  //  build small sample of data
			//  Small test...
			SET BLOB SIZE:C606(ut_TestBlob; 0)
			VARIABLE TO BLOB:C532($tTestData; ut_TestBlob)
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Starting small test")
			// repeat 10 times to generate averages
			For ($i; 1; 10)
				$iStartMils:=Milliseconds:C459
				SET PROCESS VARIABLE:C370(ut_iPerformanceProcess; ut_TestBlob; ut_TestBlob)
				GET PROCESS VARIABLE:C371(ut_iPerformanceProcess; ut_TestBlob; ut_TestBlob)
				$iEndMils:=Milliseconds:C459
				$aiSmall{$i}:=$iEndMils-$iStartMils
				MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Small test "+String:C10($i)+": "+String:C10($aiSmall{$i})+" ms")
			End for 
			$tTestData:=("X"*1024)  //  build 1K's worth of data
			//  Medium test...
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Building medium test data")
			SET BLOB SIZE:C606(ut_TestBlob; 0)
			For ($i; 1; $iMediumSize)
				VARIABLE TO BLOB:C532($tTestData; ut_TestBlob; *)
			End for 
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Starting medium test")
			// repeat 10 times to generate averages
			For ($i; 1; 10)
				$iStartMils:=Milliseconds:C459
				SET PROCESS VARIABLE:C370(ut_iPerformanceProcess; ut_TestBlob; ut_TestBlob)
				GET PROCESS VARIABLE:C371(ut_iPerformanceProcess; ut_TestBlob; ut_TestBlob)
				$iEndMils:=Milliseconds:C459
				$aiMedium{$i}:=$iEndMils-$iStartMils
				MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Medium test "+String:C10($i)+": "+String:C10($aiMedium{$i})+" ms")
			End for 
			//  Large test...
			SET BLOB SIZE:C606(ut_TestBlob; 0)
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Building large test data")
			For ($i; 1; $iLargeSize)
				VARIABLE TO BLOB:C532($tTestData; ut_TestBlob; *)
			End for 
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Starting large test")
			// repeat 10 times to generate averages
			For ($i; 1; 10)
				$iStartMils:=Milliseconds:C459
				SET PROCESS VARIABLE:C370(ut_iPerformanceProcess; ut_TestBlob; ut_TestBlob)
				GET PROCESS VARIABLE:C371(ut_iPerformanceProcess; ut_TestBlob; ut_TestBlob)
				$iEndMils:=Milliseconds:C459
				$aiLarge{$i}:=$iEndMils-$iStartMils
				MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Large test "+String:C10($i)+": "+String:C10($aiLarge{$i})+" ms")
			End for 
			MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Performance test complete")
			CLOSE WINDOW:C154
			//  we've finished with the server process...
			ut_sStatus:="done"
			SET PROCESS VARIABLE:C370(ut_iPerformanceProcess; ut_sStatus; ut_sStatus)
			//  clear memory used by blob...
			SET BLOB SIZE:C606(ut_TestBlob; 0)
			// produce results
			$tSubject:="Performance Test Results."
			$tBody:="Performance test conducted on "+String:C10(Current date:C33(*))+" at "+String:C10(Current time:C178(*))+Char:C90(Carriage return:K15:38)
			$tBody:=$tBody+"by "+Current user:C182+" from "+Current machine:C483+\
				" at IP "+$MyIP_txt+Char:C90(Carriage return:K15:38)+\
				"Connected to server "+Structure file:C489+" at IP "+$serverIP_txt+Char:C90(Carriage return:K15:38)
			$tBody:=$tBody+"Sizes (K): "+$tSizeStore+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
			$tBody:=$tBody+"Small test (ms):"+Char:C90(Tab:K15:37)
			$iSmallLow:=1000000
			For ($i; 1; 10)
				$tBody:=$tBody+String:C10($aiSmall{$i})+Char:C90(Tab:K15:37)
				$iSmallAvg:=$iSmallAvg+$aiSmall{$i}
				If ($aiSmall{$i}<$iSmallLow)
					$iSmallLow:=$aiSmall{$i}
				End if 
				If ($aiSmall{$i}>$iSmallHi)
					$iSmallHi:=$aiSmall{$i}
				End if 
			End for 
			$tBody:=$tBody+Char:C90(Carriage return:K15:38)+"Medium test (ms):"+Char:C90(Tab:K15:37)
			$iMediumLow:=1000000
			For ($i; 1; 10)
				$tBody:=$tBody+String:C10($aiMedium{$i})+Char:C90(Tab:K15:37)
				$iMediumAvg:=$iMediumAvg+$aiMedium{$i}
				If ($aiMedium{$i}<$iMediumLow)
					$iMediumLow:=$aiMedium{$i}
				End if 
				If ($aiMedium{$i}>$iMediumHi)
					$iMediumHi:=$aiMedium{$i}
				End if 
			End for 
			$tBody:=$tBody+Char:C90(Carriage return:K15:38)+"Large test (ms):"+Char:C90(Tab:K15:37)
			$iLargeLow:=1000000
			For ($i; 1; 10)
				$tBody:=$tBody+String:C10($aiLarge{$i})+Char:C90(Tab:K15:37)
				$iLargeAvg:=$iLargeAvg+$aiLarge{$i}
				If ($aiLarge{$i}<$iLargeLow)
					$iLargeLow:=$aiLarge{$i}
				End if 
				If ($aiLarge{$i}>$iLargeHi)
					$iLargeHi:=$aiLarge{$i}
				End if 
			End for 
			$iSmallAvg:=$iSmallAvg/10
			$iMediumAvg:=$iMediumAvg/10
			$iLargeAvg:=$iLargeAvg/10
			$tBody:=$tBody+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+Char:C90(Tab:K15:37)+"Average"+Char:C90(Tab:K15:37)+"Low"+Char:C90(Tab:K15:37)+"High"
			$tBody:=$tBody+Char:C90(Carriage return:K15:38)+"Small"+Char:C90(Tab:K15:37)+String:C10($iSmallAvg)+Char:C90(Tab:K15:37)+String:C10($iSmallLow)+Char:C90(Tab:K15:37)+String:C10($iSmallHi)
			$tBody:=$tBody+Char:C90(Carriage return:K15:38)+"Medium"+Char:C90(Tab:K15:37)+String:C10($iMediumAvg)+Char:C90(Tab:K15:37)+String:C10($iMediumLow)+Char:C90(Tab:K15:37)+String:C10($iMediumHi)
			$tBody:=$tBody+Char:C90(Carriage return:K15:38)+"Large"+Char:C90(Tab:K15:37)+String:C10($iLargeAvg)+Char:C90(Tab:K15:37)+String:C10($iLargeLow)+Char:C90(Tab:K15:37)+String:C10($iLargeHi)
			ut_BigAlert($tBody; "Test Results")
			//em_SendMail("KSS_TechTracS";$tRecipient;$tSubject;$tBody)
			$tRecipient:=Request:C163("Send results to..."; "costas.manousakis@dot.state.ma.us")
			If (OK=1)
				ut_SendEmail($tRecipient; $tRecipient; ""; ""; $tBody; $tSubject)
			End if 
			//ALERT("Test complete. Averages are Small: "+String($iSmallAvg)+", Medium:"+String($iMediumAvg)+", Large:"+String($iLargeAvg))
		End if 
	: ($sAction="onServer")
		ut_sStatus:="ready"
		While (ut_sStatus#"done")
			DELAY PROCESS:C323(Current process:C322; 5*60)  //  wait 5 seconds
		End while 
		SET BLOB SIZE:C606(ut_TestBlob; 0)
	Else 
		ALERT:C41("ut_PerformanceTest: action "+$sAction+" not recognized!")
End case 
//End ut_PerformanceTest
