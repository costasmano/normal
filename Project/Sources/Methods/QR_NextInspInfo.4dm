//%attributes = {"shared":true}
// ----------------------------------------------------
// Method: QR_NextInspInfo
// Description
//  ` Determine the next inspection and the type. assigns the values to process variables
//  ` SIA_NEXTINSP_DATE and SIA_NEXTINSPTYPE_TXT, SIA_NEXTINSPTYPECODE_TXT
//  ` Also returns the combined result in a text string
//  ` in the form "SIA_NEXTINSPTYPE_TXT SIA_NEXTINSP_DATE"
// 
// Parameters
// $0 : $CombineREs_txt
// $1 : $InfoType_txt 
// $2 : $StartDate_txt : starting date in text "MM/DD/YYYY" - if blank string the current date is used
// $3 : $AnyText : if passed indicates the first call.
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/10, 08:22:50
	
	Mods_2010_11
	// Modified by: costasmanousakis-(Designer)-(10/28/11 11:17:50)
	Mods_2011_10
	//  `Added process var SIA_NEXTINSPTYPECODE_TXT;
	//  `Changed the order in which the above and UW inspections are checked
	// Modified by: Costas Manousakis-(Designer)-(9/11/13 14:58:12)
	Mods_2013_09
	//  `Added  handling tunnel  inspecitoins
End if 
C_TEXT:C284($0; $RetValue)
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

C_TEXT:C284(SIA_NEXTINSPTYPE_TXT; SIA_NEXTINSPTYPECODE_TXT; $ThisInspType_txt; $ThisInspTypeCode_txt)
C_DATE:C307(SIA_NEXTINSP_DATE)
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	SIA_NEXTINSP_DATE:=!00-00-00!
	SIA_NEXTINSPTYPE_TXT:=""
	SIA_NEXTINSPTYPECODE_TXT:=""
End if 

C_DATE:C307($InspDate_d; $NextDate_d)
C_LONGINT:C283($Freq)
C_BOOLEAN:C305($Use)
$Use:=False:C215
Case of 
	: ($InfoType_txt="ANY")
		$RetValue:=QR_NextInspInfo("ABOVE"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("UW"; String:C10($StartDate_d))
		
	: ($InfoType_txt="ABOVE")
		$RetValue:=QR_NextInspInfo("Closed"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("Routine"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("FCR"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("CMI"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("Other"; String:C10($StartDate_d))
		
	: ($InfoType_txt="TUNNEL")
		QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		$RetValue:=QR_NextInspInfo("Routine"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("CMI"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("TOV"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("Special1"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("Special2"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("Special3"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("Closed"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("Other"; String:C10($StartDate_d))
		
	: ($InfoType_txt="UW")
		$RetValue:=QR_NextInspInfo("UWRoutine"; String:C10($StartDate_d))
		$RetValue:=QR_NextInspInfo("UWSpec"; String:C10($StartDate_d))
		
	: ($InfoType_txt="FCR")
		$InspDate_d:=[Bridge MHD NBIS:1]Item93A:169
		$Freq:=[Bridge MHD NBIS:1]Item92AB:164
		$Use:=[Bridge MHD NBIS:1]Item92AA:163
		$ThisInspType_txt:="Fracture Crit."
		$ThisInspTypeCode_txt:="FCR"
		
	: ($InfoType_txt="Routine")
		$InspDate_d:=[Bridge MHD NBIS:1]Item90:161
		$Freq:=24
		$Use:=True:C214
		$ThisInspType_txt:="Routine"
		$ThisInspTypeCode_txt:="RTN"
		
	: ($InfoType_txt="CMI")
		$InspDate_d:=[Bridge MHD NBIS:1]Item93C:171
		$Freq:=[Bridge MHD NBIS:1]Item92CB:168
		$Use:=[Bridge MHD NBIS:1]Item92CA:167
		$ThisInspType_txt:="Special Member"
		$ThisInspTypeCode_txt:="CMI"
		
	: ($InfoType_txt="Other")
		$InspDate_d:=[Bridge MHD NBIS:1]OtherIDate:41
		$Freq:=[Bridge MHD NBIS:1]OtherIFreq:43
		$Use:=[Bridge MHD NBIS:1]OtherInsp:42
		$ThisInspType_txt:="Other"
		$ThisInspTypeCode_txt:="OTH"
		
	: ($InfoType_txt="Closed")
		$InspDate_d:=[Bridge MHD NBIS:1]ClosedIDate:44
		$Freq:=[Bridge MHD NBIS:1]ClosedIFreq:46
		$Use:=[Bridge MHD NBIS:1]ClosedInsp:45
		$ThisInspType_txt:="Closed"
		$ThisInspTypeCode_txt:="CLD"
		
		
	: ($InfoType_txt="UWRoutine")
		$InspDate_d:=[Bridge MHD NBIS:1]Item93B:170
		$Freq:=[Bridge MHD NBIS:1]Item92BB:166
		$Use:=[Bridge MHD NBIS:1]Item92BA:165
		$ThisInspType_txt:="UW Routine"
		$ThisInspTypeCode_txt:="DVE"
		
	: ($InfoType_txt="UWSpec")
		If ([Bridge MHD NBIS:1]UWSpInspDate:214=!00-00-00!)
			$InspDate_d:=[Bridge MHD NBIS:1]Item93B:170
		Else 
			$InspDate_d:=[Bridge MHD NBIS:1]UWSpInspDate:214
		End if 
		$Freq:=[Bridge MHD NBIS:1]UWSpInspFreq:213
		$Use:=[Bridge MHD NBIS:1]UWSpInsp:212
		$ThisInspType_txt:="UW Special"
		$ThisInspTypeCode_txt:="DVS"
		
	: ($InfoType_txt="TOV")
		$InspDate_d:=[TunnelInfo:151]OverHeadInspDate_d:22
		$Freq:=[TunnelInfo:151]OverHeadInspFreq_i:23
		$Use:=($Freq>0)
		$ThisInspType_txt:="Tunnel Overhead Items"
		$ThisInspTypeCode_txt:="TOV"
		
	: ($InfoType_txt="Special1")
		$InspDate_d:=[TunnelInfo:151]SpecialInsp1Date_d:24
		$Freq:=[TunnelInfo:151]SpecialInsp1Freq_i:25
		$Use:=($Freq>0)
		$ThisInspType_txt:="Tunnel Special 1"
		$ThisInspTypeCode_txt:="SP1"
		
	: ($InfoType_txt="Special2")
		$InspDate_d:=[TunnelInfo:151]SpecialInsp2Date_d:26
		$Freq:=[TunnelInfo:151]SpecialInsp2Freq_i:27
		$Use:=($Freq>0)
		$ThisInspType_txt:="Tunnel Special 2"
		$ThisInspTypeCode_txt:="SP2"
		
	: ($InfoType_txt="Special3")
		$InspDate_d:=[TunnelInfo:151]SpecialInsp3Date_d:28
		$Freq:=[TunnelInfo:151]SpecialInsp3Freq_i:29
		$Use:=($Freq>0)
		$ThisInspType_txt:="Tunnel Special 3"
		$ThisInspTypeCode_txt:="SP3"
		
End case 

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
If ($NextDate_d#!00-00-00!)
	Case of 
		: (($NextDate_d<SIA_NEXTINSP_DATE) | (SIA_NEXTINSP_DATE=!00-00-00!))
			SIA_NEXTINSP_DATE:=$NextDate_d
			SIA_NEXTINSPTYPE_TXT:=$ThisInspType_txt
			SIA_NEXTINSPTYPECODE_TXT:=$ThisInspTypeCode_txt
		: ($NextDate_d=SIA_NEXTINSP_DATE)
			SIA_NEXTINSPTYPE_TXT:=SIA_NEXTINSPTYPE_TXT+", "+$ThisInspType_txt
			
	End case 
	
End if 
If (SIA_NEXTINSP_DATE=!00-00-00!)
	$0:=""
Else 
	$0:=SIA_NEXTINSPTYPE_TXT+" "+String:C10(SIA_NEXTINSP_DATE; Internal date short:K1:7)
End if 