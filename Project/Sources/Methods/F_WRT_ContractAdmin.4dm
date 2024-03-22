//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/06, 15:43:09
	// ----------------------------------------------------
	// Method: F_WRT_ContractAdmin
	// Description
	// Return the Contract aDmin Name
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMz1
	// Modified by: costasmanousakis-(Designer)-(9/17/2007 09:50:19)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/15/08 16:58:42)
	Mods_2008_CM_5404
	//Fix change in PERS_ACTING modeling 
	// Modified by: Costas Manousakis-(Designer)-(5/7/18 10:24:35)
	Mods_2018_05
	//  `make use of new field [PERS_Groups]PERS_ActingTitle
End if 
C_TEXT:C284($0; $AdminName_txt)
C_TEXT:C284(vContrAdmActing)
vContrAdmActing:=""
$AdminName_txt:="Robert Willoth"
C_BOOLEAN:C305($PersGrRW_b; $PersGRMRW_b; $PersRW_b)
$PersGrRW_b:=Not:C34(Read only state:C362([PERS_Groups:109]))
$PersGRMRW_b:=Not:C34(Read only state:C362([PERS_GroupMembers:110]))
$PersRW_b:=Not:C34(Read only state:C362([Personnel:42]))

If ($PersGrRW_b)
	READ ONLY:C145([PERS_Groups:109])
End if 
If ($PersGRMRW_b)
	READ ONLY:C145([PERS_GroupMembers:110])
End if 
If ($PersRW_b)
	READ ONLY:C145([Personnel:42])
End if 
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="ConsultContractAdmin")
If (Records in selection:C76([PERS_Groups:109])=1)
	QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=[PERS_Groups:109]PERS_GroupID_I:1)
	If (Records in selection:C76([PERS_GroupMembers:110])>0)
		QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=[PERS_GroupMembers:110]PersonID_I:2)
		If (Records in selection:C76([Personnel:42])=1)
			If ([Personnel:42]Middle Name:4="")
				$AdminName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
			Else 
				$AdminName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
			End if 
			If ([PERS_Groups:109]PERS_Acting:3=[Personnel:42]Person ID:1)
				
				If ([PERS_Groups:109]PERS_ActingTitle:6#"")
					vContrAdmActing:=[PERS_Groups:109]PERS_ActingTitle:6+" "
				Else 
					vContrAdmActing:="Acting "
				End if 
				
			End if 
		End if 
	End if 
	
End if 
If ($PersGrRW_b)
	READ WRITE:C146([PERS_Groups:109])
End if 
If ($PersGRMRW_b)
	READ WRITE:C146([PERS_GroupMembers:110])
End if 
If ($PersRW_b)
	READ WRITE:C146([Personnel:42])
End if 

$0:=$AdminName_txt