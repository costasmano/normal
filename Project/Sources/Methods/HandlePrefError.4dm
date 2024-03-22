//%attributes = {"invisible":true}
If (False:C215)
	//procedure: HandlePrefError
	//by: Albert Leung
	//created: 10/27/97
	//purpose: handle error file not found  
	//Couldn't find preferences file
	//Use defaults stored in data file
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//Modified by: Chuck Miller (12/27/21 13:37:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//[Preferences]ZoneInfo hase been renamed to [Preferences]DistrictInformation_s and is no longer used in the same way
	//[Preferences]Protocol has been renamed to [Preferences]LastRefID_L and is no longer used in the same way
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
ALL RECORDS:C47([Preferences:57])
FIRST RECORD:C50([Preferences:57])
<>Destination:=[Preferences:57]Destination:1
<>Transfer:=[Preferences:57]Transfer Type:2
<>Forward:=[Preferences:57]Forward:3
//<>ZoneInfo:=[Preferences]ZoneInfo
<>ManualCon:=[Preferences:57]ManualCon:5
<>ShowPrint:=[Preferences:57]ShowPrintDialog:6
//<>Protocol:=[Preferences]Protocol
<>ForwardIP:=[Preferences:57]ForwardIP:10
<>DestIP:=[Preferences:57]DestIP:9