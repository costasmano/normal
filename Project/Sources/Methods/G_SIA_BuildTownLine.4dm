//%attributes = {"invisible":true}
If (False:C215)
	//  G_SIA_BuildTownLine 
	//Purpose:
	//Build the sBDEPT and sTown variables for use in SIA print forms.
	
	Mods_2005_CM05
	
End if 

C_TEXT:C284(sBDEPT; sTown)  // Command Replaced was o_C_STRING length was 80
ARRAY TEXT:C222(aBDEPT_; 0)  //Command Replaced was o_ARRAY string length was 10
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2; >)
SELECTION TO ARRAY:C260([TownLineInfo:73]BDEPT:2; aBDEPT_)
sBDEPT:=[Bridge MHD NBIS:1]BDEPT:1
sTown:=[Bridge MHD NBIS:1]Town Name:175
For ($i; 1; Size of array:C274(aBDEPT_))
	sBDEPT:=sBDEPT+"="+aBDEPT_{$i}
	sTown:=sTown+"="+Get_Town_Name(aBDEPT_{$i})
End for 
