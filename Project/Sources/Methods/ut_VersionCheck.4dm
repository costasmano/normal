//%attributes = {"invisible":true}
//Method: ut_VersionCheck
//Description
//  ` Compare current db version ($CheckVersion_txt) with an input value ($targetVers_txt)
//  ` Versions are in form NN.NN.NN.A
//  `  ` where NN any number
//  `  ` A any letter
// Parameters
// $0 : $check_L (-1 : less than ; 0 : equal ; 1 : greater)
// $1 : $targetVers_txt
// $2 : $CheckVersion_txt (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/25/14, 17:01:22
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_LONGINT:C283($check_L)
C_TEXT:C284($targetVers_txt; $CheckVersion_txt)
$targetVers_txt:=$1
$CheckVersion_txt:=<>Version
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$CheckVersion_txt:=$2
End if 

C_BOOLEAN:C305($DateInVer_b)

C_LONGINT:C283($pos_L; $Len_L)
$DateInVer_b:=Match regex:C1019("[0-9]+-[a-zA-Z]{3}-[0-9]{2,4}"; $targetVers_txt; 1; $pos_L; $Len_L)
If ($DateInVer_b)
	
	If ($pos_L>1)
		$targetVers_txt:=Substring:C12($targetVers_txt; 1; $pos_L-1)
	Else 
		$targetVers_txt:=Substring:C12($targetVers_txt; ($Len_L+1))
	End if 
	
End if 
$DateInVer_b:=Match regex:C1019("[0-9]+-[a-zA-Z]{3}-[0-9]{2,4}"; $CheckVersion_txt; 1; $pos_L; $Len_L)
If ($DateInVer_b)
	
	If ($pos_L>1)
		$CheckVersion_txt:=Substring:C12($CheckVersion_txt; 1; $pos_L-1)
	Else 
		$targetVers_txt:=Substring:C12($CheckVersion_txt; ($Len_L+1))
	End if 
	
End if 

ARRAY TEXT:C222($Targetparts_atxt; 0)
ARRAY TEXT:C222($CheckParts_atxt; 0)

ut_ParseVersionString($targetVers_txt; ->$Targetparts_atxt)
ut_ParseVersionString($CheckVersion_txt; ->$CheckParts_atxt)

$check_L:=0  //assume equal
C_LONGINT:C283($loop_L; $CheckParts_L; $TargetParts_L)
C_TEXT:C284($CheckPart_txt; $TargetPart_txt)
$CheckParts_L:=Size of array:C274($CheckParts_atxt)
$TargetParts_L:=Size of array:C274($Targetparts_atxt)

For ($loop_L; 1; $CheckParts_L)
	
	If ($loop_L>$TargetParts_L)
		$check_L:=1  //if we have reached more parts than target then it is greater
		$loop_L:=$CheckParts_L+1
	Else 
		$CheckPart_txt:=$CheckParts_atxt{$loop_L}
		$TargetPart_txt:=$Targetparts_atxt{$loop_L}
		$check_L:=ut_CompareParts_L($CheckPart_txt; $TargetPart_txt)
		Case of 
			: ($check_L=1)
				$loop_L:=$CheckParts_L+1
			: ($check_L=-1)
				$loop_L:=$CheckParts_L+1
				
		End case 
		
	End if 
	
End for 

$0:=$check_L
//End ut_VersionCheck