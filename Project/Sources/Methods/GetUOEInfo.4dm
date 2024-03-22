//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/08/08, 22:16:52
	// ----------------------------------------------------
	// Method: GetUOEInfo
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(10/22/10 09:33:47)
	Mods_2010_10
	//  `Changed 'Dive Division' to 0449
	// Modified by: costasmanousakis-(Designer)-(9/27/11 09:08:28)
	Mods_2011_09
	//  `Use GRP_GetGroupMembInfo to determine the DBIE info
	
End if 
C_TEXT:C284(vUOEinitial)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(vUOEphone; vUOEsuffix)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vUOEname)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vUOEEmail; vUOEActing)

vUOEname:=""
vUOEinitial:=""
vUOEsuffix:=""
//` Job Code = 1 refers to District Bridge Inspection Engineer
QUERY:C277([Personnel:42]; [Personnel:42]Division No:7="0449"; *)  //Dive division
QUERY:C277([Personnel:42];  & ; [Personnel:42]Job Code:8=1; *)
QUERY:C277([Personnel:42];  & ; [Personnel:42]Active:11=True:C214)

FIRST RECORD:C50([Personnel:42])
If (Records in selection:C76([Personnel:42])>0)
	If ([Personnel:42]Middle Name:4="")
		vUOEname:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		vUOEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		vUOEsuffix:=[Personnel:42]Suffix:6
	Else 
		vUOEname:=[Personnel:42]First Name:3+" "+Replace string:C233([Personnel:42]Middle Name:4; " "; "")+" "+[Personnel:42]Last Name:5
		vUOEinitial:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
		vUOEsuffix:=[Personnel:42]Suffix:6
	End if 
End if 
C_LONGINT:C283($PersID_L)
$PersID_L:=GRP_GetGroupMembInfo("UWInspEngineer"; ->vUOEname; ->vUOEinitial; ->vUOEsuffix; ->vUOEphone; ->vUOEEmail; ->vUOEActing)