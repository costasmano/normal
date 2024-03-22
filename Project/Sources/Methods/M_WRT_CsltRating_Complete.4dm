//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/06/05, 13:59:06
	// ----------------------------------------------------
	// Method: M_WRT_CsltRating_Complete
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(3/8/2006 15:45:50)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(5/6/09 09:30:30)
	Mods_2009_05
	//  `Added the Score as part of the assignment list print.
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vContactName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vCompanyName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vDirectCostList)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($mypath; vAssignmentList)
C_DATE:C307(vToday; vFeePropReceived)
C_LONGINT:C283($i; vAssignNo)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vDirectSalary; vDirectCostTotal)
C_LONGINT:C283($Recs)
C_BOOLEAN:C305($bCreateLetter)
C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vPlural_have; vPlural_is)  // Command Replaced was o_C_STRING length was 5

//for multiple bridges
//$Recs:=Records in set("UserSet")
$Recs:=Records in selection:C76([Conslt Rating:63])

If ($Recs>20)
	CONFIRM:C162("Are you sure you want to include all the selected bridges in the letter?"; "Yes"; "No")
	If (Ok=1)
		$bCreateLetter:=True:C214
	Else 
		$bCreateLetter:=False:C215
	End if 
Else 
	$bCreateLetter:=($Recs>0)
End if 

If ($bCreateLetter=True:C214)
	
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WPTemplate_CsltRtg_Complete")
	If (Records in selection:C76([Templates:86])=0)
		//  If ($mypath="")      
		ALERT:C41("Document template does not exist!")
		
	Else 
		
		vContactName:="Contact_Name"
		vLastName:="Last_Name"
		vCompanyName:="Company_Name"
		vAddress1:="Address_Line_1"
		vAddress2:="Address_Line_2"
		vToday:=Current date:C33(*)
		vAssignmentList:=""
		
		If ($Recs>1)
			vPlural:="s"
			vPlural_have:="have"
			vPlural_is:="are"
		Else 
			vPlural:=""
			vPlural_have:="has"
			vPlural_is:="is"
		End if 
		
		FIRST RECORD:C50([Conslt Rating:63])
		vContractNo:=[Conslt Rating:63]ContractNoRat:14
		vAssignNo:=[Conslt Rating:63]AssignNoRat:12
		vCompanyName:=[Conslt Rating:63]AssignRatCons:5
		vFeePropReceived:=[Conslt Rating:63]FeeProposalRecvd:22
		
		GetConsltAddress(vCompanyName; "RATING")
		
		ARRAY TEXT:C222(asDistrict; $Recs)  //Command Replaced was o_ARRAY string length was 5
		READ ONLY:C145([Conslt Rating:63])
		For ($i; 1; $Recs)
			GOTO SELECTED RECORD:C245([Conslt Rating:63]; $i)
			LOAD RECORD:C52([Conslt Rating:63])
			RELATE ONE:C42([Conslt Rating:63]BIN:1)
			asDistrict{$i}:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$BDept:=Insert string:C231($BDept; "-"; 5)
			vAssignmentList:=vAssignmentList+[Bridge MHD NBIS:1]Town Name:175+<>sTab
			vAssignmentList:=vAssignmentList+$BDept+<>sTab+[Conslt Rating:63]BIN:1
			vAssignmentList:=vAssignmentList+<>sTab+asDistrict{$i}
			vAssignmentList:=vAssignmentList+<>sTab+[Conslt Rating:63]ContractNoRat:14
			vAssignmentList:=vAssignmentList+<>sTab+String:C10([Conslt Rating:63]AssignNoRat:12)
			vAssignmentList:=vAssignmentList+<>sTab+String:C10([Conslt Rating:63]ConsltScore:15)
			vAssignmentList:=vAssignmentList+<>sCR
			
		End for 
		
		READ WRITE:C146([Conslt Rating:63])
		GetInspContact
		C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
		GetBIEinfo
		GetDBIEccInfo(->asDistrict)
		//GetAreaBIEinfo (asDistrict{1})
		GetBridgeEngineer
		vWriterInitial:=vBIEInitial+"/"+Lowercase:C14(vBIEInitial)
		
		//````4D WR commands
		G_WP_MakeDocument
		
	End if 
	
End if   //matches If ($bCreateLetter=True)