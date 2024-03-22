//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/12/06, 11:49:35
	// ----------------------------------------------------
	// Method: INI_LoadDBIEPhones
	// Description
	// Load into array the phone numbers of the DBIEs
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM07
End if 
ARRAY TEXT:C222(aDBIEphone; 0)  //Command Replaced was o_ARRAY string length was 20
READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]Active:11=True:C214)
QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Division No:7="044@")
QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Job Code:8=1)
ORDER BY:C49([Personnel:42]; [Personnel:42]Division No:7)
SELECTION TO ARRAY:C260([Personnel:42]Phone_s:13; aDBIEphone)
READ WRITE:C146([Personnel:42])