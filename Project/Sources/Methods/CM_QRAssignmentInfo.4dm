//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/19/09, 23:45:15
	// ----------------------------------------------------
	// Method: CM_QRAssignmentInfo
	// Description
	// Retrieve various pieces of info for an assignment depending on the passed parameter.
	// 
	// Parameters
	// $1 : $Task "BINS" | "Towns" | "BDEPTS" | "BDEPTBINS"
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
End if 
C_TEXT:C284($1)
C_TEXT:C284($0; $Result_txt)
READ ONLY:C145([Contract_Project_Maintenance:100])
$Result_txt:=""
QUERY:C277([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignID:13=[Contract_Assignment_Maintenance:101]AssignID:3)
If (Records in selection:C76([Contract_Project_Maintenance:100])>0)
	ARRAY TEXT:C222($Res_atxt; 0)
	
	Case of 
		: ($1="BIN@")
			SELECTION TO ARRAY:C260([Contract_Project_Maintenance:100]BIN:5; $Res_atxt)
			For ($iLoop; 1; Size of array:C274($Res_atxt))
				$Res_atxt{$iLoop}:=Replace string:C233($Res_atxt{$iLoop}; "-"; "")
			End for 
			
		: ($1="BDEPTBINS@")
			ARRAY TEXT:C222($Bins_atxt; 0)
			ARRAY TEXT:C222($Bdepts_atxt; 0)
			SELECTION TO ARRAY:C260([Contract_Project_Maintenance:100]BridgeNo:4; $Bdepts_atxt; [Contract_Project_Maintenance:100]BIN:5; $Bins_atxt)
			For ($iLoop; 1; Size of array:C274($Bdepts_atxt))
				$Bdepts_atxt{$iLoop}:=Replace string:C233($Bdepts_atxt{$iLoop}; "-"; "")
				$Bins_atxt{$iLoop}:=Replace string:C233($Bins_atxt{$iLoop}; "-"; "")
			End for 
			SORT ARRAY:C229($Bdepts_atxt; $Bins_atxt)
			
			C_LONGINT:C283($iLoop; $ResCount)
			ARRAY TEXT:C222($Res_atxt; Size of array:C274($Bdepts_atxt))
			$ResCount:=0
			If ($Bdepts_atxt{1}#"")
				$ResCount:=1
				$Res_atxt{1}:=$Bdepts_atxt{1}+" ("+$Bins_atxt{1}
			Else 
				
			End if 
			
			For ($iLoop; 2; Size of array:C274($Bdepts_atxt))
				If ($Bdepts_atxt{$iLoop}=$Bdepts_atxt{$iLoop-1})
					$Res_atxt{$ResCount}:=$Res_atxt{$ResCount}+", "+$Bins_atxt{$iLoop}
				Else 
					$Res_atxt{$ResCount}:=$Res_atxt{$ResCount}+")"
					$ResCount:=$ResCount+1
					$Res_atxt{$ResCount}:=$Bdepts_atxt{$iLoop}+" ("+$Bins_atxt{$iLoop}
				End if 
				
			End for 
			If ($ResCount>0)
				$Res_atxt{$ResCount}:=$Res_atxt{$ResCount}+")"
			End if 
			ARRAY TEXT:C222($Res_atxt; $ResCount)
		: ($1="TOWN@")
			DISTINCT VALUES:C339([Contract_Project_Maintenance:100]Town:7; $Res_atxt)
			
		: ($1="BDEPT@")
			DISTINCT VALUES:C339([Contract_Project_Maintenance:100]BridgeNo:4; $Res_atxt)
			For ($iLoop; 1; Size of array:C274($Res_atxt))
				$Res_atxt{$iLoop}:=Replace string:C233($Res_atxt{$iLoop}; "-"; "")
			End for 
			
	End case 
	SORT ARRAY:C229($Res_atxt)
	If ($Res_atxt{1}#"")
		$Result_txt:=$Res_atxt{1}
	End if 
	C_LONGINT:C283($iloop)
	For ($iloop; 2; Size of array:C274($Res_atxt))
		If ($Res_atxt{$iloop}#"")
			If ($Result_txt#"")
				$Result_txt:=$Result_txt+", "+$Res_atxt{$iloop}
			Else 
				$Result_txt:=$Res_atxt{$iloop}
			End if 
			
		End if 
	End for 
	
End if 
READ WRITE:C146([Contract_Project_Maintenance:100])
$0:=$Result_txt