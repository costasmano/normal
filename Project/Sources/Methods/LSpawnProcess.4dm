//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: LSpawnProcess(string;integer;string;boolean;boolean) -> longint
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - string - procedure to run
	//$2 - integer - stack size (memory for process variables)
	//$3 - string - name of process created
	//$4 - boolean - (true) inform the user that there wasn't enough memory to  	 `cre
	//$5 - boolean - if true, allow multiple views
	//$6 - text - optional single text parameter 
	
	//Returns -> longint - process id, zero if process wasn't created
	//-------------------------------------------------------
	
	//Purpose: This is where the New process function is called.
	//It prevents processes from being created if the ◊fQuit flag exists.
	//This procedure creates a new process in a controlled way.
	//There is an option to notify the user when a process can't be created
	//due to insufficient memory. The developer controls whether the passed
	//procedure is allowed to execute in more than one process (multiple views).
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 12:23:23)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(5/26/09 08:57:25)
	Mods_2009_05
	//Added passing of a single text parameter 
	// Modified by: costasmanousakis-(Designer)-(8/26/10 09:18:27)
	Mods_2010_08
	//  `Added the declaration for the 6th and more parameters- up to 13 parameters
	//  `or, up to 8 text parameters passed to the called method
End if 

C_LONGINT:C283($Lpid; $0; $2; $LStack)
C_TEXT:C284($1; $3; $sProcedure; $sProcName)  // Command Replaced was o_C_STRING length was 31//Apr-2002 : chgd length to 25
C_BOOLEAN:C305($4; $5)
C_TEXT:C284($sMsg)  // Command Replaced was o_C_STRING length was 255

If (Not:C34(<>fQuit))  //Don't start process if quitting
	
	$sProcedure:=$1
	$LStack:=$2
	$sProcName:=$3
	C_TEXT:C284(${6})
	
	$Lpid:=LProcessID($sProcName)
	If ($Lpid=-1)  //There is no process running
		If (Count parameters:C259>5)
			Case of 
				: (Count parameters:C259=6)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6)
				: (Count parameters:C259=7)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7)
				: (Count parameters:C259=8)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8)
				: (Count parameters:C259=9)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9)
				: (Count parameters:C259=10)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10)
				: (Count parameters:C259=11)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10; $11)
				: (Count parameters:C259=12)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10; $11; $12)
				: (Count parameters:C259=13)
					$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10; $11; $12; $13)
			End case 
			
		Else 
			$Lpid:=New process:C317($sProcedure; $LStack; $sProcName)
		End if 
		
	Else 
		
		If ($5)  //Is the multiview flag set
			$sProcName:=$sProcName+" "+String:C10(LNextView($sProcName)+1)
			If (Count parameters:C259>5)
				Case of 
					: (Count parameters:C259=6)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6)
					: (Count parameters:C259=7)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7)
					: (Count parameters:C259=8)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8)
					: (Count parameters:C259=9)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9)
					: (Count parameters:C259=10)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10)
					: (Count parameters:C259=11)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10; $11)
					: (Count parameters:C259=12)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10; $11; $12)
					: (Count parameters:C259=13)
						$Lpid:=New process:C317($sProcedure; $LStack; $sProcName; $6; $7; $8; $9; $10; $11; $12; $13)
				End case 
			Else 
				$Lpid:=New process:C317($sProcedure; $LStack; $sProcName)
			End if 
			
		Else 
			BRING TO FRONT:C326($Lpid)
		End if 
	End if 
	
	If ($Lpid=0)  //Oops something wrong
		If ($4)  //Is the warn the user flag set
			$sMsg:="Not enough memory to perform the action. "
			$sMsg:=$sMsg+"Try closing windows to make more memory available."
			BEEP:C151
			ALERT:C41($sMsg)
		End if 
	End if 
	
	$0:=$Lpid
	
Else 
	ALERT:C41("Shutting down database.  Can't start a new process now.")
	$0:=0
End if 
//End of procedure