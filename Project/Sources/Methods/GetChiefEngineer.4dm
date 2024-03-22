//%attributes = {"invisible":true}
If (False:C215)
	//Method GetChiefEngineer 
	
	// Modified by: costasmanousakis-(Designer)-(3/20/2007 08:28:27)
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(3/16/12 09:11:53)
	Mods_2012_03
	//  `use method GRP_GetGroupMembInfo
	//  `added phone and email variables
End if 

C_TEXT:C284(vChiefEngineer)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vCEname; vCEsuffix; vCEinitial; vCEActing)  // Command Replaced was o_C_STRING length was 70
C_TEXT:C284(vCEphone_txt; vCEEmail_txt)

vCEname:="XXX XXX"
vCEsuffix:=", P.E."
vCEinitial:="XXX"
vCEActing:=""
//` Job Code = 10 = Chief Engineer
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=11)

FIRST RECORD:C50([Personnel:42])
If (Records in selection:C76([Personnel:42])>0)
	If ([Personnel:42]Middle Name:4="")
		vCEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		vCEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		vCEsuffix:=[Personnel:42]Suffix:6
	Else 
		vCEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+""+[Personnel:42]Last Name:5
		vCEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		vCEsuffix:=[Personnel:42]Suffix:6
	End if 
End if 

C_LONGINT:C283($PersonID_L)
$PersonID_L:=GRP_GetGroupMembInfo("ChiefEngineer"; ->vCEname; ->vCEinitial; ->vCEsuffix; ->vCEphone_txt; ->vCEEmail_txt; ->vCEActing)
vChiefEngineer:=vCEname+vCEsuffix