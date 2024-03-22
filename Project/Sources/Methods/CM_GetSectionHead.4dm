//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 06/29/05, 11:05:00
	// ----------------------------------------------------
	// Method: CM_GetSectionHead
	// Description
	//   return Section Head name to the caller
	//
	// Parameters
	// ----------------------------------------------------
End if 

C_TEXT:C284($vSectionHead; $0)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284($vSHname; $vSHsuffix; $vSHinitial)  // Command Replaced was o_C_STRING length was 100

$vSHname:="Alexander K. Bardow"
$vSHsuffix:=", P.E."
$vSHinitial:="AKB"

//` Job Code = 8 = Section Head
QUERY:C277([Personnel:42]; [Personnel:42]Division No:7="0440"; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Job Code:8=8)

FIRST RECORD:C50([Personnel:42])
If (Records in selection:C76([Personnel:42])>0)
	If ([Personnel:42]Middle Name:4="")
		$vSHname:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		$vSHinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		$vSHsuffix:=[Personnel:42]Suffix:6
	Else 
		$vSHname:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
		$vSHinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		$vSHsuffix:=[Personnel:42]Suffix:6
	End if 
	
End if 

$vSectionHead:=$vSHname+$vSHsuffix
$0:=$vSectionHead
