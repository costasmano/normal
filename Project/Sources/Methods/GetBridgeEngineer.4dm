//%attributes = {"invisible":true}
//GetBridgeEngineer 
//Fill variables vBridgeEngineer vBEname vBEinitial;vBEActing vBEphone_txt;vBEEmail_txt;vBE_FILastName_txt

If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(3/29/2007 16:12:15)
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 09:02:28)
	Mods_2012_03
	//  `use method GRP_GetGroupMembInfo
	//  `added phone and email variables
	// Modified by: Costas Manousakis-(Designer)-(1/12/17 09:34:48)
	Mods_2017_01
	//  `added vBE_FILastName_txt
End if 

C_TEXT:C284(vBridgeEngineer)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBEname; $vBEsuffix; vBEinitial; vBEActing)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBEphone_txt; vBEEmail_txt; vBE_FILastName_txt)
C_TEXT:C284($Dummy_txt)
vBEname:="Alexander K. Bardow"
$vBEsuffix:=", P.E."
vBEinitial:="AKB"
vBEActing:=""
vBE_FILastName_txt:=""
//` Job Code = 8 = Bridge Engineer
QUERY:C277([Personnel:42]; [Personnel:42]Division No:7="0440"; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Job Code:8=8)

FIRST RECORD:C50([Personnel:42])
If (Records in selection:C76([Personnel:42])>0)
	If ([Personnel:42]Middle Name:4="")
		vBEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		vBEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	Else 
		vBEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
		vBEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	End if 
	$vBEsuffix:=[Personnel:42]Suffix:6
End if 

C_LONGINT:C283($PersonID_L)
$PersonID_L:=GRP_GetGroupMembInfo("BridgeEngineer"; ->vBEname; ->vBEinitial; ->$vBEsuffix; ->vBEphone_txt; ->vBEEmail_txt; ->vBEActing; ->$Dummy_txt; ->vBE_FILastName_txt)
vBridgeEngineer:=vBEname+$vBEsuffix