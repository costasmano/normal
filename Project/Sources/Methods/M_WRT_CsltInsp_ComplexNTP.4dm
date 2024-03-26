//%attributes = {"invisible":true}
If (False:C215)
	//M_WRT_CsltInsp_ComplexNTP
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(5/25/2005 09:43:05)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(3/8/2006 16:56:49)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/29/2007 16:31:06)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(10/18/11 17:18:10)
	Mods_2011_10
	//  `Use new method CRTG_LetterInfo
	// Modified by: Costas Manousakis-(Designer)-(6/5/20 10:51:17)
	Mods_2020_06
	//  `use the menu item parameter for the template name - method can be used for multiple contract types - CallReference #698
	//  `also check for multiple contracts and assignments on list using CSLTINSP_ProceedWithLetter
	// Modified by: Costas Manousakis-(Designer)-(2022-04-20 18:01:01)
	Mods_2022_04
	//  `make [Templates] Read only
	// Modified by: Costas Manousakis-(Designer)-(2024-03-21 18:59:16)
	Mods_2024_03_bug
	//  `moved getting the Get selected menu item parameter before the call to CSLTINSP_ProceedWithLetter
	//  `confirm dialogs would 'loose' the parameter
	
End if 
C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vContactName; vCompanyName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vDirectCostList)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($mypath; vAssignmentList)
C_DATE:C307(vToday; vFeePropReceived)
C_LONGINT:C283($i; vAssignNo)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vDirectSalary; vDirectCostTotal)
C_LONGINT:C283($Recs)
C_BOOLEAN:C305($bCreateLetter)
C_TEXT:C284(vVerbalAuthSentence)  // Command Replaced was o_C_STRING length was 100

//start of Mods_2024_03_bug
C_TEXT:C284($template)
$template:=Get selected menu item parameter:C1005
//start of Mods_2024_03_bug

C_OBJECT:C1216($results_o)
$results_o:=CSLTINSP_ProceedWithLetter

$Recs:=OB Get:C1224($results_o; "records"; Is longint:K8:6)
$bCreateLetter:=OB Get:C1224($results_o; "createLtr"; Is boolean:K8:9)

If ($bCreateLetter=True:C214)
	
	COPY NAMED SELECTION:C331([Cons Inspection:64]; "PrePrintBrgList")
	//USE SET("UserSet") 
	$template:=WP_4WRTemplNameToWP($template)
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$template)
	If (Records in selection:C76([Templates:86])=0)
		
		ALERT:C41("Document template for the Notice To Proceed Letter does not exist!")
		
	Else 
		SHORT_MESSAGE("Gathering info...")
		vContactName:="Contact_Name"
		vLastName:="Last_Name"
		vCompanyName:="Company_Name"
		vAddress1:="Address_Line_1"
		vAddress2:="Address_Line_2"
		vToday:=Current date:C33(*)
		vVerbalAuthSentence:=""
		vAssignmentList:=""
		
		If ($Recs>1)
			vPlural:="s"
		Else 
			vPlural:=""
		End if 
		
		FIRST RECORD:C50([Cons Inspection:64])
		vContractNo:=[Cons Inspection:64]ConContractNo:7
		vAssignNo:=[Cons Inspection:64]AssignConNumber:6
		vCompanyName:=[Cons Inspection:64]AssignConName:5
		
		GetConsltAddress(vCompanyName; "INSPECTION")
		
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
		C_LONGINT:C283($iMonth)  //Command Replaced was o_C_INTEGER
		C_TEXT:C284($sYear)  // Command Replaced was o_C_STRING length was 4
		C_TEXT:C284($sMonth; $sInspMonth)  // Command Replaced was o_C_STRING length was 15
		C_TEXT:C284($sInspType)  // Command Replaced was o_C_STRING length was 80
		
		For ($i; 1; $Recs)
			RELATE ONE:C42([Cons Inspection:64]BIN:1)
			asDistrict{$i}:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			vAssignmentList:=vAssignmentList+[Bridge MHD NBIS:1]Town Name:175+<>sTab
			
			$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$BDept:=Insert string:C231($BDept; "-"; 5)
			$iMonth:=Int:C8(Month of:C24([Cons Inspection:64]InspMonth:34))
			$sYear:=String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
			$sMonth:=aMonths{$iMonth}
			$sInspMonth:=Substring:C12($sMonth; 1; 3)+"-"+Substring:C12($sYear; 3; 4)
			$sInspType:=[Cons Inspection:64]InspType:33
			If (Length:C16($sInspType)>35)
				$sInspType:=Replace string:C233($sInspType; "Fracture Critical"; "FC")
				$sInspType:=Replace string:C233($sInspType; "Special Member"; "SM")
				$sInspType:=Replace string:C233($sInspType; "Mechanical"; "Mech.")
				$sInspType:=Replace string:C233($sInspType; "Electrical"; "Elect.")
			End if 
			vAssignmentList:=vAssignmentList+$BDept+<>sTab+[Cons Inspection:64]BIN:1+<>sTab+$sInspType+<>sTab+$sInspMonth+<>sCR
			
			If ([Cons Inspection:64]NTPdate_verbal:35#!00-00-00!)
				vVerbalAuthSentence:="Please note that verbal authorization for this work was given on "+String:C10([Cons Inspection:64]NTPdate_verbal:35; Internal date short:K1:7)+"."
			End if 
			
			RELATE MANY:C262([Cons Inspection:64]ConsInspectionID:32)
			vDirectSalary:=vDirectSalary+[Cons Inspection Cost:76]Neg Salary:3
			vDirectCostTotal:=vDirectCostTotal+[Cons Inspection Cost:76]Neg TotalDirectCost:18
			$Flagging:=$Flagging+[Cons Inspection Cost:76]Neg Flagging:7
			$Rigging:=$Rigging+[Cons Inspection Cost:76]Neg Rigging:8
			$Lifts:=$Lifts+[Cons Inspection Cost:76]Neg Lifts:9
			$TrafficControl:=$TrafficControl+[Cons Inspection Cost:76]Neg TrafficControl:10
			$Police:=$Police+[Cons Inspection Cost:76]Neg Police:11
			$Printing:=$Printing+[Cons Inspection Cost:76]Neg Printing:12
			$Mileage:=$Mileage+[Cons Inspection Cost:76]Neg Mileage:13
			$Lodging:=$Lodging+[Cons Inspection Cost:76]Neg Lodging:14
			$Postage:=$Postage+[Cons Inspection Cost:76]Neg Postage:15
			$Meals:=$Meals+[Cons Inspection Cost:76]Neg Meals:16
			$Barge:=$Barge+[Cons Inspection Cost:76]Neg Barge:41
			$SafetyBoat:=$SafetyBoat+[Cons Inspection Cost:76]Neg SafetyBoat:42
			$Snooper:=$Snooper+[Cons Inspection Cost:76]Neg Snooper:43
			$RRflagging:=$RRflagging+[Cons Inspection Cost:76]Neg RRflagging:44
			$Misc:=$Misc+[Cons Inspection Cost:76]Neg Misc:17
			NEXT RECORD:C51([Cons Inspection:64])
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
		
		MESSAGE:C88(Char:C90(Carriage return:K15:38)+"Preparing document...")
		
		G_WP_MakeDocument
		
		CLOSE WINDOW:C154
	End if 
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //matches If ($bCreateLetter=True)