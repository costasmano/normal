//%attributes = {"invisible":true}
//Method: Synch_ReturnForward
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/05/22, 11:11:27
	// ----------------------------------------------------
	//Created : 
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2022-03-21 18:52:19)
	Mods_2022_03
	//  `added check in array $Temp_axt to avoid blank elements
	
End if 
//
C_TEXT:C284($0; $1; $2; $3; $Forward_txt; $Item2_txt; $InspResp_txt; $TLDistrict_txt; $InspType_txt)
$InspType_txt:=$3
C_LONGINT:C283($4; $TeamLeader_L)
$TeamLeader_L:=$4
$Forward_txt:=""
If ($2="DIST@")
	//this is needed only for bridges inspected by MassDOT
	$Item2_txt:="DIST"+String:C10(Num:C11($1))
	$InspResp_txt:="DIST"+String:C10(Num:C11($2))
	If ($Item2_txt=$InspResp_txt)
		$Forward_txt:=$InspResp_txt
	Else 
		$Forward_txt:=$Item2_txt+","+$InspResp_txt
	End if 
	
End if 

ARRAY TEXT:C222($Temp_axt; 0)

If (Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1)
	
	C_LONGINT:C283($Loop_L)
	ut_NewTextToArray(<>FORWARD; ->$Temp_axt; ",")
	
	For ($Loop_L; 1; Size of array:C274($Temp_axt))
		If ($Temp_axt{$Loop_L}#"")
			If (Position:C15($Temp_axt{$Loop_L}; $Forward_txt)>0)
				
			Else 
				$Forward_txt:=$Forward_txt+","+$Temp_axt{$Loop_L}
			End if 
		End if 
	End for 
	
End if 

If ($InspType_txt="DV@")
	
	If (Position:C15("DIVE"; $Forward_txt)>0)
	Else 
		$Forward_txt:=$Forward_txt+",DIVE"
		
	End if 
	
End if 

//check for Division (= district) of TL or current user
If ($TeamLeader_L>0)
	//use TL division if defined
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$TeamLeader_L)
	
Else 
	//use current user's division
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=<>CurrentUser_PID)
	
End if 

Case of 
	: ([Personnel:42]Division No:7="0449")
		$TLDistrict_txt:="DIVE"
	: ([Personnel:42]Division No:7>"0440") & ([Personnel:42]Division No:7<"0449")
		$TLDistrict_txt:=Replace string:C233([Personnel:42]Division No:7; "044"; "DIST")
	Else 
		$TLDistrict_txt:=""
End case 

If ($TLDistrict_txt#"")
	If (Position:C15($TLDistrict_txt; $Forward_txt)>0)
	Else 
		$Forward_txt:=$Forward_txt+","+$TLDistrict_txt
		
	End if 
	
End if 


If (User in group:C338(Current user:C182; "Design Access Group"))
	vsForward:=$Forward_txt
	C_LONGINT:C283($height_l; $Width_L; $Win_l)
	FORM GET PROPERTIES:C674("DesignForward"; $Width_L; $height_l)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10)
	DIALOG:C40("DesignForward")
	CLOSE WINDOW:C154($Win_l)
	$0:=vsForward
Else 
	$0:=$Forward_txt
End if 

//End Synch_ReturnForward