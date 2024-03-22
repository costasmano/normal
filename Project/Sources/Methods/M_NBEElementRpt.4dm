//%attributes = {"invisible":true}
//Method: M_NBEElementRpt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/13/15, 11:38:12
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10
End if 
//
//
C_LONGINT:C283($Recs; $i)
$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
C_BOOLEAN:C305($PageStart)

If ($Recs<1)
	//ALERT("Please select at least one bridge to generate this report!")
Else 
	G_PrintOptions
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
	SET PRINT OPTION:C733(Spooler document name option:K47:10; ("Bridge List <"+String:C10($Recs)+">"))
	//PAGE SETUP([ElementsSafety];"Rpt DefElem Header")
	PRINT SETTINGS:C106
	C_LONGINT:C283($PrintSetOK)
	$PrintSetOK:=OK
	C_LONGINT:C283($val1)
	C_TEXT:C284($val2; $val3)
	GET PRINT OPTION:C734(9; $val1; $val2)
	GET PRINT OPTION:C734(12; $val3)
	
	C_TEXT:C284($CurrentPrinter_T)
	$CurrentPrinter_T:=Get current printer:C788
	If ($PrintSetOK=1)  //check to see if canceled from Print Settings    
		
		COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "DefBridgeList")
		C_LONGINT:C283($vlPrinted_ht; $vlPrint_ht; $vlPrint_W; $htPrinted)
		GET PRINTABLE AREA:C703($vlPrint_ht; $vlPrint_W)
		//```` Report Header
		vRptHeader:="Massachusetts DOT - Highway Department"+<>sCR+"NBE Report"
		vRptDate:=Current date:C33(*)
		vRptTime:=Current time:C178(*)
		vCurrPage:=0
		$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form header:K43:3)
		$PageStart:=True:C214
		
		For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
			
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $i)
			vRptPages:=1
			
			QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			RELATE MANY SELECTION:C340([PON_ELEM_INSP:179]INSPID:21)
			
			CREATE SET:C116([PON_ELEM_INSP:179]; "ElmtsThisInsp")
			INTERSECTION:C121("ElmtsThisInsp"; "TotalElmtsFound"; "ElmtsToPrint")
			USE SET:C118("ElmtsToPrint")
			CLEAR SET:C117("ElmtsToPrint")
			CLEAR SET:C117("ElmtsThisInsp")
			
			GOTO SELECTED RECORD:C245([PON_ELEM_INSP:179]; 1)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[PON_ELEM_INSP:179]INSPID:21)
			ORDER BY:C49([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_KEY:3; >; [PON_ELEM_INSP:179]ENVKEY:5; >)
			
			If ($pageStart)
				$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form header1:K43:4)
				$pageStart:=False:C215
			Else 
				//Not at page start
				C_LONGINT:C283($vlPrintHtNeeded)
				//see if we can fit all of bridge in this page.
				$vlPrinted_ht:=Get printed height:C702  //check if we can fit
				$vlPrintHtNeeded:=(130-53)+(175-167)+(Records in selection:C76([PON_ELEM_INSP:179])*(167-130))
				If (($vlPrinted_ht+$vlPrintHtNeeded)<$vlPrint_Ht)
					//fit go ahead
					$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form header1:K43:4)
					//$htPrinted:=Print form([Cond Units];"CondUnitsPrt3";Form Header1 )
				Else 
					//not fit
					PAGE BREAK:C6(>)
					$pageStart:=False:C215
					$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form header:K43:3)
					$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form header1:K43:4)
					
				End if 
				
			End if 
			C_LONGINT:C283($j)
			For ($j; 1; Records in selection:C76([PON_ELEM_INSP:179]))
				GOTO SELECTED RECORD:C245([PON_ELEM_INSP:179]; $j)
				QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
				$vlPrinted_ht:=Get printed height:C702
				If (($vlPrinted_ht+(167-130)+(175-167))>$vlPrint_ht)
					//won't fit
					$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form footer:K43:2)
					PAGE BREAK:C6(>)
					$pageStart:=False:C215
					$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form header:K43:3)
					$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form header1:K43:4)
					
				Else 
					$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form detail:K43:1)
				End if 
			End for 
			$htPrinted:=Print form:C5([PON_ELEM_INSP:179]; "CondUnitsPrt3"; Form footer:K43:2)
			If ($i=Records in selection:C76([Bridge MHD NBIS:1]))
				PAGE BREAK:C6  //at end force spool of job break
			End if 
		End for 
		USE NAMED SELECTION:C332("DefBridgeList")
		CLEAR NAMED SELECTION:C333("DefBridgeList")
	End if 
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
	
End if 

//End M_NBEElementRpt