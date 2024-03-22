//%attributes = {"invisible":true}
// Method: HI_CalcBridgeHIFields
// Description
// Update the Health index fields for the current selection of [Bridge mhd nbis] records.
//
// Parameters
// $1 : $vbOnScreen (boolean)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/23/05, 18:42:39
	// ----------------------------------------------------
	// ----------------------------------------------------
	Mods_2005_CM18
	// Modified by: costasmanousakis-(Designer)-(11/23/2005 16:58:25)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/13/2005 16:18:34)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(5/17/10 08:41:00)
	Mods_2010_05
	//Adjusted the StartProgress Call and added the first UpdateProgress
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	// Modified by: Costas Manousakis-(Designer)-(9/25/19 09:23:33)
	Mods_2019_09_bug
	//  `log changes to the H.I. fields - CallReference #660
	//  `All other tables except [bridge mhd nbis] set to RO; check if the Bridge record is loaded for write
	//  `unload the last record
	Mods_2021_10  //Make sure server processes never display anything to screen when on server
	//Modified by: Chuck Miller (10/28/21 14:23:42)
	
End if 

C_BOOLEAN:C305($1; $vbOnScreen; $OnServer_B)
If (Count parameters:C259>=1)
	$vbOnScreen:=$1
Else 
	$vbOnScreen:=True:C214
End if 

C_LONGINT:C283($i; $vl_NumRecs; $interval)
//C_STRING(255;$s)
$OnServer_B:=Application type:C494=4D Server:K5:6
If ($vbOnScreen) & (Not:C34($OnServer_B))
	ALERT:C41("Please run this routine with no users connected.")
End if 

$vl_NumRecs:=Records in selection:C76([Bridge MHD NBIS:1])
If ($vbonScreen) & (Not:C34($OnServer_B))
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Initializing Health Index Fields"; $vl_NumRecs; True:C214; " Bridges"; 3)
	
	//<>ProgressPID:=StartProgress ("InitHealthIndex";"None";"Initializing Health Index Fields")
	//UpdateProgress (0;$vl_NumRecs)
End if 

HI_InitBMSElmtArrays

READ ONLY:C145(*)
READ WRITE:C146([Bridge MHD NBIS:1])

$Interval:=20
FIRST RECORD:C50([Bridge MHD NBIS:1])
C_REAL:C285($vr_BrigdeHI; vr_BridgeTotVal; vr_BridgeCurVal)

For ($i; 1; $vl_NumRecs)
	
	If ($vbOnScreen)
		If (($i%$interval)=0)
			//update progress
			If (Not:C34($OnServer_B))
				UpdateProgressNew($progress_o; $i)
			End if 
			//UpdateProgress ($i;$vl_NumRecs)
			
		End if 
	End if 
	
	If (ut_LoadRecordonServer(->[Bridge MHD NBIS:1]))
		
		$vr_BrigdeHI:=HI_CalcBridgeHI(->vr_BridgeTotVal; ->vr_BridgeCurVal)  //ret value is in % !!
		
		If ($vr_BrigdeHI<0)  //no suitable Elements found
			C_LONGINT:C283($BridgeAge_L)
			$BridgeAge_L:=QR_BridgeAge
			C_REAL:C285($ItemAverage_r)
			$ItemAverage_r:=QR_NBIItemAvg([Bridge MHD NBIS:1]Item58:130; [Bridge MHD NBIS:1]Item59:131; [Bridge MHD NBIS:1]Item60:132; [Bridge MHD NBIS:1]Item62:134)
			Case of 
				: ([Bridge MHD NBIS:1]Item41:141="K")
					$vr_BrigdeHI:=0
				: (($BridgeAge_L<5) & ([Bridge MHD NBIS:1]Item41:141#"K"))  //less than 5 years old and not closed.
					If ($ItemAverage_r>7)
						$vr_BrigdeHI:=$ItemAverage_r/9
					Else 
						
					End if 
				: ($ItemAverage_r>6.5)
					$vr_BrigdeHI:=$ItemAverage_r/9
					
			End case 
		Else 
			$vr_BrigdeHI:=Round:C94(($vr_BrigdeHI/100); 6)
		End if 
		
		C_BOOLEAN:C305($vChangeSIA_b)
		$vChangeSIA_b:=False:C215
		If ([Bridge MHD NBIS:1]HI_Total_Elmt_Cost:220#vr_BridgeTotVal)
			[Bridge MHD NBIS:1]HI_Total_Elmt_Cost:220:=vr_BridgeTotVal
			$vChangeSIA_b:=True:C214
		End if 
		If ([Bridge MHD NBIS:1]HealthIndex:222#$vr_BrigdeHI)
			[Bridge MHD NBIS:1]HealthIndex:222:=$vr_BrigdeHI
			$vChangeSIA_b:=True:C214
		End if 
		If ([Bridge MHD NBIS:1]HI_Current_Elmt_Cost:221#vr_BridgeCurVal)
			[Bridge MHD NBIS:1]HI_Current_Elmt_Cost:221:=vr_BridgeCurVal
			$vChangeSIA_b:=True:C214
		End if 
		If ($vChangeSIA_b)
			InitChangeStack(1)
			PushChange(1; ->[Bridge MHD NBIS:1]HI_Total_Elmt_Cost:220)
			PushChange(1; ->[Bridge MHD NBIS:1]HI_Current_Elmt_Cost:221)
			PushChange(1; ->[Bridge MHD NBIS:1]HealthIndex:222)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			
			SAVE RECORD:C53([Bridge MHD NBIS:1])
		End if 
		
	End if 
	
	NEXT RECORD:C51([Bridge MHD NBIS:1])
	If ($vbOnScreen) & (Not:C34($OnServer_B))
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
			ALERT:C41("Initializing of Health Index fields aborted after "+String:C10($i; "#####")+" records")
			$i:=$vl_NumRecs+1
			//abort loop
		End if 
		
		//If (<>Abort)
		//  // check to see if aborted from the Progress window
		//ALERT("Initializing of Health Index fields aborted after "+String($i;"#####")+" records")
		//$i:=$vl_NumRecs+1
		//End if 
	End if 
	
End for 


UNLOAD RECORD:C212([Bridge MHD NBIS:1])
//CLOSE WINDOW
If ($vbOnScreen) & (Not:C34($OnServer_B))
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	//CALL PROCESS(<>ProgressPID)
End if 
C_TIME:C306($EndTime)
$EndTime:=Current time:C178(*)
HI_ClearBMSElmtArrays
//ALERT("Start "+String($start_time)+" End "+String($EndTime))