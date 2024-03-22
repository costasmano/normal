If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/07/09, 20:18:58
	// ----------------------------------------------------
	// Method: Object Method: SCPOA_Consultant_atxt
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent (Optional)
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(2/2/10 09:18:13)
	Mods_2010_02
	//Added PushChange
	// Modified by: costasmanousakis-(Designer)-(6/13/11 16:51:29)
	Mods_2011_06
	//  `Added prompt for NTP date
End if 
POPUPMENUC(Self:C308; Self:C308; ->[ScourPOA:132]Consultant:26)
PushChange(1; ->[ScourPOA:132]Consultant:26)
C_TEXT:C284($NtpDate_s)
C_DATE:C307($NtpDate_d)
$NtpDate_s:=Request:C163("Enter NTP date for this POA :"; String:C10(Current date:C33(*)))
If (OK=1)
	$NtpDate_d:=Date:C102($NtpDate_s)
	If ($NtpDate_d#!00-00-00!)
		[ScourPOA:132]NTP_Date:30:=$NtpDate_d
		PushChange(1; ->[ScourPOA:132]NTP_Date:30)
	Else 
		ALERT:C41("Invalid Date Entered <"+$NtpDate_s+">!")
	End if 
	
End if 