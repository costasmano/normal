//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/14/05, 10:58:33
	// ----------------------------------------------------
	// Method: M_PontisElementRpt
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:35:20)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(12/31/09 10:37:50)
	Mods_2009_12
	//  `Changed header to Massschusetts DOT...
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
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
		vRptHeader:="Massachusetts DOT - Highway Department"+<>sCR+"Pontis Element Report"
		vRptDate:=Current date:C33(*)
		vRptTime:=Current time:C178(*)
		vCurrPage:=0
		$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form header:K43:3)
		$PageStart:=True:C214
		
		For ($i; 1; Records in selection:C76([Bridge MHD NBIS:1]))
			
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $i)
			vRptPages:=1
			
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]BIN:2=[Bridge MHD NBIS:1]BIN:3)
			RELATE MANY SELECTION:C340([Cond Units:45]Inspection ID:2)
			
			CREATE SET:C116([Cond Units:45]; "ElmtsThisInsp")
			INTERSECTION:C121("ElmtsThisInsp"; "TotalElmtsFound"; "ElmtsToPrint")
			USE SET:C118("ElmtsToPrint")
			CLEAR SET:C117("ElmtsToPrint")
			CLEAR SET:C117("ElmtsThisInsp")
			
			GOTO SELECTED RECORD:C245([Cond Units:45]; 1)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Cond Units:45]Inspection ID:2)
			ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; >; [Cond Units:45]Environment:4; >)
			
			If ($pageStart)
				$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form header1:K43:4)
				$pageStart:=False:C215
			Else 
				//Not at page start
				C_LONGINT:C283($vlPrintHtNeeded)
				//see if we can fit all of bridge in this page.
				$vlPrinted_ht:=Get printed height:C702  //check if we can fit
				$vlPrintHtNeeded:=(130-53)+(175-167)+(Records in selection:C76([Cond Units:45])*(167-130))
				If (($vlPrinted_ht+$vlPrintHtNeeded)<$vlPrint_Ht)
					//fit go ahead
					$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form header1:K43:4)
				Else 
					//not fit
					PAGE BREAK:C6(>)
					$pageStart:=False:C215
					$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form header:K43:3)
					$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form header1:K43:4)
					
				End if 
				
			End if 
			C_LONGINT:C283($j)
			For ($j; 1; Records in selection:C76([Cond Units:45]))
				GOTO SELECTED RECORD:C245([Cond Units:45]; $j)
				QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=[Cond Units:45]Element ID:3)
				QUERY:C277([BMS Categories:49]; [BMS Categories:49]Category ID:1=[BMS Elements:47]Category ID:8)
				$vlPrinted_ht:=Get printed height:C702
				If (($vlPrinted_ht+(167-130)+(175-167))>$vlPrint_ht)
					//won't fit
					$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form footer:K43:2)
					PAGE BREAK:C6(>)
					$pageStart:=False:C215
					$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form header:K43:3)
					$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form header1:K43:4)
					
				Else 
					$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form detail:K43:1)
				End if 
			End for 
			$htPrinted:=Print form:C5([Cond Units:45]; "CondUnitsPrt3"; Form footer:K43:2)
			If ($i=Records in selection:C76([Bridge MHD NBIS:1]))
				PAGE BREAK:C6  //at end force spool of job break
			End if 
		End for 
		USE NAMED SELECTION:C332("DefBridgeList")
		CLEAR NAMED SELECTION:C333("DefBridgeList")
	End if 
	SET PRINT OPTION:C733(Spooler document name option:K47:10; "")
	
End if 
