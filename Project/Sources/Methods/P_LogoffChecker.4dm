//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: P_LogoffChecker 
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Purpose:   Manages the user logoff process
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($LCheckTime; $LQuitDelay)
C_BOOLEAN:C305($fUserLogoff)
C_TEXT:C284($sMsg)  // Command Replaced was o_C_STRING length was 255

ControlMenuBar(1)

<>LLogOffPID:=Current process:C322
<>fUsrPresent:=False:C215
$fUserLogoff:=False:C215
$LCheckTime:=2*60*60*60  //Hours*Minutes*Seconds*Ticks
If (User in group:C338(Current user:C182; "Design Access Group"))
	$LCheckTime:=$LCheckTime*10
End if 
$LQuitDelay:=$LCheckTime/3

Repeat 
	
	DELAY PROCESS:C323(<>LLogOffPID; $LQuitDelay)  //Delay process
	
	If (<>fUsrPresent)  //There is a user present turn off timer and reset
		ON EVENT CALL:C190("")
		<>fUsrPresent:=False:C215
		$fUserLogoff:=False:C215
		$LQuitDelay:=$LCheckTime/3  //Divide time by three then check
		
	Else 
		
		If ($fUserLogoff)  //User logoff still true after entire time period
			BEEP:C151
			BEEP:C151
			BEEP:C151
			BRING TO FRONT:C326(Current process:C322)  //Warn the user of impending shutdown
			NewWindow(300; 150; 0; 1; ""; "")
			GOTO XY:C161(0; 0)
			$sMsg:="WARNING : WARNING : WARNING"+(<>sCR*2)+"You will be logged off in 1 minute!"+(<>sCR*2)+"Unless you click the mouse in this window."
			MESSAGE:C88($sMsg)
			DELAY PROCESS:C323(Current process:C322; 3600)  //Give the user a chance to indicate that they are still there
			CLOSE WINDOW:C154
			
			If (<>fUsrPresent)  //The user came back
				$LQuitDelay:=0  //Set delay to zero to not delay above
			Else 
				ON EVENT CALL:C190("")  //Turn off event handler
				M_Quit
			End if 
			
		Else 
			
			$LQuitDelay:=$LCheckTime
			$fUserLogoff:=True:C214  //Else, $fUserLogoff is set to True
			ON EVENT CALL:C190("OnCallQuit")  //Turn on the timer
			
		End if   //$fUserLogoff
		
	End if   //fUsrPresent
	
Until (False:C215)
//End of procedure