//%attributes = {"invisible":true}
If (False:C215)
	// created at 6/19/2007
End if 

C_TEXT:C284(vPresvervationEngineer; vPEPhoneNum)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vPEname; $vPEsuffix; vPEinitial; vPEActing)  // Command Replaced was o_C_STRING length was 100

vPEname:="Hemendra R. Bhatt"
$vPEsuffix:=", P.E."
vPEinitial:="HRB"
vPEActing:=""
//` Job Code = 16 = Presvervation Engineer
QUERY:C277([Personnel:42]; [Personnel:42]Division No:7="0440"; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Job Code:8=16)

FIRST RECORD:C50([Personnel:42])
If (Records in selection:C76([Personnel:42])>0)
	If ([Personnel:42]Middle Name:4="")
		vPEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		vPEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	Else 
		vPEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
		vPEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	End if 
	$vPEsuffix:=[Personnel:42]Suffix:6
	vPEPhoneNum:=[Personnel:42]Phone_s:13
End if 

vPresvervationEngineer:=vPEname