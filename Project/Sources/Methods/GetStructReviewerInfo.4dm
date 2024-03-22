//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/29/07, 13:44:13
	// ----------------------------------------------------
	// Method: GetStructReviewerInfo
	// Description
	// 
	// 
	// Parameters
	// $1 : Reviewer PID
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 
C_LONGINT:C283($1)
C_TEXT:C284(vPresvervationEngineer; vPEPhoneNum)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vPEname; $vPEsuffix; vPEinitial; vPEActing)  // Command Replaced was o_C_STRING length was 100

vPEname:=""
$vPEsuffix:=""
vPEinitial:=""
vPEActing:=""
//` Job Code = 16 = Presvervation Engineer
QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$1)
//FIRST RECORD([Personnel])
If (Records in selection:C76([Personnel:42])>0)
	If ([Personnel:42]Middle Name:4="")
		vPEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		vPEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	Else 
		vPEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
		vPEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	End if 
	$vPEsuffix:=[Personnel:42]Suffix:6
	vPEPhoneNum:=[Personnel:42]Phone_s:13
	If ($vPEsuffix#"")
		vPEname:=vPEname+", "+$vPEsuffix
		vPEname:=Replace string:C233(vPEname; ", ,"; ",")
	End if 
	
End if 

vPresvervationEngineer:=vPEname