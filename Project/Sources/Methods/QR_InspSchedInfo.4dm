//%attributes = {"shared":true}
// ----------------------------------------------------
// Method: QR_InspSchedInfo
// Description
//  ` Calls QR_NextInspInfo and then uses SIA_NEXTINSPTYPECODE_TXT to find the last
//  ` matching inspection record. Then in the quick report fields from the inspection record can be used. 
// 
// Parameters
// $1 : $InfoType_txt 
// $2 : $StartDate_txt : starting date in text "MM/DD/YYYY" - if blank string the current date is used
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/28/11, 11:17:09
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(9/11/13 16:49:48)
	Mods_2013_09
	//  `Added handling of tunnel inspections
End if 
C_TEXT:C284($InfoType_txt)
$InfoType_txt:="ANY"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$InfoType_txt:=$1
End if 
If ($InfoType_txt="")
	$InfoType_txt:="ANY"
End if 

C_DATE:C307($StartDate_d)
$StartDate_d:=Current date:C33(*)
If (Count parameters:C259>1)
	C_TEXT:C284($2; $StartDate_txt)
	$StartDate_txt:=$2
	$StartDate_d:=Date:C102($StartDate_txt)
	If ($StartDate_d=!00-00-00!)
		$StartDate_d:=Current date:C33(*)
	End if 
	
End if 
C_BOOLEAN:C305($TNLRO_b)
$TNLRO_b:=Read only state:C362([TunnelInfo:151])
If (Not:C34($TNLRO_b))
	READ ONLY:C145([TunnelInfo:151])
End if 
QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
QR_NextInspInfo($InfoType_txt; String:C10($StartDate_d); "Start")

C_BOOLEAN:C305($inspRO_b)
$inspRO_b:=Read only state:C362([Inspections:27])
If (Not:C34($inspRO_b))
	READ ONLY:C145([Inspections:27])
End if 
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
Case of 
	: (SIA_NEXTINSPTYPECODE_TXT="RTN")
		//we search for RTN, RTA, CUL
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL")
	: (SIA_NEXTINSPTYPECODE_TXT="DVE")
		//we search for DVE, DVS
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="DVE"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="DVL")
	: (SIA_NEXTINSPTYPECODE_TXT="CMI")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CMI")
	: (SIA_NEXTINSPTYPECODE_TXT="DVS")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="DVE"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="DVL"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="DVS")
	: (SIA_NEXTINSPTYPECODE_TXT="TOV")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="TOV")
	: (SIA_NEXTINSPTYPECODE_TXT="SP1")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="CMI")
	: (SIA_NEXTINSPTYPECODE_TXT="SP2")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="CMI")
	: (SIA_NEXTINSPTYPECODE_TXT="SP3")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="CMI")
	Else 
		//normal search
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6=SIA_NEXTINSPTYPECODE_TXT)
End case 
ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
FIRST RECORD:C50([Inspections:27])

If (Not:C34($inspRO_b))
	READ WRITE:C146([Inspections:27])
End if 
If (Not:C34($TNLRO_b))
	READ WRITE:C146([TunnelInfo:151])
End if 