//%attributes = {"invisible":true}
If (False:C215)
	//copy from M_RPC_Report
	//Use the current selection and print a report
	//This version uses Print Layout to completely control printing.
	
	// ----------------------------------------------------
	// M_ContractRpt_Invoice
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:12:55
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 16:12:58 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:24:00)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(12/31/09 10:37:50)
	Mods_2009_12
	//  `Changed header to Massschusetts DOT...
	Mods_2011_06  // CJ Miller`06/14/11, 10:21:21      ` Type all local variables for v11
End if 

C_LONGINT:C283($i; $j; $countInvoiceNo; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($PixPage; $PixH0; $PixH1; $PixD; $PixF; $PixCount)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vRptHeader; vRptDescr; vRateInfo)
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
C_TEXT:C284($type)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($Recs)
C_TEXT:C284($sContractNo; $sContractType)
$PixPage:=551
$PixH0:=61
$PixH1:=10
$PixD:=8
$PixF:=3

//TRACE

//```````````` ````````````` ````````````` ````````````` `````````````
//````Retrieve invoice numbers for the selected contract
//```````````` ````````````` ````````````` ````````````` `````````````
$Recs:=Records in set:C195("UserSet")

If (Not:C34($Recs=1))
	ALERT:C41("Please select one contract to generate this report!")
Else 
	
	PRINT SETTINGS:C106
	If (Ok=1)  //check to see if canceled from Print Settings
		
		COPY NAMED SELECTION:C331([Contracts:79]; "PrePrintContractList")
		USE SET:C118("UserSet")
		
		FIRST RECORD:C50([Contracts:79])
		$sContractNo:=[Contracts:79]ContractNo:1
		$sContractType:=[Contracts:79]ContractType:2
		QUERY:C277([Contract Invoice:84]; [Contract Invoice:84]ContractNo:3=$sContractNo)
		$countInvoiceNo:=Records in selection:C76([Contract Invoice:84])
		ARRAY LONGINT:C221($aiInvoiceNo; $countInvoiceNo)
		DISTINCT VALUES:C339([Contract Invoice:84]InvoiceNo:2; $aiInvoiceNo)
		SORT ARRAY:C229($aiInvoiceNo)
		
		//```````````` ````````````` ````````````` ````````````` `````````````
		//```` Report Header
		//```````````` ````````````` ````````````` ````````````` `````````````
		vRptHeader:=[Contracts:79]ConsltName:3+<>sCR+"Massachusetts DOT - Highway Department"+<>sCR+"Bridge "
		$type:=Substring:C12($sContractType; Position:C15(" "; $sContractType)+1; Length:C16($sContractType))
		If ($type="Inspection")
			vRptHeader:=vRptHeader+"Inspection"
		Else 
			vRptHeader:=vRptHeader+"Rating"
		End if 
		vRptHeader:=vRptHeader+" Payment/Invoice Summary"
		vRptDate:=Current date:C33(*)
		vRptTime:=Current time:C178(*)
		vCurrPage:=1
		vRateInfo:="Contract No: "+$sContractNo
		vRateInfo:=vRateInfo+<>sCR+"Contract Type: "+$sContractType
		G_PrintOptions(2)
		//PAGE SETUP([Contracts];"Rpt Invoice Header")
		Print form:C5([Contracts:79]; "Rpt Invoice Header")
		
		//```````````` ````````````` ````````````` ````````````` `````````````
		//``````` Detail Section
		//```````````` ````````````` ````````````` ````````````` `````````````
		C_LONGINT:C283($invoiceID)
		
		For ($i; 1; $countInvoiceNo)
			QUERY:C277([Contract Invoice:84]; [Contract Invoice:84]ContractNo:3=$sContractNo; *)
			QUERY:C277([Contract Invoice:84];  & ; [Contract Invoice:84]InvoiceNo:2=$aiInvoiceNo{$i})
			If (Records in selection:C76([Contract Invoice:84])=1)
				$invoiceID:=[Contract Invoice:84]InvoiceID:1
				//print out invoice related information      
				Print form:C5([Contracts:79]; "Rpt Invoice Detail 1")
				
				//check for assignment percentages
				QUERY:C277([Contract Invoice AssignNo:85]; [Contract Invoice AssignNo:85]InvoiceID:1=$invoiceID)
				For ($j; 1; Records in selection:C76([Contract Invoice AssignNo:85]))
					Print form:C5([Contracts:79]; "Rpt Invoice Detail 2")
					NEXT RECORD:C51([Contract Invoice AssignNo:85])
				End for 
				
			End if 
			
		End for   //end of assingment # loop
		
		
		//```````````` ````````````` ````````````` ````````````` `````````````
		//``````` Footer
		//```````````` ````````````` ````````````` ````````````` `````````````    
		Print form:C5([Contracts:79]; "Rpt Invoice Footer")
		PAGE BREAK:C6
		
		USE NAMED SELECTION:C332("PrePrintContractList")
		CLEAR NAMED SELECTION:C333("PrePrintContractList")
		HIGHLIGHT RECORDS:C656("UserSet")
		REDRAW WINDOW:C456
	End if 
End if 

//End M_ContractRpt_Invoice
