//%attributes = {"invisible":true}
// Method: M_WRT_CsltInsp_ReqFee
// Description
// create a letter to request a fee proposal for inspection
// Fills variables used in the 4D Write template
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(5/25/2005 09:43:36)
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(3/20/2006 10:48:03)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 12:47:36)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(10/18/11 17:18:10)
	Mods_2011_10
	//  `Use new method CRTG_LetterInfo
	// Modified by: Costas Manousakis-(Designer)-(12/15/15 14:02:12)
	Mods_2015_12_bug
	//  `for variable vEndOfInspMonth consider case when the month might be during the next year
	// Modified by: Costas Manousakis-(Designer)-(3/17/20 14:48:01)
	Mods_2020_03_bug
	//  `added more checks in the list of cons inspections, 
	//  //there must be records listed 
	//  //Contract and assignment must be the same
	//  //BIN records must be all either NBI or Non-NBI
	//  //contract number must exist in the [contracts] table
	//  //start use of system JSON parameter "CSINSP_LetterInfo" to get variables depending on if the list of inspections
	//  //is for NBI bridges or non-nbi  
	// Modified by: Costas Manousakis-(Designer)-(6/8/20 12:37:00)
	Mods_2020_06
	//  `use method CSLTINSP_ProcceedWithLetter to do the checks for consistancy in the listed records
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vPlural)  // **Replaced old C_STRING length 1
C_TEXT:C284(vContractNo)  // **Replaced old C_STRING length 5
C_TEXT:C284(vInspMonth)  // **Replaced old C_STRING length 15
C_TEXT:C284(vContactName; vCompanyName; vAddress1; vAddress2)  // **Replaced old C_STRING length 100
C_TEXT:C284(vLastName)  // **Replaced old C_STRING length 50
C_TEXT:C284($mypath; vAssignmentList)
C_TEXT:C284(vLoadRtgInfoNote_txt; WR_LetterTitle; WR_InspectionDeadline)
C_DATE:C307(vToday; vEndOfInspMonth)
C_LONGINT:C283($iMonth; vAssignNo)  // **Replaced old C_INTEGER()
C_LONGINT:C283($Recs)
C_BOOLEAN:C305($bCreateLetter; $NBIRecs_b)

C_OBJECT:C1216($results_o)
$results_o:=CSLTINSP_ProceedWithLetter

$Recs:=OB Get:C1224($results_o; "records"; Is longint:K8:6)
$bCreateLetter:=OB Get:C1224($results_o; "createLtr"; Is boolean:K8:9)
$NBIRecs_b:=OB Get:C1224($results_o; "NBIRecs"; Is boolean:K8:9)

If ($bCreateLetter=True:C214)
	
	COPY NAMED SELECTION:C331([Cons Inspection:64]; "PrePrintBrgList")
	//USE SET("UserSet")
	READ ONLY:C145([Templates:86])
	
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WPtemplate_CsltInsp_ReqFee")
	
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
		
		If ($NBIRecs_b)
			WR_LetterTitle:=ut_GetSysParamAttribute("CSINSP_LetterInfo"; "nbititle"; \
				"Statewide Bridge Inspection")
			WR_InspectionDeadline:=ut_GetSysParamAttribute("CSINSP_LetterInfo"; "nbideadline"; \
				"21 working days")
			
		Else 
			WR_LetterTitle:=ut_GetSysParamAttribute("CSINSP_LetterInfo"; "nonnbititle"; \
				"Statewide Inspection of Non-NBI Structures")
			WR_InspectionDeadline:=ut_GetSysParamAttribute("CSINSP_LetterInfo"; "nonnbideadline"; \
				"21 working days")
		End if 
		
		FIRST RECORD:C50([Cons Inspection:64])
		vContractNo:=[Cons Inspection:64]ConContractNo:7
		vAssignNo:=[Cons Inspection:64]AssignConNumber:6
		vCompanyName:=[Cons Inspection:64]AssignConName:5
		
		GetConsltAddress(vCompanyName; "INSPECTION")
		
		C_BOOLEAN:C305(LoadRatgInfoReq_b)
		$iMonth:=CINSP_LoadAssgnList(False:C215)
		If ($iMonth#0)
			
			If ($iMonth<Month of:C24(Current date:C33(*)))
				//month is before the current month - therefore it is for next year.
				vEndOfInspMonth:=Date:C102(String:C10($iMonth)+"/1/ "+String:C10(1+Year of:C25(Current date:C33(*))))
			Else 
				//same year as current year
				vEndOfInspMonth:=Date:C102(String:C10($iMonth)+"/1/ "+String:C10(Year of:C25(Current date:C33(*))))
			End if 
			
			vEndOfInspMonth:=Add to date:C393(vEndOfInspMonth; 0; 1; -1)
			vInspMonth:=aMonths{$iMonth}  //use process variable array aMonths to get month names
		Else 
			vInspMonth:="ENTER_MONTH"
			vEndOfInspMonth:=!00-00-00!
		End if 
		
		CRTG_LetterInfo
		
		If (LoadRatgInfoReq_b)
			CINSP_Load_LRI_Note
		End if 
		
		G_WP_MakeDocument
		
		LoadRatgInfoReq_b:=False:C215
		vLoadRtgInfoNote_txt:=""
		vAssignmentList:=""
	End if 
	READ WRITE:C146([Templates:86])
	
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //matches If ($bCreateLetter=True)