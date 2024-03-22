//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): costasmanousakis
// User name (4D): Designer
// Date and time: 10/20/11, 08:07:49
// ----------------------------------------------------
// Method: ut_ChannelOpenError
// Description
//  ` Catch errors from the Set Channel(10; ) command
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// First Release
	Mods_2011_10
End if 

Case of 
	: (Error=-54)
		ALERT:C41(Document+" is locked! SET CHANNEL command requires write access!")
	: (Error=-5000)
		ALERT:C41(Document+" is Read Only! SET CHANNEL command requires write access!")
	Else 
		ALERT:C41("Error "+String:C10(Error)+" trying to open "+Document+"! Please note SET CHANNEL command requires write access!")
End case 