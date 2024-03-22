//%attributes = {"invisible":true}
//GP LOAD_aInsp
//Copyright © 1995-1996, Thomas D. Nee, All Rights Reserved.

C_BOOLEAN:C305(vLaInsp)
C_LONGINT:C283($NoInsp; $i)

ALL RECORDS:C47([Personnel:42])
ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; [Personnel:42]First Name:3; [Personnel:42]Middle Name:4; [Personnel:42]Suffix:6)

$NoInsp:=Records in selection:C76([Personnel:42])
ARRAY TEXT:C222(aInsp; $NoInsp)  //Command Replaced was o_ARRAY string length was 88
ARRAY LONGINT:C221(aInspID; $NoInsp)
For ($i; 1; $NoInsp)
	aInsp{$i}:=FullName([Personnel:42]First Name:3; [Personnel:42]Middle Name:4; [Personnel:42]Last Name:5; [Personnel:42]Suffix:6)
	aInspID{$i}:=[Personnel:42]Person ID:1
	NEXT RECORD:C51([Personnel:42])
End for 

//aInsp has been loaded.
//It is not necessary to load it again until there is a change in [Personnel].
vLaInsp:=False:C215