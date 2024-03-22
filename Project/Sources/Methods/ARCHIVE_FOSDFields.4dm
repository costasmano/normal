//%attributes = {"invisible":true}
// Method: ARCHIVE_FOSDFields
// Description
// Re-Calculate the SD FO fields in the bridge archive table
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/10, 17:56:45
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2010_04
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(9/16/11 16:38:38)
	Mods_2011_09
	//  `Use the current selection of archive records
	// Modified by: costasmanousakis-(Designer)-(10/21/11 10:09:25)
	Mods_2011_10
	//  `use method ARCHIVE_SDFOCalc
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
	
End if 
C_BOOLEAN:C305($1; $vbOnScreen)
C_BOOLEAN:C305(<>Abort)
If (Count parameters:C259>=1)
	$vbOnScreen:=$1
Else 
	$vbOnScreen:=True:C214
End if 

C_LONGINT:C283($i; $numrec; $interval)
//C_STRING(255;$s)

If ($vbOnScreen)
	ALERT:C41("Please run this routine with no users connected.")
End if 
C_BOOLEAN:C305($BridgeMHDNBISRO_b)
$BridgeMHDNBISRO_b:=Read only state:C362([BridgeMHDNBISArchive:139])
If ($BridgeMHDNBISRO_b)
	READ WRITE:C146([BridgeMHDNBISArchive:139])
End if 

$numrec:=Records in selection:C76([BridgeMHDNBISArchive:139])
FIRST RECORD:C50([BridgeMHDNBISArchive:139])
C_OBJECT:C1216($progressObj_o)
If ($vbonScreen)
	$progressObj_o:=ProgressNew("Initializing ARCHIVE SD FO Fields"; $numrec; True:C214; ""; 3)
	//<>ProgressPID:=StartProgress ("ARCH_INI_SD_FO";"None";"Initializing ARCHIVE SD FO Fields")
End if 
C_TEXT:C284($Item5)  // Command Replaced was o_C_STRING length was 9
C_REAL:C285($Item49)
C_BOOLEAN:C305($Item112)
C_TEXT:C284($Item42)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($Item27; $Item106)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($Item42; $Item58; $Item59; $Item60; $Item62; $Item67; $Item71; $Item43b; $Item68; $Item69; $Item72)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item43)  // Command Replaced was o_C_STRING length was 3

$Interval:=20
For ($i; 1; $numrec)
	If ($vbOnScreen)
		If (($i%$interval)=0)
			//UpdateProgress ($i;$numrec)
			//update progress
			UpdateProgressNew($progressObj_o; $i)
			
		End if 
	End if 
	C_BOOLEAN:C305($oldSD_B; $newSD_B; $oldFO_B; $newFO_B)
	ARCHIVE_SDFOCalc(->$newSD_B; ->$newFO_B; ->[BridgeMHDNBISArchive:139])
	If ((Old:C35([BridgeMHDNBISArchive:139]StructDef:102)#$newSD_B) | (Old:C35([BridgeMHDNBISArchive:139]FunctObs:105)#$newFO_B))
		[BridgeMHDNBISArchive:139]StructDef:102:=$newSD_B
		[BridgeMHDNBISArchive:139]FunctObs:105:=$newFO_B
		SAVE RECORD:C53([BridgeMHDNBISArchive:139])
	End if 
	NEXT RECORD:C51([BridgeMHDNBISArchive:139])
	
	//If (<>Abort)
	//If ($vbOnScreen)
	//  // check to see if aborted from the Progress window
	//ALERT("Initializing of SD FO fields aborted after "+String($i;"#####")+" records")
	//End if 
	//$i:=$numrec+1
	//End if 
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($progressObj_o; "progress")))
		//abort loop
		If ($vbOnScreen)
			// check to see if aborted from the Progress window
			ALERT:C41("Initializing of SD FO fields aborted after "+String:C10($i; "#####")+" records")
		End if 
		$i:=$numrec+1
	End if 
	
	
End for 
//CLOSE WINDOW
If ($vbOnScreen)
	//CALL PROCESS(<>ProgressPID)
	//quit progress
	Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
End if 
UNLOAD RECORD:C212([BridgeMHDNBISArchive:139])
If ($BridgeMHDNBISRO_b)
	READ ONLY:C145([BridgeMHDNBISArchive:139])
End if 