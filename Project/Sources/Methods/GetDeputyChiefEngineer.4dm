//%attributes = {"invisible":true}
If (False:C215)
	//method : GetDeputyChiefEngineer 
	// Modified by: costasmanousakis-(Designer)-(3/20/2007 08:36:32)
	Mods_2007_CM07
End if 

C_TEXT:C284(vDeputyChiefEngineer)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vCEname; vCEsuffix; vCEinitial; vCEActing)  // Command Replaced was o_C_STRING length was 70

vCEname:="John Blundo"
vCEsuffix:=", P.E."
vCEinitial:="JB"

//` Job Code = 10 = Depty Chief Engineer
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=10)

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
GetChiefEngineer
vDeputyChiefEngineer:=vCEname+vCEsuffix