//%attributes = {"invisible":true}
//Method: WP_CleanupComments
//Description
// Clean up a Write Pro comments area before saving - remove trainling text and set font and size
// Parameters
// $1 : $WPARea_ptr
// $2 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/19/21, 10:08:31
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_POINTER:C301(WP_CleanupComments; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-05-03 19:00:42)
	Mods_2022_05
	//  `added setting line height to 100%
End if 
//

C_POINTER:C301($1; $WPArea_ptr)
$WPArea_ptr:=$1

C_OBJECT:C1216($range; $lastChar)
$range:=WP Text range:C1341($WParea_ptr->; wk start text:K81:165; wk end text:K81:164)

//need to trim tabs, CRs and spaces
C_LONGINT:C283($endC)
$endC:=1
$lastChar:=WP Text range:C1341($range; $range.end-$endC; wk end text:K81:164)
Repeat 
	If (WP Get text:C1575($lastChar)="\t") | (WP Get text:C1575($lastChar)="\r") | (WP Get text:C1575($lastChar)=" ")
		WP SET TEXT:C1574($lastChar; ""; wk replace:K81:177; wk include in range:K81:180)
		$endC:=$endC+1
	End if 
	$lastChar:=WP Text range:C1341($range; $range.end-$endC; wk end text:K81:164)
	
Until (Not:C34((WP Get text:C1575($lastChar)="\t") | (WP Get text:C1575($lastChar)="\r") | (WP Get text:C1575($lastChar)=" ")))

//set font and size
C_TEXT:C284($currFont)
C_LONGINT:C283($currSize)
WP GET ATTRIBUTES:C1345($range; wk font family:K81:65; $currFont; wk font size:K81:66; $currSize)

If (($currFont="") | ($currFont#"Arial"))
	//Not everything same or not Arial
	WP SET ATTRIBUTES:C1342($range; wk font family:K81:65; "Arial")
End if 
If ($currSize#11)
	//Not everything size 11
	WP SET ATTRIBUTES:C1342($range; wk font size:K81:66; 11)
End if 
WP SET ATTRIBUTES:C1342($range; wk line height:K81:51; "100%")
//End WP_CleanupComments