//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/15/10, 11:28:39
	// ----------------------------------------------------
	// Method: Reapply_MakeNewLogEntry
	// Description
	// Create an Activity log entry from the Reapply process. Used by all the ReApplyXXX routines
	// 
	// Parameters
	// $1 : $RecType_txt 
	// $2 : $cLocal
	// $3 : $cParent
	// ----------------------------------------------------
	
	Mods_2010_03
	
	// Modified by: costasmanousakis-(Designer)-(9/26/11 10:35:25)
	Mods_2011_09
	//  `Do not create an [Owner] record when ◊Transfer = -1  (No transfer)
	//  `Allows user who created the record to be able to download it as himself from
	//  `his copy of the database
End if 
C_TEXT:C284($1; $RecType_txt)
$RecType_txt:=$1
C_TEXT:C284($cLocal; $cParent; $2; $3)  // Command Replaced was o_C_STRING length was 20
$cLocal:=$2
$cParent:=$3

CREATE RECORD:C68([Activity Log:59])
Inc_Sequence("Activity Log"; ->[Activity Log:59]RefID:28)  //Get the next sequence

If (<>Transfer=-1)
	//CREATE RECORD([Owners of Data])
	//[Owners of Data]RefID:=[Activity Log]RefID
	//[Owners of Data]Owner Name:=◊CurrentUser_Name
	//SAVE RECORD([Owners of Data])
	//UNLOAD RECORD([Owners of Data])
End if 

[Activity Log:59]Destination:1:=<>Destination
[Activity Log:59]Source:2:=<>Source
[Activity Log:59]Transfer:12:=<>Transfer
[Activity Log:59]Forward:13:=vsForward
If (<>Transfer<0)
	[Activity Log:59]Status:9:=-1  //Set to no transfer
Else 
	[Activity Log:59]Status:9:=0  //Nothing has been sent yet
End if 
[Activity Log:59]Activity Type:3:=$RecType_txt
[Activity Log:59]User Name:4:=<>CurrentUser_Name
[Activity Log:59]dDate:5:=Current date:C33(*)
[Activity Log:59]tTime:6:=Current time:C178(*)
[Activity Log:59]File Number:7:=ActFileNo
If ($RecType_txt#"GRP")
	[Activity Log:59]Field Number:8:=ActFldNo
	[Activity Log:59]ActField Name:20:=ActFldName
	[Activity Log:59]Data Type:11:=ActDataTyp
	
End if 

[Activity Log:59]RefIDType:26:=ActRefIDTyp
[Activity Log:59]FileID Parent:22:=ActFileIDP
[Activity Log:59]FieldID Parent:23:=ActFieldIDP
[Activity Log:59]Type Parent:17:=ActTypPar
[Activity Log:59]FileID Local:24:=ActFileIDL
[Activity Log:59]FieldID Local:25:=ActFieldIDL
[Activity Log:59]Local Type:18:=ActTypLocal
[Activity Log:59]Local ID:15:=$cLocal
[Activity Log:59]Parent ID:14:=$cParent
[Activity Log:59]Dest ID local:19:=""
[Activity Log:59]Dest ID parent:16:=""
[Activity Log:59]Data:10:=ActData
[Activity Log:59]Old Data:27:=ActOldData

SAVE RECORD:C53([Activity Log:59])
UNLOAD RECORD:C212([Activity Log:59])