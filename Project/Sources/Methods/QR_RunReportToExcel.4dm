//%attributes = {"invisible":true}
//Method: QR_RunReportToExcel
//Description
// run a quick report from a file and save to an excel output
// run from a list form
// Parameters
// $1 : $CurrentTable_ptr (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-05-20T00:00:00, 17:16:55
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
	
	C_POINTER:C301(QR_RunReportToExcel; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-05-31 18:29:52)
	Mods_2022_05
	//  `use resolve pointer instead of Table($ptr)
End if 
//
C_LONGINT:C283($currTable_L)
If (Is nil pointer:C315(Current form table:C627))
Else 
	$currTable_L:=Table:C252(Current form table:C627)
End if 
If (Count parameters:C259>0)
	C_POINTER:C301($1)
	C_TEXT:C284($varname)
	C_LONGINT:C283($fieldnum)
	RESOLVE POINTER:C394($1; $varname; $currTable_L; $fieldnum)
End if 

If (Is table number valid:C999($currTable_L))
	//Load a quick report file from disk
	C_TEXT:C284($QrFile)
	$QrFile:=Select document:C905(""; ".4qr"; "Select QuickReport file to execute"; 0)
	
	If (OK=1)
		C_BLOB:C604($qrBlob)
		C_OBJECT:C1216($doc_o)
		$doc_o:=Path to object:C1547(Document)
		DOCUMENT TO BLOB:C525(Document; $qrBlob)
		
		C_LONGINT:C283($vnQRArea; $Qrtable)
		$vnQRArea:=QR New offscreen area:C735
		QR BLOB TO REPORT:C771($vnQRArea; $qrBlob)
		$Qrtable:=QR Get report table:C758($vnQRArea)
		C_TEXT:C284($LeftTitle; $centerTitle; $rightTitle; $LeftFooter; $CenterFooter; $rightFooter)
		C_LONGINT:C283($TitleHt)
		QR GET HEADER AND FOOTER:C775($vnQRArea; 1; $LeftTitle; $centerTitle; $rightTitle; $TitleHt)
		QR GET HEADER AND FOOTER:C775($vnQRArea; 2; $LeftFooter; $CenterFooter; $rightFooter; $TitleHt)
		QR DELETE OFFSCREEN AREA:C754($vnQRArea)
		
		If ($Qrtable=$currTable_L)
			C_TEXT:C284($tempExcelfile; $excelFile)
			If (($LeftTitle+$centerTitle+$rightTitle)#"")
				$LeftTitle:=$LeftTitle+" "+$centerTitle+" "+$rightTitle
				$LeftTitle:=Replace string:C233($LeftTitle; "#D"; String:C10(Current date:C33))
				$LeftTitle:=Replace string:C233($LeftTitle; "#H"; String:C10(Current time:C178))
				$LeftTitle:=Replace string:C233($LeftTitle; "#P"; "")  //no page numbers
				
			Else 
				$LeftTitle:=$doc_o.name
			End if 
			If (($LeftFooter+$CenterFooter+$rightFooter)#"")
				$LeftFooter:=$LeftFooter+" "+$CenterFooter+" "+$rightFooter
				$LeftFooter:=Replace string:C233($LeftFooter; "#D"; String:C10(Current date:C33))
				$LeftFooter:=Replace string:C233($LeftFooter; "#H"; String:C10(Current time:C178))
				$LeftFooter:=Replace string:C233($LeftFooter; "#P"; "")  //no page numbers
			Else 
				$LeftFooter:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
			End if 
			
			$tempExcelfile:=XLSX_QRpt2XLSX(New object:C1471("Title"; $LeftTitle; "Subtitle"; $LeftFooter); ->$qrBlob)
			If ($tempExcelfile#"")
				$excelFile:=Select document:C905(""; "xlsx"; "Specify report excel file"; File name entry:K24:17)
				If (OK=1)
					COPY DOCUMENT:C541($TempexcelFile; Document; *)
					SHOW ON DISK:C922(Document)
				End if 
			Else 
				ALERT:C41("Error generating Excel file from report "+$doc_o.parentFolder+$doc_o.name)
			End if 
		Else 
			ALERT:C41("Master table for report in file "+$doc_o.parentFolder+$doc_o.name+" is ["+Table name:C256($Qrtable)+\
				"] which does not match the current Master table ["+Table name:C256($currTable_L)+"]")
		End if 
		
	End if 
	
Else 
	ALERT:C41("Passed a pointer to an invalid table number!")
End if 
//End QR_RunReportToExcel