//%attributes = {"invisible":true}
//Method: ut_MountVolume
//Description
// Mount a volume
// Parameters
// $0 : $mountmessage : "success" or some error text
// $1 : $serverPath
// $2 : $username - can be blank
// $3 : $password - can be blank
// $4 : drive letter for windows only
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/25/19, 13:52:08
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
	// Modified by: Costas Manousakis-(Designer)-(4/22/21 21:31:01)
	Mods_2021_04
	//  `added set Env Variable statements
	//  `For mac , after LEP, do a Repeat loop to check if the volume was mounted.
	//  `The open smb command is asynchronous and it will wait for the user to enter username and password
	// Modified by: Costas Manousakis-(Designer)-(2022-10-06 12:22:08)
	Mods_2022_10
	//  `volume list might not be accurate when shares on different servers have same name
	//  `use SysDoc_IsShareMounted instead
	
End if 
//
C_TEXT:C284($1; $server_path)
C_TEXT:C284($2; $username)
C_TEXT:C284($3; $password)

C_TEXT:C284($4; $win_drive_assign)
C_TEXT:C284($0)
C_TEXT:C284($LEP_Command; $in; $out; $error)
ARRAY TEXT:C222($Volumes_atxt; 0)
VOLUME LIST:C471($Volumes_atxt)
ARRAY TEXT:C222($Parts_atxt; 0)

If (Count parameters:C259>2)
	$server_path:=$1
	$username:=$2
	$password:=$3
	
	//SET ENVIRONMENT VARIABLE("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"false")
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	
	If (Is macOS:C1572)  // mac
		
		$LEP_Command:="open smb://"+$username+":"+$password+"@"+$server_path
		
		$in:=""
		LAUNCH EXTERNAL PROCESS:C811($LEP_Command; $in; $out; $error)
		
		If ($error="")
			ARRAY TEXT:C222($volumes_atxt; 0)
			ARRAY TEXT:C222($ServerParts_atxt; 0)
			ut_NewTextToArray($server_path; ->$ServerParts_atxt; "/")
			C_LONGINT:C283($Tries_L; $Volumemounted_L)
			C_TEXT:C284($MyVolume_txt)
			// the volume is the last part of the server path
			$MyVolume_txt:=$ServerParts_atxt{Size of array:C274($ServerParts_atxt)}
			
			$Tries_L:=0
			C_OBJECT:C1216($mountinfo)
			$Volumemounted_L:=0
			
			Repeat 
				
				If (True:C214)
					$mountinfo:=SysDoc_IsShareMounted($server_path)
					
					If ($mountinfo.mounted)
						$Volumemounted_L:=1
					Else 
						DELAY PROCESS:C323(Current process:C322; 60)
						$Tries_L:=$Tries_L+1
					End if 
					
				Else 
					//  *** Old way 
					VOLUME LIST:C471($volumes_atxt)
					$Volumemounted_L:=Find in array:C230($volumes_atxt; $MyVolume_txt)
					If ($Volumemounted_L>0)
					Else 
						DELAY PROCESS:C323(Current process:C322; 60)
						$Tries_L:=$Tries_L+1
					End if 
					
					//  *** Old way END
					
				End if 
				
			Until (($Tries_L>120) | ($Volumemounted_L>0))
			
			If ($Volumemounted_L>0)
				$0:="Success"  // success
			Else 
				$0:="Did not see the required volume "+$MyVolume_txt+" mounted within the alotted delay of 2min."
			End if 
			
		Else 
			$0:=$error  // error on the LAUNCH EXTERNAL PROCESS
		End if 
		
	Else 
		
		If (Count parameters:C259=4)
			$win_drive_assign:=$4+":"
		End if 
		$server_path:=Replace string:C233($server_path; "/"; "\\")
		
		If (Substring:C12($server_path; Length:C16($server_path); 1)="\\")
			$server_path:=Substring:C12($server_path; 1; (Length:C16($server_path)-1))
		End if 
		If ($password="") & ($username="")
			$LEP_Command:="net use "+$win_drive_assign+" \\\\"+$server_path
			
		Else 
			$LEP_Command:="net use "+$win_drive_assign+" \\\\"+$server_path+" "+$password+"/user:"+$username
			
		End if 
		
		$in:=""
		LAUNCH EXTERNAL PROCESS:C811($LEP_Command; $in; $out; $error)
		
		If ($error="")
			$0:="Success"  //success
		Else 
			$0:=$error  // error on the LAUNCH EXTERNAL PROCESS
		End if 
		
	End if 
Else 
	$0:="ERROR: Not enough input parameters"  // Not enough parameters
End if 

//End ut_MountVolume