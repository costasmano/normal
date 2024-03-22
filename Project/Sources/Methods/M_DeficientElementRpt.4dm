//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// M_DeficientElementRpt
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:13:29
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	//copy from M_RPC_Report
	//Use the current selection and print a report.
	
	Mods_2004_CM03
	Mods_2004_CM09
	Mods_2004_CM12
	Mods_2005_CJM02  //03/29/05, 16:13:22
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:24:45)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(2/15/08 16:42:46)
	Mods_2008_CM_5402
	//Sort the bridges by BDPET,BIN before printing
	// Modified by: costasmanousakis-(Designer)-(7/8/08 22:52:05)
	Mods_2008_CM_5404  // ("DEFELMTEXPORT")  `Copied to Server on : 08/06/08, 16:52:32
	//  `vItemNo and vElemdecs are calculated in the print detail
	//  `changes to minimize print pages by printing as many bridges in one page.
	//  `Don't sort bridges any more, they will be sorted before we run this method
	// Modified by: costasmanousakis-(Designer)-(12/31/09 10:37:50)
	Mods_2009_12
	//  `Changed header to Massschusetts DOT...
	Mods_2011_06  // CJ Miller`06/14/11, 10:41:12      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(1/17/12 08:35:36)
	Mods_2012_01
	//  ` Reload the starting Bridge Saved selection DefBridgeList ; moved the $PrintSetOK:=OK right after the Print Settings cmd
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 

C_LONGINT:C283($i; $countAssignNo; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vRptHeader; vRptDescr; vRateInfo; vBridgeHeader; vBridgeHeader2; vBridgeHeader3)
C_TEXT:C284(vsElemComments)
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
C_TEXT:C284($type)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($Recs; $PrintInspHdr; $j)
//this will include all the bridges listed in the screen
$Recs:=Records in selection:C76([Bridge MHD NBIS:1])

If ($Recs<1)
	ALERT:C41("Please select at least one bridge to generate this report!")
Else 
	G_PrintOptions
	PRINT SETTINGS:C106
	C_LONGINT:C283($PrintSetOK)
	$PrintSetOK:=OK
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
	SET PRINT OPTION:C733(Spooler document name option:K47:10; ("Bridge List <"+String:C10($Recs)+">"))
	C_LONGINT:C283($val1)
	C_TEXT:C284($val2; $val3)
	GET PRINT OPTION:C734(9; $val1; $val2)
	GET PRINT OPTION:C734(12; $val3)
	C_BOOLEAN:C305($TopOfPage_B)
	C_TEXT:C284($CurrentPrinter_T)
	$CurrentPrinter_T:=Get current printer:C788
	If ($PrintSetOK=1)  //check to see if canceled from Print Settings    
		
		COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "DefBridgeList")
		
		vCurrPage:=0
		vRptHeader:="Massachusetts DOT - Highway Department"+<>sCR+"Bridges with Deficient Elements"
		vRptDate:=Current date:C33(*)
		vRptTime:=Current time:C178(*)
		C_LONGINT:C283(prtHt_HDR0_L; prtHt_HDR1_L; prtHt_HDR2_L; prtHt_Det_L; prtHt_Footer_L; DEFELMTPRINT_MarkerHt_L; $printableHt_L; $PrintedHt_L)
		C_BOOLEAN:C305(DEFELMTPRINT_Test_B; DEFELMTPRINT_GetHT_B; DEFELMTPRINT_EmtCont_b; DEFELMTPRINT_BrgHdr_b)
		C_TEXT:C284(DEFELMTPRINT_Area_txt; vsContText)
		DEFELMTPRINT_Test_B:=True:C214
		DEFELMTPRINT_EmtCont_b:=False:C215
		BREAK LEVEL:C302(3)
		C_LONGINT:C283($htPrinted; $FooterNeeded; $htNeeded_L)
		$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem")
		//BREAK LEVEL(0)
		DEFELMTPRINT_Test_B:=False:C215
		GET PRINTABLE AREA:C703($printableHt_L)
		C_TEXT:C284(ElmCmts_txt)
		
		DEFELMTPRINT_Area_txt:="Header"
		vCurrPage:=vCurrPage+1
		$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header:K43:3)
		vsContText:=""
		$TopOfPage_B:=True:C214
		For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $i)
			//```` Report Header
			vRptPages:=1
			//```` Bridge Level Header
			vBridgeHeader:="BIN: "+[Bridge MHD NBIS:1]BIN:3
			vBridgeHeader:=vBridgeHeader+<>sCR+"BDEPT: "+[Bridge MHD NBIS:1]BDEPT:1
			vBridgeHeader:=vBridgeHeader+<>sCR+"Item 8: "+[Bridge MHD NBIS:1]Item8:206
			vBridgeHeader2:=<>sCR+"Town: "+[Bridge MHD NBIS:1]Town Name:175
			vBridgeHeader2:=vBridgeHeader2+<>sCR+"District: "+[Bridge MHD NBIS:1]Item2:60
			vBridgeHeader3:=<>sCR+"Item 7: "+[Bridge MHD NBIS:1]Item7:65
			vBridgeHeader3:=vBridgeHeader3+<>sCR+"Item 6A: "+[Bridge MHD NBIS:1]Item6A:63
			
			QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			RELATE MANY SELECTION:C340([ElementsSafety:29]InspID:4)
			
			CREATE SET:C116([ElementsSafety:29]; "ElmtsThisInsp")
			INTERSECTION:C121("ElmtsThisInsp"; "TotalElmtsFound"; "ElmtsToPrint")
			USE SET:C118("ElmtsToPrint")
			CLEAR SET:C117("ElmtsToPrint")
			CLEAR SET:C117("ElmtsThisInsp")
			
			ORDER BY:C49([ElementsSafety:29]; [Inspections:27]Insp Date:78; <; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >; [ElementDict:30]Prefix:11; >)
			
			$PrintedHt_L:=Get printed height:C702
			If (Records in selection:C76([ElementsSafety:29])>1)
				$FooterNeeded:=0
			Else 
				$FooterNeeded:=1
			End if 
			If ($i>1)  //check for after the 1st bridge rec
				$htNeeded_L:=prtHt_HDR1_L+prtHt_HDR2_L+prtHt_Det_L+($FooterNeeded*prtHt_Footer_L)
				GOTO SELECTED RECORD:C245([ElementsSafety:29]; 1)
				If ((vIncludeComments) & (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0))
					ElmCmts_txt:=Fn_GetTextBlob([ElementsSafety:29]ElmComments:23)
					DEFELMTPRINT_Area_txt:="Break0"
					DEFELMTPRINT_GetHT_B:=True:C214
					$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form break0:K43:14)
					DEFELMTPRINT_GetHT_B:=False:C215
					$htNeeded_L:=$htNeeded_L+DEFELMTPRINT_MarkerHt_L
				End if 
				If (($PrintedHt_L+$htNeeded_L)>$printableHt_L)
					PAGE BREAK:C6(>)  //Start a new page
					DEFELMTPRINT_Area_txt:="Header"
					vCurrPage:=vCurrPage+1
					$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header:K43:3)
					$TopOfPage_B:=True:C214
				End if 
				
			End if 
			
			DEFELMTPRINT_Area_txt:="Header1"
			$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header1:K43:4)
			DEFELMTPRINT_BrgHdr_b:=True:C214
			$PrintInspHdr:=0
			
			For ($j; 1; Records in selection:C76([ElementsSafety:29]))
				GOTO SELECTED RECORD:C245([ElementsSafety:29]; $j)
				If ($j=Records in selection:C76([ElementsSafety:29]))
					$FooterNeeded:=1
				Else 
					$FooterNeeded:=0
				End if 
				C_TEXT:C284($AllCmts_txt)
				$AllCmts_txt:=Fn_GetTextBlob([ElementsSafety:29]ElmComments:23)
				
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[ElementsSafety:29]InspID:4)
				//load record([inspections])
				If ([Inspections:27]InspID:2#$PrintInspHdr)
					//New Inspection report - print inspection header
					RELATE ONE:C42([Inspections:27]Insp Type:6)
					vsListInspTitle:=[Inspection Type:31]Description:2
					If ((([Inspections:27]Insp Type:6="CUL") | ([Inspections:27]Insp Type:6="RT@")) & ([Inspections:27]InspRtnSpcMemFlag:209))
						vsListInspTitle:=vsListInspTitle+" & Special Member"
					End if 
					If ([Inspections:27]Insp Type:6="DV@")
						vsInc_Insp_I60:=[Inspections:27]Item 60 UW:66
						vsInc_Insp_I61:=[Inspections:27]Item 61 UW:72
						vsInc_Insp_I62:=[Inspections:27]Item 62 UW:165
					Else 
						vsInc_Insp_I60:=[Inspections:27]Item 60:81
						vsInc_Insp_I61:=[Inspections:27]Item 61:82
						vsInc_Insp_I62:=[Inspections:27]Item 62:113
					End if 
					If ($PrintInspHdr#0)
						//Print the footer for the previous insp report
						DEFELMTPRINT_Area_txt:="Footer"
						$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form footer:K43:2)
					End if 
					If (Not:C34($TopOfPage_B))
						$htNeeded_L:=prtHt_HDR2_L+prtHt_Det_L+($FooterNeeded*prtHt_Footer_L)
						If ((vIncludeComments) & (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0))
							ElmCmts_txt:=$AllCmts_txt
							DEFELMTPRINT_Area_txt:="Break0"
							DEFELMTPRINT_GetHT_B:=True:C214
							$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form break0:K43:14)
							DEFELMTPRINT_GetHT_B:=False:C215
							$htNeeded_L:=$htNeeded_L+DEFELMTPRINT_MarkerHt_L
						End if 
						If ((Get printed height:C702+$htNeeded_L)>$printableHt_L)
							PAGE BREAK:C6(>)  //Start a new page
							DEFELMTPRINT_Area_txt:="Header"
							vCurrPage:=vCurrPage+1
							$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header:K43:3)
							DEFELMTPRINT_BrgHdr_b:=False:C215
							$TopOfPage_B:=True:C214
						End if 
					End if 
					DEFELMTPRINT_Area_txt:="Header2"
					$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header2:K43:5)
					$PrintInspHdr:=[Inspections:27]InspID:2
				End if 
				If (Not:C34($TopOfPage_B))
					If ((Get printed height:C702+prtHt_Det_L+($FooterNeeded*prtHt_Footer_L))>$printableHt_L)
						PAGE BREAK:C6(>)  //Start a new page
						DEFELMTPRINT_Area_txt:="Header"
						vCurrPage:=vCurrPage+1
						$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header:K43:3)
						DEFELMTPRINT_Area_txt:="Header2"
						vsContText:="(Continued)"
						$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header2:K43:5)
						vsContText:=""
						DEFELMTPRINT_BrgHdr_b:=False:C215
						$TopOfPage_B:=True:C214
					End if 
					
				End if 
				If ((vIncludeComments) & (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0))
					ElmCmts_txt:=$AllCmts_txt
					DEFELMTPRINT_Area_txt:="Break0"
					DEFELMTPRINT_GetHT_B:=True:C214
					$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form break0:K43:14)
					DEFELMTPRINT_GetHT_B:=False:C215
					If (Not:C34($TopOfPage_B))
						If ((Get printed height:C702+prtHt_Det_L+DEFELMTPRINT_MarkerHt_L+($FooterNeeded*prtHt_Footer_L))>$printableHt_L)
							PAGE BREAK:C6(>)  //Start a new page
							DEFELMTPRINT_Area_txt:="Header"
							vCurrPage:=vCurrPage+1
							$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header:K43:3)
							DEFELMTPRINT_Area_txt:="Header2"
							vsContText:="(Continued)"
							$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header2:K43:5)
							vsContText:=""
							DEFELMTPRINT_BrgHdr_b:=False:C215
							$TopOfPage_B:=True:C214
						End if 
						
					End if 
					DEFELMTPRINT_Area_txt:="detail"
					$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form detail:K43:1)
					DEFELMTPRINT_Area_txt:="Break0"
					ElmCmts_txt:=$AllCmts_txt
					$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form break0:K43:14)
					C_LONGINT:C283(DEFELMTPRINT_LastChar_L)
					While (DEFELMTPRINT_LastChar_L>0)
						DEFELMTPRINT_EmtCont_b:=True:C214
						$AllCmts_txt:=Substring:C12($AllCmts_txt; (DEFELMTPRINT_LastChar_L+1))
						ElmCmts_txt:=$AllCmts_txt
						PAGE BREAK:C6(>)  //Start a new page
						DEFELMTPRINT_BrgHdr_b:=False:C215
						DEFELMTPRINT_Area_txt:="Header"
						vCurrPage:=vCurrPage+1
						$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header:K43:3)
						DEFELMTPRINT_Area_txt:="Header2"
						vsContText:="(Continued)"
						$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form header2:K43:5)
						vsContText:=""
						$TopOfPage_B:=True:C214
						DEFELMTPRINT_Area_txt:="detail"
						$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form detail:K43:1)
						DEFELMTPRINT_Area_txt:="Break0"
						$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form break0:K43:14)
					End while 
					$AllCmts_txt:=""
					DEFELMTPRINT_EmtCont_b:=False:C215
					$TopOfPage_B:=False:C215
				Else 
					DEFELMTPRINT_Area_txt:="detail"
					$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form detail:K43:1)
					$TopOfPage_B:=False:C215
				End if 
				
			End for 
			DEFELMTPRINT_Area_txt:="Footer"
			$htPrinted:=Print form:C5([ElementsSafety:29]; "Rpt DefElem"; Form footer:K43:2)
			
			If (False:C215)
				//  //Not in use as of 8/6/08 - Mods_2008_CM_5404
				//If (vIncludeComments)
				//C_LONGINT($vlCmtPgs)
				//vPageNo:=vCurrPage
				//$vlCmtPgs:=Print_DefElement_Cmts 
				//vCurrPage:=vPageNo
				//End if 
				
			End if 
			USE NAMED SELECTION:C332("DefBridgeList")
			If ($i=Records in selection:C76([Bridge MHD NBIS:1]))
				PAGE BREAK:C6
			Else 
				//PAGE BREAK(>)
			End if 
		End for 
		USE NAMED SELECTION:C332("DefBridgeList")
		CLEAR NAMED SELECTION:C333("DefBridgeList")
	End if 
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
	
End if 