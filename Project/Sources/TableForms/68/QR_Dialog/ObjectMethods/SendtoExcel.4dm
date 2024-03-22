// Method: [zDialogs].QR_Dialog.SendtoExcel
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 2022-06-07T00:00:00, 14:23:36
	// ----------------------------------------------------
	// First Release
	Mods_2022_06
End if 

C_TEXT:C284($LeftTitle; $centerTitle; $rightTitle; $LeftFooter; $CenterFooter; $rightFooter)
C_LONGINT:C283($TitleHt)
QR GET HEADER AND FOOTER:C775(Report_Area_l; 1; $LeftTitle; $centerTitle; $rightTitle; $TitleHt)
QR GET HEADER AND FOOTER:C775(Report_Area_l; 2; $LeftFooter; $CenterFooter; $rightFooter; $TitleHt)

C_TEXT:C284($tempExcelfile; $excelFile)
If (($LeftTitle+$centerTitle+$rightTitle)#"")
	$LeftTitle:=$LeftTitle+" "+$centerTitle+" "+$rightTitle
	$LeftTitle:=Replace string:C233($LeftTitle; "#D"; String:C10(Current date:C33))
	$LeftTitle:=Replace string:C233($LeftTitle; "#H"; String:C10(Current time:C178))
	$LeftTitle:=Replace string:C233($LeftTitle; "#P"; "")  //no page numbers
	
Else 
	$LeftTitle:=""
End if 
If (($LeftFooter+$CenterFooter+$rightFooter)#"")
	$LeftFooter:=$LeftFooter+" "+$CenterFooter+" "+$rightFooter
	$LeftFooter:=Replace string:C233($LeftFooter; "#D"; String:C10(Current date:C33))
	$LeftFooter:=Replace string:C233($LeftFooter; "#H"; String:C10(Current time:C178))
	$LeftFooter:=Replace string:C233($LeftFooter; "#P"; "")  //no page numbers
Else 
	$LeftFooter:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
End if 
C_BLOB:C604($qrBlob)
QR REPORT TO BLOB:C770(Report_Area_l; $qrBlob)

$tempExcelfile:=XLSX_QRpt2XLSX(New object:C1471("Title"; $LeftTitle; "Subtitle"; $LeftFooter); ->$qrBlob)
If ($tempExcelfile#"")
	$excelFile:=Select document:C905(""; "xlsx"; "Specify report excel file"; File name entry:K24:17)
	If (OK=1)
		COPY DOCUMENT:C541($TempexcelFile; Document; *)
		SHOW ON DISK:C922(Document)
	End if 
Else 
	ALERT:C41("Error generating Excel file from report")
End if 
//End Object Method: Button1