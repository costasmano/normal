//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/30/09, 14:14:48
	// ----------------------------------------------------
	// Method: QR_NextInspDate
	// Description
	//  ` Get the next inspection date - can ask for any, above, uw types, and a start date. 
	//  ` Also uses var SIA_INSPECTIONMONTH_d if defined
	// 
	// Parameters
	// $1 : $InspType 
	//  ` "ANY"   - default
	//  ` "ABOVE"
	//  ` "UW"
	//  ` 
	// $2 : $StartDate_d   : Optional - must be greater than current date
	//  ` 
	//  ` 
	
	// ----------------------------------------------------
	
	Mods_2009_12
End if 
C_TEXT:C284($InspType)
$InspType:="ANY"
C_DATE:C307($StartDate_d; SIA_INSPECTIONMONTH_d)
If (SIA_INSPECTIONMONTH_d=!00-00-00!)
	$StartDate_d:=Current date:C33(*)
Else 
	$StartDate_d:=SIA_INSPECTIONMONTH_d
End if 

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$InspType:=$1
End if 
If (Count parameters:C259>1)
	C_DATE:C307($2)
	If ($2>$StartDate_d)
		$StartDate_d:=$2
	End if 
	
End if 
$StartDate_d:=Date:C102(String:C10(Month of:C24($StartDate_d))+"/1/"+String:C10(Year of:C25($StartDate_d)))  //roll it to the 1st of the month

C_DATE:C307($InspDate_d; $NextDate_d; $0)
C_LONGINT:C283($Freq)
C_BOOLEAN:C305($Use; $Calculate)
$Calculate:=True:C214
Case of 
	: ($InspType="ANY")
		$NextDate_d:=MinDate(QR_NextInspDate("ABOVE"; $StartDate_d); QR_NextInspDate("UW"; $StartDate_d))
		$Calculate:=False:C215  //we are done
		
	: ($InspType="ABOVE")
		$NextDate_d:=MinDate(QR_NextInspDate("Routine"; $StartDate_d); QR_NextInspDate("FCR"; $StartDate_d); QR_NextInspDate("CMI"; $StartDate_d); QR_NextInspDate("Other"; $StartDate_d); QR_NextInspDate("Closed"; $StartDate_d))
		$Calculate:=False:C215  //we are done
		
	: ($InspType="UW")
		$NextDate_d:=MinDate(QR_NextInspDate("UWRoutine"; $StartDate_d); QR_NextInspDate("UWSpec"; $StartDate_d))
		$Calculate:=False:C215  //we are done
		
	: ($InspType="Routine")
		$InspDate_d:=[Bridge MHD NBIS:1]Item90:161
		$Freq:=[Bridge MHD NBIS:1]Item91:162
		$Use:=True:C214
	: ($InspType="FCR")
		$InspDate_d:=[Bridge MHD NBIS:1]Item93A:169
		$Freq:=[Bridge MHD NBIS:1]Item92AB:164
		$Use:=[Bridge MHD NBIS:1]Item92AA:163
		
	: ($InspType="CMI")
		$InspDate_d:=[Bridge MHD NBIS:1]Item93C:171
		$Freq:=[Bridge MHD NBIS:1]Item92CB:168
		$Use:=[Bridge MHD NBIS:1]Item92CA:167
		
	: ($InspType="Other")
		$InspDate_d:=[Bridge MHD NBIS:1]OtherIDate:41
		$Freq:=[Bridge MHD NBIS:1]OtherIFreq:43
		$Use:=[Bridge MHD NBIS:1]OtherInsp:42
		
	: ($InspType="Closed")
		$InspDate_d:=[Bridge MHD NBIS:1]ClosedIDate:44
		$Freq:=[Bridge MHD NBIS:1]ClosedIFreq:46
		$Use:=[Bridge MHD NBIS:1]ClosedInsp:45
		
	: ($InspType="UWRoutine")
		$InspDate_d:=[Bridge MHD NBIS:1]Item93B:170
		$Freq:=[Bridge MHD NBIS:1]Item92BB:166
		$Use:=[Bridge MHD NBIS:1]Item92BA:165
		
	: ($InspType="UWSpec")
		If ([Bridge MHD NBIS:1]UWSpInspDate:214=!00-00-00!)
			$InspDate_d:=[Bridge MHD NBIS:1]Item93B:170
		Else 
			$InspDate_d:=[Bridge MHD NBIS:1]UWSpInspDate:214
		End if 
		$Freq:=[Bridge MHD NBIS:1]UWSpInspFreq:213
		$Use:=[Bridge MHD NBIS:1]UWSpInsp:212
End case 

If ($Calculate)
	
	If ($InspDate_d=!00-00-00!)
		$InspDate_d:=[Bridge MHD NBIS:1]Item90:161
	End if 
	$NextDate_d:=!00-00-00!
	
	If ($use)
		If ($InspDate_d#!00-00-00!)
			If ($Freq>0)
				$NextDate_d:=$InspDate_d
				Repeat 
					$NextDate_d:=Add to date:C393($NextDate_d; 0; $Freq; 0)
				Until ($NextDate_d>=$StartDate_d)
				$NextDate_d:=Date:C102(String:C10(Month of:C24($NextDate_d))+"/1/"+String:C10(Year of:C25($NextDate_d)))  //roll it to the 1st of the month
			End if 
		End if 
	End if 
	
End if 
If ($NextDate_d=!9999-12-31!)
	$NextDate_d:=!00-00-00!
End if 

$0:=$NextDate_d