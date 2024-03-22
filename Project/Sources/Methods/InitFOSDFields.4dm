//%attributes = {"invisible":true}
If (False:C215)
	//procedure: InitFOSDFields
	//purpose: set the Boolean fields for SD and FO
	//created: 12/23/97
	//by: Albert Leung
	
	//modified 1-dec-2000 : CM
	//    changed it to use the Progress Bar
	
	Mods_2004_CM11
	Mods_2005_CM13
	// Modified by: costasmanousakis-(Designer)-(1/17/08 10:32:19)
	Mods_2007_CM_5401
	//Make sure the bridge table is RW
	// Modified by: costasmanousakis-(Designer)-(12/23/09 13:49:18)
	Mods_2009_12
	//Log the changes if any only for 4D client or 4D server running on the Boston DB "MHD BMS.4DB"
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 09:11:57)
	Mods_2013_05
	//  `use variable ◊DatabaseStructureName_txt
	// Modified by: Costas Manousakis-(Designer)-(5/11/18 12:06:42)
	Mods_2018_05
	//  `use new progress bar ; use method SIA_NewBridgeStatCalc to determine method of calculating SD/FO
	Mods_2021_10  //Make sure server processes never display anything to screen when on server
	//Modified by: Chuck Miller (10/28/21 14:23:42)
End if 

C_BOOLEAN:C305($1; $vbOnScreen; $OnServer_B)
C_BOOLEAN:C305(<>Abort)
If (Count parameters:C259>=1)
	$vbOnScreen:=$1
Else 
	$vbOnScreen:=True:C214
End if 
$OnServer_B:=Application type:C494=4D Server:K5:6
C_LONGINT:C283($i; $numrec; $interval)
//C_STRING(255;$s)
If ($vbOnScreen) & (Not:C34($OnServer_B))
	ALERT:C41("Please run this routine with no users connected.")
End if 
C_BOOLEAN:C305($BridgeMHDNBISRO_b)
$BridgeMHDNBISRO_b:=Read only state:C362([Bridge MHD NBIS:1])
If ($BridgeMHDNBISRO_b)
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 
ALL RECORDS:C47([Bridge MHD NBIS:1])

C_BOOLEAN:C305($Poor_or_OldSD_b)
$Poor_or_OldSD_b:=SIA_NewBridgeStatCalc
C_TEXT:C284($BrgCond_txt)

$numrec:=Records in selection:C76([Bridge MHD NBIS:1])
FIRST RECORD:C50([Bridge MHD NBIS:1])
//start the bar
C_OBJECT:C1216($Progress_o)

If ($vbonScreen) & (Not:C34($OnServer_B))
	//<>ProgressPID:=StartProgress ("INI_SD_FO";"None";"Initializing SD FO Fields")
	$Progress_o:=ProgressNew("Initializing SD FO Fields"; $numrec; True:C214; " Bridge Records"; 3)
End if 
C_BOOLEAN:C305($LogChanges_b)
$LogChanges_b:=False:C215
Case of 
	: ((Application type:C494=4D Remote mode:K5:5) & (Structure file:C489="MHD BMS.@"))
		$LogChanges_b:=True:C214
		
	: ((Application type:C494=4D Server:K5:6) & (<>DatabaseStructureName_txt="MHD BMS"))
		$LogChanges_b:=True:C214
		
End case 

$Interval:=20
For ($i; 1; $numrec)
	If ($vbOnScreen) & (Not:C34($OnServer_B))
		If (($i%$interval)=0)
			//UpdateProgress ($i;$numrec)
			UpdateProgressNew($Progress_o; $i)
		End if 
	End if 
	C_BOOLEAN:C305($oldSD_B; $newSD_B; $oldFO_B; $newFO_B)
	$oldSD_B:=[Bridge MHD NBIS:1]StructDef:103
	$oldFO_B:=[Bridge MHD NBIS:1]FunctObs:106
	$newSD_B:=False:C215
	$newFO_B:=False:C215
	
	If ([Bridge MHD NBIS:1]FHWARecord:174=True:C214)  //only or NBI records
		
		If ($Poor_or_OldSD_b)
			//New method using POOR Cond = SD
			$BrgCond_txt:=SIA_BridgeCondRating
			//clearTracefromhere:=True
			//TRACE
			
			Case of 
				: ($BrgCond_txt="POOR@")
					$newSD_B:=True:C214
			End case 
			//FO is not calculated any more.
		Else 
			If ([Bridge MHD NBIS:1]AASHTO:5<80)
				$newSD_B:=(bDeficient & bFuncObsCheck)
				If ($newSD_B=False:C215)
					$newFO_B:=(bObsolete & bFuncObsCheck)
				End if 
			End if 
		End if 
		
	End if 
	
	If (($oldSD_B#$newSD_B) | ($oldFO_B#$newFO_B))  //make changes only if needed
		[Bridge MHD NBIS:1]StructDef:103:=$newSD_B
		[Bridge MHD NBIS:1]FunctObs:106:=$newFO_B
		
		If ($LogChanges_b)
			InitChangeStack(1)
			PushChange(1; ->[Bridge MHD NBIS:1]StructDef:103)
			PushChange(1; ->[Bridge MHD NBIS:1]FunctObs:106)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			
		End if 
		SAVE RECORD:C53([Bridge MHD NBIS:1])
	End if 
	
	NEXT RECORD:C51([Bridge MHD NBIS:1])
	
	If ($vbOnScreen) & (Not:C34($OnServer_B))
		//check if progress stopped
		//abort loop
		If (Progress Stopped(OB Get:C1224($Progress_o; "progress"; Is longint:K8:6)))
			// check to see if aborted from the Progress window
			ALERT:C41("Initializing of SD FO fields aborted after "+String:C10($i; "#####")+" records")
		End if 
		$i:=$numrec+1
	End if 
	
End for 

//CLOSE WINDOW
If ($vbOnScreen) & (Not:C34($OnServer_B))
	//CALL PROCESS(<>ProgressPID)
	Progress QUIT(OB Get:C1224($Progress_o; "progress"; Is longint:K8:6))
End if 
UNLOAD RECORD:C212([Bridge MHD NBIS:1])
If ($BridgeMHDNBISRO_b)
	READ ONLY:C145([Bridge MHD NBIS:1])
End if 