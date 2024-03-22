//%attributes = {"invisible":true}
If (False:C215)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(5/25/2005 09:42:51)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(3/20/2006 14:19:35)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(10/18/11 17:18:10)
	Mods_2011_10
	//  `Use new method CRTG_LetterInfo
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-04-20 18:01:01)
	Mods_2022_04
	//  `make [Templates] Read only
End if 

C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vContactName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vCompanyName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($mypath; vAssignmentList)
C_DATE:C307(vToday)
C_LONGINT:C283($i; vAssignNo)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_BOOLEAN:C305($bCreateLetter)

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
	If (Not:C34($bCreateLetter))
		ALERT:C41("You must select at least one Bridge Rating!")
	End if 
	
End if 

If ($bCreateLetter=True:C214)
	
	COPY NAMED SELECTION:C331([Conslt Rating:63]; "PrePrintBrgList")
	//USE SET("UserSet")
	
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WPtemplate_CsltRating_ReqFee")
	If (Records in selection:C76([Templates:86])=0)
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
		Else 
			vPlural:=""
		End if 
		
		
		FIRST RECORD:C50([Conslt Rating:63])
		vContractNo:=[Conslt Rating:63]ContractNoRat:14
		vAssignNo:=[Conslt Rating:63]AssignNoRat:12
		vCompanyName:=[Conslt Rating:63]AssignRatCons:5
		
		GetConsltAddress(vCompanyName; "RATING")
		
		ARRAY TEXT:C222(asDistrict; $Recs)  //Command Replaced was o_ARRAY string length was 5
		
		For ($i; 1; $Recs)
			RELATE ONE:C42([Conslt Rating:63]BIN:1)
			asDistrict{$i}:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			vAssignmentList:=vAssignmentList+"    "+Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)+<>sTab+[Bridge MHD NBIS:1]Town Name:175+<>sTab
			$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$BDept:=Insert string:C231($BDept; "-"; 5)
			vAssignmentList:=vAssignmentList+$BDept+<>sTab+[Conslt Rating:63]BIN:1+<>sCR
			NEXT RECORD:C51([Conslt Rating:63])
		End for 
		
		CRTG_LetterInfo
		
		G_WP_MakeDocument
		
	End if 
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //If ($bCreateLetter=True)