//Method: DesignForward.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/05/22, 13:56:31
	// ----------------------------------------------------
	//Created : 
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These form used only for when designer or admin logs in moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
//
C_POINTER:C301($AddForward_ptr; $forward_ptr)
$AddForward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "v_1_230_txt")
$forward_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Forward")

If (Length:C16($AddForward_ptr->)>0)
	ARRAY TEXT:C222($Temp_atxt; 0)
	C_TEXT:C284($Forward_txt)
	//
	$AddForward_ptr->:=Uppercase:C13($AddForward_ptr->)
	$AddForward_ptr->:=Replace string:C233($AddForward_ptr->; " "; "")
	ut_NewTextToArray($AddForward_ptr->; ->$Temp_atxt; ",")
	C_LONGINT:C283($Loop_L)
	For ($Loop_L; 1; Size of array:C274($Temp_atxt))
		
		If ((Length:C16($Temp_atxt{$Loop_L})=5) & Match regex:C1019("DIST[1-6]"; $Temp_atxt{$Loop_L}; 1)) | ($Temp_atxt{$Loop_L}="DIVE")
			
			If (Position:C15($Temp_atxt{$Loop_L}; $forward_ptr->)>0)
				
			Else 
				$Forward_txt:=$Forward_txt+","+$Temp_atxt{$Loop_L}
				
			End if 
			
		End if 
		
	End for 
	If ($forward_ptr->="")
		$forward_ptr->:=$Forward_txt
	Else 
		$forward_ptr->:=$forward_ptr->+$Forward_txt
	End if 
	$AddForward_ptr->:=""
	
End if 
//End DesignForward.Button1