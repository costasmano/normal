//%attributes = {"invisible":true}
//Method: PERS_UpdateLoginStats
//Description
// Update user login stats kept in Personnel table
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/18/21, 11:35:35
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	// Modified by: Costas Manousakis-(Designer)-(4/20/21 10:21:39)
	Mods_2021_04
	//  `force OB Get to use Is text - gives correct result when an attribute is not present
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:00:19)
	Mods_2021_04
	//  `force Json parse to return Is object
End if 
//

C_BOOLEAN:C305($ReadOnly_b)
$ReadOnly_b:=Read only state:C362([Personnel:42])

If (ut_LoadRecord(->[Personnel:42]))
	C_TEXT:C284($CurrentMachine_txt)
	$CurrentMachine_txt:=Current machine:C483
	//Check if it is a JSON object
	C_OBJECT:C1216($stats_o)
	
	If ([Personnel:42]MachineName_txt:18#"")
		C_BOOLEAN:C305(4DError_b)
		C_TEXT:C284($lastMethOnError)
		$lastMethOnError:=Method called on error:C704
		4DError_b:=False:C215
		ON ERR CALL:C155("4D_Errors")
		
		$stats_o:=JSON Parse:C1218([Personnel:42]MachineName_txt:18; Is object:K8:27)
		
		ON ERR CALL:C155($lastMethOnError)
		
		If (4DError_b)
			4DError_b:=False:C215
			$stats_o:=PERS_ConvertStatsToObj([Personnel:42]MachineName_txt:18)
		End if 
		
		ARRAY OBJECT:C1221($machines_ao; 0)
		
		OB GET ARRAY:C1229($stats_o; "stations"; $machines_ao)
		C_LONGINT:C283($machine_L)
		C_LONGINT:C283($loop_L)
		C_TEXT:C284($s_txt; $o_txt)
		For ($loop_L; 1; Size of array:C274($machines_ao))
			
			Case of 
				: (OB Get:C1224($machines_ao{$loop_L}; "station"; Is text:K8:3)=Current machine:C483) & \
					(OB Get:C1224($machines_ao{$loop_L}; "owner"; Is text:K8:3)=Current system user:C484)
					$machine_L:=$loop_L
					$loop_L:=Size of array:C274($machines_ao)+1
				: (OB Get:C1224($machines_ao{$loop_L}; "station"; Is text:K8:3)=Current machine:C483) & (OB Get:C1224($machines_ao{$loop_L}; "owner"; Is text:K8:3)="")
					//match the machine and the owner is blank
					$machine_L:=$loop_L  // possible
					
			End case 
			
		End for 
		
		C_LONGINT:C283($count_L)
		
		If ($machine_L>0)
			$count_L:=1+OB Get:C1224($machines_ao{$machine_L}; "count"; Is longint:K8:6)
			If ($machine_L>1)
				//only delete the entry if it's not the first on list
				DELETE FROM ARRAY:C228($machines_ao; $machine_L; 1)
				//and add one to the top
				INSERT IN ARRAY:C227($machines_ao; 1; 1)
			End if 
			
		Else 
			//no match - count =1
			$count_L:=1
			//add entry to top of list
			INSERT IN ARRAY:C227($machines_ao; 1; 1)
		End if 
		OB SET:C1220($machines_ao{1}; "station"; Current machine:C483; \
			"owner"; Current system user:C484; \
			"lastdate"; Current date:C33(*); \
			"count"; $count_L)
		
	Else 
		//start new
		ARRAY OBJECT:C1221($machines_ao; 1)
		OB SET:C1220($machines_ao{1}; "station"; Current machine:C483; \
			"owner"; Current system user:C484; \
			"lastdate"; Current date:C33(*); \
			"count"; 1)
		
	End if 
	
	OB SET ARRAY:C1227($stats_o; "stations"; $machines_ao)
	
	[Personnel:42]MachineName_txt:18:=JSON Stringify:C1217($stats_o)
	
	SAVE RECORD:C53([Personnel:42])
	UNLOAD RECORD:C212([Personnel:42])
	
End if 

If ($ReadOnly_b)
	READ ONLY:C145([Personnel:42])
End if 

//End PERS_UpdateLoginStats