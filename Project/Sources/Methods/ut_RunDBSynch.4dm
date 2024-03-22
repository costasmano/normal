//%attributes = {"invisible":true}
//Method: ut_RunDBSynch
//Description
// just runs ut_ControlDBSycnh - needed because LSpawnProcess can only pass text parameters
// Parameters
// $1 : $password
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/29/16, 09:25:11
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
	C_TEXT:C284(ut_RunDBSynch; $1)
	// Modified by: Costas Manousakis-(Designer)-(8/31/20 18:09:50)
	Mods_2020_08_bug
	//  `added process "Delayed transfer" to the list to be skipped
End if 
//
C_TEXT:C284($1; $password)
$password:=$1
C_TEXT:C284($sProcName)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283($i; $j; $LState; $LTime; $LNumCalls; $LOrigin; $NumberOfRetrys_l)
C_LONGINT:C283($IUniqueID)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($BHidden)

$NumberOfRetrys_l:=20  // this should be enough to get through entry screens
//need to close all input screens
$j:=Current process:C322
For ($i; 1; Count tasks:C335)
	
	If ($i#$j)
		$LNumCalls:=0
		
		Repeat 
			
			PROCESS PROPERTIES:C336($i; $sProcName; $LState; $LTime; $BHidden; $IUniqueID; $LOrigin)
			Case of 
				: ($sProcName="Delayed Transfer")
					$LState:=Aborted:K13:1
				: ($sProcName="Internal @")
					$LState:=Aborted:K13:1
				: ($sProcName="4D@")
					$LState:=Aborted:K13:1
				: ($sProcName="Design process")
					$LState:=Aborted:K13:1
				: ($sProcName="Application process")
					$LState:=Aborted:K13:1
				: ($sProcName="M@")
					$LState:=Aborted:K13:1
				: ($LState=Aborted:K13:1)
				: ($LOrigin<0)
					$LState:=Aborted:K13:1  //Don't kill local or current processes
				: (Substring:C12($sProcName; 1; 1)="$")
					$LState:=Aborted:K13:1
				: ($i=$j)
					$LState:=Aborted:K13:1
				: ($sProcName="Cache Manager")
					$LState:=Aborted:K13:1
				: ($sProcName="Design process")
					$LState:=Aborted:K13:1
				: ($sProcName="Apple Events Manager")
					$LState:=Aborted:K13:1
				: ($sProcName="Web Server")
					$LState:=Aborted:K13:1
				: ($LOrigin<=0)
					$LState:=Aborted:K13:1
				Else 
					RESUME PROCESS:C320($i)  //Just in case paused
					BRING TO FRONT:C326($i)
					POST OUTSIDE CALL:C329($i)
					$LNumCalls:=$LNumCalls+1
					If ($LNumCalls%2=0)  //post  an enter key every 2 calls
						POST KEY:C465(3; 0; $i)
						DELAY PROCESS:C323(Current process:C322; 20)  //Wait 20 ticks and pass CMD-.
						POST KEY:C465(Character code:C91("."); Command key mask:K16:1; $i)
					End if 
					DELAY PROCESS:C323(Current process:C322; 10)  //Wait 10 ticks
					PROCESS PROPERTIES:C336($i; $sProcName; $LState; $LTime; $BHidden; $IUniqueID; $LOrigin)  // get props again in case it aborted
					If ($LState#Aborted:K13:1)
						DELAY PROCESS:C323(Current process:C322; 120)  //Wait a couple of seconds if not aborted yet
					End if 
					
			End case 
			
		Until (($LState=Aborted:K13:1) | ($LNumCalls>=$NumberOfRetrys_l))  //Keep calling until aborted or sure its hung
	End if 
End for 

ut_ControlDBSycnh(3; $password)
//End ut_RunDBSynch