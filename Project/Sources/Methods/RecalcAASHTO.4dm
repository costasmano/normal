//%attributes = {"invisible":true}
If (False:C215)
	//procedure: RecalcAASHTO
	//purpose: Recalculate the AASHTO Sufficiency Rating in the current selection
	//created: 10/2/97
	//by: Albert Leung  
	
	//Modified 2-10-2000 : CM
	//    Adjusted GOTO XY x param from 6 pixels to 1 character
	//Modified 1-12-2000 : CM
	//    Changed it to use Progress bar
	
	Mods_2005_CM13
	// Modified by: costasmanousakis-(Designer)-(12/29/09 14:19:01)
	Mods_2009_12
	//Log the changes if any only for 4D client or 4D server running on the Boston DB "MHD BMS.4DB"
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 09:02:34)
	Mods_2013_05
	//  `use variable ◊DatabaseStructureName_txt
	Mods_2021_10  //Make sure server processes never display anything to screen when on server
	//Modified by: Chuck Miller (10/28/21 14:23:42)
	
End if 

C_LONGINT:C283($i; $Recs; $Interval; $total)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($1; $vbOnScreen; $OnServer_B)
If (Count parameters:C259>=1)
	$vbOnScreen:=$1
Else 
	$vbOnScreen:=True:C214
End if 
$OnServer_B:=Application type:C494=4D Server:K5:6
If ($vbOnScreen) & (Not:C34($OnServer_B))
	<>ProgressPID:=StartProgress("RecalcAASHTO"; "None"; "Recalculating AASHTO")
End if 

//NewWindow (132;55;0;-5;"Recalculating AASHTO")
//GOTO XY(1;2)  `2-10-2000 : CM
//MESSAGE("Record 00001")
$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
C_BOOLEAN:C305($NBIRecordChange_B)
$total:=$Recs
$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
C_BOOLEAN:C305($LogChanges_b)
$LogChanges_b:=False:C215
Case of 
	: ((Application type:C494=4D Remote mode:K5:5) & (Structure file:C489="MHD BMS.@"))
		$LogChanges_b:=True:C214
		
	: ((Application type:C494=4D Server:K5:6) & (<>DatabaseStructureName_txt="MHD BMS"))
		$LogChanges_b:=True:C214
End case 

FIRST RECORD:C50([Bridge MHD NBIS:1])
For ($i; 1; $Recs)
	$NBIRecordChange_B:=False:C215
	[Bridge MHD NBIS:1]AASHTO:5:=AASHTO_SuffRat
	$NBIRecordChange_B:=([Bridge MHD NBIS:1]AASHTO:5#Old:C35([Bridge MHD NBIS:1]AASHTO:5))
	$NBIRecordChange_B:=$NBIRecordChange_B | ([Bridge MHD NBIS:1]Item67:142#Old:C35([Bridge MHD NBIS:1]Item67:142))
	$NBIRecordChange_B:=$NBIRecordChange_B | ([Bridge MHD NBIS:1]Item68:143#Old:C35([Bridge MHD NBIS:1]Item68:143))
	$NBIRecordChange_B:=$NBIRecordChange_B | ([Bridge MHD NBIS:1]Item69:144#Old:C35([Bridge MHD NBIS:1]Item69:144))
	$NBIRecordChange_B:=$NBIRecordChange_B | ([Bridge MHD NBIS:1]Item70:140#Old:C35([Bridge MHD NBIS:1]Item70:140))
	If ($NBIRecordChange_B)
		If ($LogChanges_b)
			InitChangeStack(1)
			PushChange(1; ->[Bridge MHD NBIS:1]AASHTO:5)
			PushChange(1; ->[Bridge MHD NBIS:1]Item67:142)
			PushChange(1; ->[Bridge MHD NBIS:1]Item68:143)
			PushChange(1; ->[Bridge MHD NBIS:1]Item69:144)
			PushChange(1; ->[Bridge MHD NBIS:1]Item70:140)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		End if 
		
		SAVE RECORD:C53([Bridge MHD NBIS:1])
	End if 
	
	NEXT RECORD:C51([Bridge MHD NBIS:1])
	
	If ($vbOnScreen) & (Not:C34($OnServer_B))
		If ($i%$Interval)=0
			//GOTO XY(1;2)  `2-10-2000 : CM
			//MESSAGE("Record "+String($i;"00000"))
			UpdateProgress($i; $Recs)
		End if 
		// check if we got aborted from the Progress Bar display...
		If (<>Abort=True:C214)
			$total:=$i
			$i:=$Recs+1
		End if 
	End if 
	
End for 

If ($vbOnScreen) & (Not:C34($OnServer_B))
	POST OUTSIDE CALL:C329(<>ProgressPID)
	BEEP:C151
	ALERT:C41("AASHTO Recalculated for "+String:C10($total; "#####")+" records!")
End if 
