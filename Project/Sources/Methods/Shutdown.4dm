//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: Shutdown
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: This procedure kills all processes still running
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(10/24/2006 12:22:57)
	Mods_2006_CM06A
	Mods_2009_07  //r002 `07/23/09, 11:52:33   `Add code to automatically quit all clients add param to set number of  retries
	// Modified by: Costas Manousakis-(Designer)-(4/21/17 16:03:17)
	Mods_2017_04
	//  `if the shift key is down and current user is a design user set number of retries to 2 for quicker exit
	// Modified by: Costas Manousakis-(Designer)-(1/31/18 11:04:04)
	Mods_2018_01_bug
	//  `skip processes with origin <=0 per article in 4D KB 77390
	// Modified by: Costas Manousakis-(Designer)-(6/4/18 12:47:06)
	Mods_2018_06
	//  `cleaned up old unused code
End if 
C_LONGINT:C283($NumberOfRetrys_l)
$NumberOfRetrys_l:=100
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$NumberOfRetrys_l:=$1
End if 
If (Shift down:C543 & User in group:C338(Current user:C182; "Design Access Group"))
	$NumberOfRetrys_l:=2
End if 
C_TEXT:C284($sProcName)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283($i; $j; $LState; $LTime; $LNumCalls; $LOrigin)
C_LONGINT:C283($IUniqueID)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($BHidden)
<>fQuit:=True:C214  //Set quit flag so processes terminate themselves.
//Termination performed by the output layout procedure.

$j:=Current process:C322
For ($i; 1; Count tasks:C335)
	
	If ($i#$j)
		$LNumCalls:=0
		
		Repeat 
			
			PROCESS PROPERTIES:C336($i; $sProcName; $LState; $LTime; $BHidden; $IUniqueID; $LOrigin)
			
			Case of 
				: ($LOrigin<=0)
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
					
				Else 
					RESUME PROCESS:C320($i)  //Just in case paused
					BRING TO FRONT:C326($i)
					POST OUTSIDE CALL:C329($i)
					$LNumCalls:=$LNumCalls+1
					If ($LNumCalls%10=0)  //Check for 500 calls - changed to 10 calls
						//    PostKey (3;0)  `Post an enter key to get out of a 4D built-in layout
						// Changes made 6/6/00
						POST KEY:C465(3; 0; $i)  //changed code to work with 4D version 6.5 - added process num 
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

//FLUSH CACHE
//Following repeat loop added per CJMiller 2004-4-30
If (Application type:C494#4D Remote mode:K5:5)
	Repeat 
		G_TickDelay(60)
	Until (Process state:C330(Process number:C372("Cache Manager"))=-100)
End if 