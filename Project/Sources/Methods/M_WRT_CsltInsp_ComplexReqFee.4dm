//%attributes = {"invisible":true}
//M_WRT_CsltInsp_ComplexReqFee
If (False:C215)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(5/25/2005 09:43:20)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(6/28/06 17:34:57)
	Mods_2006_CM05
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 12:35:56)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(10/18/11 17:18:10)
	Mods_2011_10
	//  `Use new method CRTG_LetterInfo
	// Modified by: Costas Manousakis-(Designer)-(6/5/20 10:51:17)
	Mods_2020_06
	//  `use the menu item parameter for the template name - method can be used for multiple contract types - CallReference #698
	//  `also check for multiple contracts and assignments on list using CSLTINSP_ProceedWithLetter
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-04-20 17:57:24)
	Mods_2022_04
	//  `made Templates table Readonly
End if 

C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vCopyPlural; vSIAplural)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vInspMonth)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284(vContactName; vCompanyName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284($mypath; vAssignmentList)
C_TEXT:C284(vLoadRtgInfoNote_txt)
C_DATE:C307(vToday)
C_LONGINT:C283(vAssignNo)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_BOOLEAN:C305($bCreateLetter)

C_OBJECT:C1216($results_o)
$results_o:=CSLTINSP_ProceedWithLetter

$Recs:=OB Get:C1224($results_o; "records"; Is longint:K8:6)
$bCreateLetter:=OB Get:C1224($results_o; "createLtr"; Is boolean:K8:9)

If ($bCreateLetter=True:C214)
	
	COPY NAMED SELECTION:C331([Cons Inspection:64]; "PrePrintBrgList")
	//USE SET("UserSet")
	C_TEXT:C284($template)
	
	$template:=Get selected menu item parameter:C1005
	
	//change to Write Pro template naming 
	Case of 
		: ($template="WRTemp@")
			$template:="WP"+Substring:C12($template; 3)
		: ($template="WRT@")
			$template:="WRP"+Substring:C12($template; 4)
			
	End case 
	
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$template)
	If (Records in selection:C76([Templates:86])=0)
		
		ALERT:C41("Document template for the Request For Fee Proposal Letter does not exist!")
		
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
			vCopyPlural:="are copies"
			vSIAplural:="'s"
		Else 
			vPlural:=""
			vCopyPlural:="is a copy"
			vSIAplural:=""
		End if 
		
		FIRST RECORD:C50([Cons Inspection:64])
		vContractNo:=[Cons Inspection:64]ConContractNo:7
		vAssignNo:=[Cons Inspection:64]AssignConNumber:6
		vCompanyName:=[Cons Inspection:64]AssignConName:5
		
		GetConsltAddress(vCompanyName; "INSPECTION")
		
		C_LONGINT:C283($iMonth)  //Command Replaced was o_C_INTEGER
		C_BOOLEAN:C305(LoadRatgInfoReq_b)
		$iMonth:=CINSP_LoadAssgnList(True:C214)
		
		CRTG_LetterInfo
		
		If (LoadRatgInfoReq_b)
			CINSP_Load_LRI_Note
		End if 
		
		G_WP_MakeDocument
		
		LoadRatgInfoReq_b:=False:C215
		vLoadRtgInfoNote_txt:=""
		vAssignmentList:=""
	End if 
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //matches If ($bCreateLetter=True)