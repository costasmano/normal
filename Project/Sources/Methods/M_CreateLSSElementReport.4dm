//%attributes = {"invisible":true}
//Method: M_CreateLSSElementReport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/27/18, 11:57:35
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12  //add [LSS_ElementInspection] query and report
	//Modified by: Chuck Miller (1/24/19 11:42:45)
End if 
//
C_BLOB:C604($HSBlob_blb; $ITBlob_blb; $SIBlob_blb; $LIBlob_blb)
SET DATABASE PARAMETER:C642(Order by formula on server:K37:46; 2)

C_LONGINT:C283($i; $countAssignNo; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vRptHeader; vRptDescr; vRateInfo; vBridgeHeader; vBridgeHeader2; vBridgeHeader3)
C_TEXT:C284(vsElemComments)
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
C_TEXT:C284($type)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($Recs; $j)
C_TEXT:C284($PrintInspHdr)
//this will include all the bridges listed in the screen
CREATE SET:C116([LSS_ElementInspection:163]; "LSS_ElementReportSet")


ARRAY TEXT:C222($InventoryIDs_atxt; 0)

LSS_SetUpAndSortForElementRpt


For ($i; 1; Records in selection:C76([LSS_ElementInspection:163]))
	GOTO SELECTED RECORD:C245([LSS_ElementInspection:163]; $i)
	QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=[LSS_ElementInspection:163]LSS_InspectionId_s:3)
	If (Find in array:C230($InventoryIDs_atxt; [LSS_Inspection:164]LSS_InventoryId_s:2)>0)
	Else 
		APPEND TO ARRAY:C911($InventoryIDs_atxt; [LSS_Inspection:164]LSS_InventoryId_s:2)
	End if 
End for 

$Recs:=Size of array:C274($InventoryIDs_atxt)

If ($Recs<1)
	ALERT:C41("Please select at least one ancillary structure to generate this report!")
Else 
	If (ut_ReturnProcessName(Current process:C322)="Ancillary")
		
	Else 
		CONFIRM:C162("Include Comments in Element Report"; "Include"; "Do NOT Include")
		vIncludeComments:=OK=1
	End if 
	G_PrintOptions
	PRINT SETTINGS:C106
	C_LONGINT:C283($PrintSetOK)
	$PrintSetOK:=OK
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
	SET PRINT OPTION:C733(Spooler document name option:K47:10; ("LSS Inventory <"+String:C10($Recs)+">"))
	C_LONGINT:C283($val1)
	C_TEXT:C284($val2; $val3)
	GET PRINT OPTION:C734(9; $val1; $val2)
	GET PRINT OPTION:C734(12; $val3)
	C_BOOLEAN:C305($TopOfPage_B)
	C_TEXT:C284($CurrentPrinter_T)
	$CurrentPrinter_T:=Get current printer:C788
	
	If ($PrintSetOK=1)  //check to see if canceled from Print Settings    
		
		vCurrPage:=0
		vRptHeader:="Massachusetts DOT - Highway Department"+<>sCR+"Ancillary Structures with Deficient Elements"
		vRptDate:=Current date:C33(*)
		vRptTime:=Current time:C178(*)
		C_LONGINT:C283(prtHt_HDR0_L; prtHt_HDR1_L; prtHt_HDR2_L; prtHt_Det_L; prtHt_Footer_L; DEFELMTPRINT_MarkerHt_L; $printableHt_L; $PrintedHt_L)
		C_BOOLEAN:C305(DEFELMTPRINT_Test_B; DEFELMTPRINT_GetHT_B; DEFELMTPRINT_EmtCont_b; DEFELMTPRINT_BrgHdr_b)
		C_TEXT:C284(DEFELMTPRINT_Area_txt; vsContText)
		DEFELMTPRINT_Test_B:=True:C214
		DEFELMTPRINT_EmtCont_b:=False:C215
		BREAK LEVEL:C302(3)
		C_LONGINT:C283($htPrinted; $FooterNeeded; $htNeeded_L)
		$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem")
		//BREAK LEVEL(0)
		DEFELMTPRINT_Test_B:=False:C215
		GET PRINTABLE AREA:C703($printableHt_L)
		C_TEXT:C284(ElmCmts_txt)
		
		DEFELMTPRINT_Area_txt:="Header"
		vCurrPage:=vCurrPage+1
		$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header:K43:3)
		vsContText:=""
		$TopOfPage_B:=True:C214
		
		C_TEXT:C284($LastElement_txt)
		C_LONGINT:C283($InnerLoop_L)
		C_LONGINT:C283($lastPage_L)
		$lastPage_L:=1
		For ($i; 1; Size of array:C274($InventoryIDs_atxt))
			QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=$InventoryIDs_atxt{$i})
			
			QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InventoryId_s:2=[LSS_Inventory:165]LSS_InventoryId_s:1)
			RELATE MANY SELECTION:C340([LSS_ElementInspection:163]LSS_InspectionId_s:3)
			
			CREATE SET:C116([LSS_ElementInspection:163]; "ElmtsThisInsp")
			INTERSECTION:C121("LSS_ElementReportSet"; "ElmtsThisInsp"; "ElmtsToPrint")
			USE SET:C118("ElmtsToPrint")
			ARRAY TEXT:C222($InspectionIDs_atxt; 0)
			DISTINCT VALUES:C339([LSS_ElementInspection:163]LSS_InspectionId_s:3; $InspectionIDs_atxt)
			
			For ($InnerLoop_L; 1; Size of array:C274($InspectionIDs_atxt))
				USE SET:C118("ElmtsToPrint")
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=$InspectionIDs_atxt{$InnerLoop_L})
				QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=$InventoryIDs_atxt{$i})
				If ([LSS_Inventory:165]LSS_StructureNumber_s:6="A09-IT-I0093N-037-400010")
					TRACE:C157
				End if 
				v_165_006_txt:="Structure Number : "+[LSS_Inventory:165]LSS_StructureNumber_s:6
				v_165_004_txt:="Town : "+[LSS_Inventory:165]LSS_Town_s:4
				v_165_010_txt:="Structure Location : "+[LSS_Inventory:165]LSS_StructureLocation_txt:10
				v_165_008_r:=[LSS_Inventory:165]LSS_MilePoint_r:8
				v_165_003_L:=[LSS_Inventory:165]LSS_District_L:3
				
				
				ARRAY TEXT:C222(v_162_002_atxt; 0)
				ARRAY LONGINT:C221(v_162_001_aL; 0)
				ARRAY TEXT:C222(LSS_Headers_atxt; 0)
				
				LSS_SetUpArraysforElements
				
				
				
				QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=[LSS_ElementInspection:163]LSS_InspectionId_s:3)
				
				LSS_SetUpAndSortForElementRpt
				QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=[LSS_ElementInspection:163]LSS_InspectionId_s:3)
				
				LOAD RECORD:C52([LSS_Inspection:164])
				$PrintedHt_L:=Get printed height:C702
				If (Records in selection:C76([LSS_ElementInspection:163])>1)
					$FooterNeeded:=0
				Else 
					$FooterNeeded:=1
				End if 
				If ($i>1)  //check for after the 1st bridge rec
					$htNeeded_L:=prtHt_HDR1_L+prtHt_HDR2_L+prtHt_Det_L+($FooterNeeded*prtHt_Footer_L)
					GOTO SELECTED RECORD:C245([LSS_ElementInspection:163]; 1)
					If ((vIncludeComments) & (Length:C16([LSS_ElementInspection:163]LSS_Remarks_txt:8)>0))
						ElmCmts_txt:=[LSS_ElementInspection:163]LSS_Remarks_txt:8
						DEFELMTPRINT_Area_txt:="Break0"
						DEFELMTPRINT_GetHT_B:=True:C214
						$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form break0:K43:14)
						DEFELMTPRINT_GetHT_B:=False:C215
						$htNeeded_L:=$htNeeded_L+DEFELMTPRINT_MarkerHt_L
					End if 
					If (($PrintedHt_L+$htNeeded_L)>$printableHt_L)
						PAGE BREAK:C6(>)  //Start a new page
						DEFELMTPRINT_Area_txt:="Header"
						$lastPage_L:=vCurrPage
						vCurrPage:=vCurrPage+1
						$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header:K43:3)
						$TopOfPage_B:=True:C214
					End if 
					
				End if 
				
				DEFELMTPRINT_Area_txt:="Header1"
				If ($InnerLoop_L=1) | ($lastPage_L#vCurrPage)
					$lastPage_L:=vCurrPage
					$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header1:K43:4)
					
					DEFELMTPRINT_BrgHdr_b:=True:C214
				End if 
				$PrintInspHdr:=""
				vsListInspTitle:=""
				For ($j; 1; Records in selection:C76([LSS_ElementInspection:163]))
					GOTO SELECTED RECORD:C245([LSS_ElementInspection:163]; $j)
					If ($j=Records in selection:C76([LSS_ElementInspection:163]))
						$FooterNeeded:=1
					Else 
						$FooterNeeded:=0
					End if 
					C_TEXT:C284($AllCmts_txt)
					$AllCmts_txt:=[LSS_ElementInspection:163]LSS_Remarks_txt:8
					
					
					//load record([LSS_Inspection]
					If ([LSS_Inspection:164]LSS_InspectionId_s:1#$PrintInspHdr)
						//New Inspection report - print inspection header
						QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=[LSS_Inspection:164]LSS_InspectionTypeId_s:3)
						
						vsListInspTitle:=[LSS_refInspectionType:167]LSS_Description_txt:2
						Case of 
							: (Position:C15("Highway Sign"; LSS_StructureClass_txt)>0)
								v_164_012_txt:=[LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18
							: (Position:C15("Lighting"; LSS_StructureClass_txt)>0)
								v_164_012_txt:=[LSS_Inspection:164]LSS_CondLuminaireCurr_s:22
							: (Position:C15("Signal"; LSS_StructureClass_txt)>0)
								v_164_012_txt:=[LSS_Inspection:164]LSS_StructAttachmentsCurr_s:16
							: (Position:C15("Intelligent Structure"; LSS_StructureClass_txt)>0)
								v_164_012_txt:=[LSS_Inspection:164]LSS_CondLuminaireCurr_s:22
						End case 
						
						If ($PrintInspHdr#"")
							//Print the footer for the previous insp report
							DEFELMTPRINT_Area_txt:="Footer"
							$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form footer:K43:2)
						End if 
						If (Not:C34($TopOfPage_B))
							$htNeeded_L:=prtHt_HDR2_L+prtHt_Det_L+($FooterNeeded*prtHt_Footer_L)
							If ((vIncludeComments) & (Length:C16([LSS_ElementInspection:163]LSS_Remarks_txt:8)>0))
								ElmCmts_txt:=$AllCmts_txt
								DEFELMTPRINT_Area_txt:="Break0"
								DEFELMTPRINT_GetHT_B:=True:C214
								$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form break0:K43:14)
								DEFELMTPRINT_GetHT_B:=False:C215
								$htNeeded_L:=$htNeeded_L+DEFELMTPRINT_MarkerHt_L
							End if 
							If ((Get printed height:C702+$htNeeded_L)>$printableHt_L)
								PAGE BREAK:C6(>)  //Start a new page
								DEFELMTPRINT_Area_txt:="Header"
								vCurrPage:=vCurrPage+1
								$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header:K43:3)
								DEFELMTPRINT_BrgHdr_b:=False:C215
								$TopOfPage_B:=True:C214
							End if 
						End if 
						DEFELMTPRINT_Area_txt:="Header2"
						$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header2:K43:5)
						$PrintInspHdr:=[LSS_Inspection:164]LSS_InspectionId_s:1
					End if 
					If (Not:C34($TopOfPage_B))
						If ((Get printed height:C702+prtHt_Det_L+($FooterNeeded*prtHt_Footer_L))>$printableHt_L)
							PAGE BREAK:C6(>)  //Start a new page
							DEFELMTPRINT_Area_txt:="Header"
							vCurrPage:=vCurrPage+1
							$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header:K43:3)
							DEFELMTPRINT_Area_txt:="Header2"
							vsContText:="(Continued)"
							$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header2:K43:5)
							vsContText:=""
							DEFELMTPRINT_BrgHdr_b:=False:C215
							$TopOfPage_B:=True:C214
						End if 
						
					End if 
					If ((vIncludeComments) & (Length:C16([LSS_ElementInspection:163]LSS_Remarks_txt:8)>0))
						ElmCmts_txt:=$AllCmts_txt
						DEFELMTPRINT_Area_txt:="Break0"
						DEFELMTPRINT_GetHT_B:=True:C214
						$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form break0:K43:14)
						DEFELMTPRINT_GetHT_B:=False:C215
						If (Not:C34($TopOfPage_B))
							If ((Get printed height:C702+prtHt_Det_L+DEFELMTPRINT_MarkerHt_L+($FooterNeeded*prtHt_Footer_L))>$printableHt_L)
								PAGE BREAK:C6(>)  //Start a new page
								DEFELMTPRINT_Area_txt:="Header"
								vCurrPage:=vCurrPage+1
								$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header:K43:3)
								DEFELMTPRINT_Area_txt:="Header2"
								vsContText:="(Continued)"
								$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header2:K43:5)
								vsContText:=""
								DEFELMTPRINT_BrgHdr_b:=False:C215
								$TopOfPage_B:=True:C214
							End if 
							
						End if 
						DEFELMTPRINT_Area_txt:="detail"
						$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form detail:K43:1)
						DEFELMTPRINT_Area_txt:="Break0"
						ElmCmts_txt:=$AllCmts_txt
						$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form break0:K43:14)
						C_LONGINT:C283(DEFELMTPRINT_LastChar_L)
						While (DEFELMTPRINT_LastChar_L>0)
							DEFELMTPRINT_EmtCont_b:=True:C214
							$AllCmts_txt:=Substring:C12($AllCmts_txt; (DEFELMTPRINT_LastChar_L+1))
							DEFELMTPRINT_LastChar_L:=0
							ElmCmts_txt:=$AllCmts_txt
							PAGE BREAK:C6(>)  //Start a new page
							DEFELMTPRINT_BrgHdr_b:=False:C215
							DEFELMTPRINT_Area_txt:="Header"
							vCurrPage:=vCurrPage+1
							$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header:K43:3)
							DEFELMTPRINT_Area_txt:="Header2"
							vsContText:="(Continued)"
							$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form header2:K43:5)
							
							$TopOfPage_B:=True:C214
							DEFELMTPRINT_Area_txt:="detail"
							$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form detail:K43:1)
							vsContText:=""
							DEFELMTPRINT_Area_txt:="Break0"
							$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form break0:K43:14)
							
						End while 
						$AllCmts_txt:=""
						DEFELMTPRINT_EmtCont_b:=False:C215
						$TopOfPage_B:=False:C215
					Else 
						DEFELMTPRINT_Area_txt:="detail"
						$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form detail:K43:1)
						$TopOfPage_B:=False:C215
					End if 
					
				End for 
				DEFELMTPRINT_Area_txt:="Footer"
				$htPrinted:=Print form:C5([LSS_ElementInspection:163]; "Rpt DefElem"; Form footer:K43:2)
			End for 
			
			If ($i=Size of array:C274($InventoryIDs_atxt))
				PAGE BREAK:C6
			Else 
				//PAGE BREAK(>)
			End if 
		End for 
		
		USE SET:C118("LSS_ElementReportSet")
		
	End if 
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
	
End if 
//End M_CreateLSSElementReport