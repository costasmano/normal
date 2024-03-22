//%attributes = {"invisible":true}
//Method: PERS_ConvertAllStatsToObj
//Description
// convert login stats saved in Personnel table from tab delimited to object
// to be run only by Design access group
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/18/21, 12:04:11
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:00:19)
	Mods_2021_04
	//  `force Json parse to return Is object
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	QUERY:C277([Personnel:42]; [Personnel:42]MachineName_txt:18#"")
	C_OBJECT:C1216($stats_o)
	C_BOOLEAN:C305(4DError_b)
	C_TEXT:C284($statsObj_txt)
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Converting stats to objects in Personnel table"; \
		Records in selection:C76([Personnel:42]); \
		True:C214; \
		" personnel"; \
		3)
	C_LONGINT:C283($converted_L; $scanned_L; $notloaded_L)
	$converted_L:=0
	$scanned_L:=0
	$notloaded_L:=0
	FIRST RECORD:C50([Personnel:42])
	While (Not:C34(End selection:C36([Personnel:42])))
		//update progress
		UpdateProgressNew($progress_o; Selected record number:C246([Personnel:42]))
		$scanned_L:=$scanned_L+1
		If (ut_LoadRecord(->[Personnel:42]))
			
			C_TEXT:C284($lastMethOnError)
			$lastMethOnError:=Method called on error:C704
			4DError_b:=False:C215
			ON ERR CALL:C155("4D_Errors")
			
			$stats_o:=JSON Parse:C1218([Personnel:42]MachineName_txt:18; Is object:K8:27)
			If (4DError_b)
				//not object   //convert it
				
				4DError_b:=False:C215
				ON ERR CALL:C155($lastMethOnError)
				
				$stats_o:=PERS_ConvertStatsToObj([Personnel:42]MachineName_txt:18)
				$statsObj_txt:=JSON Stringify:C1217($stats_o)
				[Personnel:42]MachineName_txt:18:=$statsObj_txt
				SAVE RECORD:C53([Personnel:42])
				$converted_L:=$converted_L+1
				
			Else 
				ON ERR CALL:C155($lastMethOnError)
			End if 
		Else 
			$notloaded_L:=$notloaded_L+1
			ALERT:C41("Could not load record for ID "+String:C10([Personnel:42]Person ID:1)+\
				" : "+[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5)
		End if 
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
			//abort loop
			LAST RECORD:C200([Personnel:42])
		End if 
		
		NEXT RECORD:C51([Personnel:42])
	End while 
	
	//quit progress
	Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
	ALERT:C41("Scanned "+String:C10($scanned_L)+"\rConverted "+String:C10($converted_L)+"\rCould not load "+String:C10($notloaded_L))
	
End if 
//End PERS_ConvertAllStatsToObj