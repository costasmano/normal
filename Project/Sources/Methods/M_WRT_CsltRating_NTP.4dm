//%attributes = {"invisible":true}
If (False:C215)
	Mods_2005_CM02
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(5/25/2005 09:43:45)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(3/22/2006 11:24:11)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/29/2007 16:06:21)
	Mods_2007_CM07
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
C_TEXT:C284(vDirectCostList)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($mypath; vAssignmentList)
C_DATE:C307(vToday; vFeePropReceived)
C_LONGINT:C283($i; vAssignNo)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vDirectSalary; vDirectCostTotal)
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
End if 

If ($bCreateLetter=True:C214)
	
	COPY NAMED SELECTION:C331([Conslt Rating:63]; "PrePrintBrgList")
	//USE SET("UserSet")
	
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WPtemplate_CsltRating_NTP")
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
		Else 
			vPlural:=""
		End if 
		
		FIRST RECORD:C50([Conslt Rating:63])
		vContractNo:=[Conslt Rating:63]ContractNoRat:14
		vAssignNo:=[Conslt Rating:63]AssignNoRat:12
		vCompanyName:=[Conslt Rating:63]AssignRatCons:5
		vFeePropReceived:=[Conslt Rating:63]FeeProposalRecvd:22
		
		GetConsltAddress(vCompanyName; "RATING")
		
		C_REAL:C285($Flagging; $Rigging; $Lifts; $TrafficControl; $Police; $Printing; $Mileage; $Lodging; $Postage; $Meals)
		C_REAL:C285($Barge; $SafetyBoat; $Snooper; $RRflagging; $Misc)
		vDirectSalary:=0
		vDirectCostTotal:=0
		$Flagging:=0
		$Rigging:=0
		$Lifts:=0
		$TrafficControl:=0
		$Police:=0
		$Printing:=0
		$Mileage:=0
		$Lodging:=0
		$Postage:=0
		$Meals:=0
		$Barge:=0
		$SafetyBoat:=0
		$Snooper:=0
		$RRflagging:=0
		$Misc:=0
		
		ARRAY TEXT:C222(asDistrict; $Recs)  //Command Replaced was o_ARRAY string length was 5
		
		For ($i; 1; $Recs)
			RELATE ONE:C42([Conslt Rating:63]BIN:1)
			asDistrict{$i}:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			vAssignmentList:=vAssignmentList+"    "+Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)+<>sTab+[Bridge MHD NBIS:1]Town Name:175+<>sTab
			$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$BDept:=Insert string:C231($BDept; "-"; 5)
			vAssignmentList:=vAssignmentList+$BDept+<>sTab+[Conslt Rating:63]BIN:1
			vAssignmentList:=vAssignmentList+<>sTab+String:C10([Conslt Rating:63]FirstExpctSubmDate:2; Internal date long:K1:5)+<>sCR
			
			RELATE MANY:C262([Conslt Rating:63]ConsltRatingID:42)
			vDirectSalary:=vDirectSalary+[Conslt Rating Cost:74]Neg Salary:3
			vDirectCostTotal:=vDirectCostTotal+[Conslt Rating Cost:74]Neg TotalDirectCost:17
			$Flagging:=$Flagging+[Conslt Rating Cost:74]Neg Flagging:7
			$Rigging:=$Rigging+[Conslt Rating Cost:74]Neg Rigging:8
			$Lifts:=$Lifts+[Conslt Rating Cost:74]Neg Lifts:9
			$TrafficControl:=$TrafficControl+[Conslt Rating Cost:74]Neg TrafficControl:10
			$Police:=$Police+[Conslt Rating Cost:74]Neg Police:11
			$Printing:=$Printing+[Conslt Rating Cost:74]Neg Printing:12
			$Mileage:=$Mileage+[Conslt Rating Cost:74]Neg Mileage:13
			$Lodging:=$Lodging+[Conslt Rating Cost:74]Neg Lodging:14
			$Postage:=$Postage+[Conslt Rating Cost:74]Neg Postage:15
			$Meals:=$Meals+[Conslt Rating Cost:74]Neg Meals:16
			$Barge:=$Barge+[Conslt Rating Cost:74]Neg Barge:42
			$SafetyBoat:=$SafetyBoat+[Conslt Rating Cost:74]Neg SafetyBoat:43
			$Snooper:=$Snooper+[Conslt Rating Cost:74]Neg Snooper:44
			$RRflagging:=$RRflagging+[Conslt Rating Cost:74]Neg RRflagging:45
			$Misc:=$Misc+[Conslt Rating Cost:74]Neg Misc:37
			NEXT RECORD:C51([Conslt Rating:63])
		End for 
		
		vDirectCostList:=""
		If ($Flagging#0)
			vDirectCostList:=vDirectCostList+"Flagging "+String:C10($Flagging; "$###,###,##0.00")+";  "
		End if 
		If ($Rigging#0)
			vDirectCostList:=vDirectCostList+"Rigging "+String:C10($Rigging; "$###,###,##0.00")+";  "
		End if 
		If ($Lifts#0)
			vDirectCostList:=vDirectCostList+"Lifts "+String:C10($Lifts; "$###,###,##0.00")+";  "
		End if 
		If ($TrafficControl#0)
			vDirectCostList:=vDirectCostList+"Traffic Control "+String:C10($TrafficControl; "$###,###,##0.00")+";  "
		End if 
		If ($Police#0)
			vDirectCostList:=vDirectCostList+"Police "+String:C10($Police; "$###,###,##0.00")+";  "
		End if 
		If ($Printing#0)
			vDirectCostList:=vDirectCostList+"Printing "+String:C10($Printing; "$###,###,##0.00")+";  "
		End if 
		If ($Mileage#0)
			vDirectCostList:=vDirectCostList+"Mileage "+String:C10($Mileage; "$###,###,##0.00")+";  "
		End if 
		If ($Lodging#0)
			vDirectCostList:=vDirectCostList+"Lodging "+String:C10($Lodging; "$###,###,##0.00")+";  "
		End if 
		If ($Postage#0)
			vDirectCostList:=vDirectCostList+"Postage "+String:C10($Postage; "$###,###,##0.00")+";  "
		End if 
		If ($Meals#0)
			vDirectCostList:=vDirectCostList+"Meals "+String:C10($Meals; "$###,###,##0.00")+";  "
		End if 
		If ($Barge#0)
			vDirectCostList:=vDirectCostList+"Barge "+String:C10($Barge; "$###,###,##0.00")+";  "
		End if 
		If ($SafetyBoat#0)
			vDirectCostList:=vDirectCostList+"Safety Boat "+String:C10($SafetyBoat; "$###,###,##0.00")+";  "
		End if 
		If ($Snooper#0)
			vDirectCostList:=vDirectCostList+"Snooper "+String:C10($Snooper; "$###,###,##0.00")+";  "
		End if 
		If ($RRflagging#0)
			vDirectCostList:=vDirectCostList+"RR Flagging/Permits "+String:C10($RRflagging; "$###,###,##0.00")+";  "
		End if 
		If ($Misc#0)
			vDirectCostList:=vDirectCostList+"Miscellaneous "+String:C10($Misc; "$###,###,##0.00")+";  "
		End if 
		
		vDirectCostList:=Substring:C12(vDirectCostList; 1; Length:C16(vDirectCostList)-3)  //remove last semicolon
		
		CRTG_LetterInfo
		
		G_WP_MakeDocument
		
	End if 
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //matches If ($bCreateLetter=True)