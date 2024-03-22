//%attributes = {"invisible":true}
//Method: QRUTIL_ParseStoredQRs
//Description
// parse all stored quick reports in the Templates table and report on columns
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/05/19, 14:27:10
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//

READ ONLY:C145([Templates:86])

QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="QRT_@")

ORDER BY:C49([Templates:86]; [Templates:86]TemplateName:2; >)

C_OBJECT:C1216($Info_o)
C_TEXT:C284($results_txt)

//header
$results_txt:="Menu\tMenuCategory\tMenuCommand\tTemplate Name\tColumnNum\tTitle\tColumnObject\tHidden\tColumnWidth\tRepeated\tFormat\n"

C_LONGINT:C283($qrArea_L; $col_L)
$qrArea_L:=QR New offscreen area:C735

FIRST RECORD:C50([Templates:86])
While (Not:C34(End selection:C36([Templates:86])))
	
	QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]MethodName:3=[Templates:86]TemplateName:2)
	
	QR BLOB TO REPORT:C771($qrArea_L; [Templates:86]Template_:3)
	$Info_o:=QRUTIL_GetColumnInfo($qrArea_L)
	//extract data from object
	ARRAY TEXT:C222($colTitle_atxt; 0)
	ARRAY TEXT:C222($colObject_atxt; 0)
	ARRAY LONGINT:C221($hide_aL; 0)
	ARRAY LONGINT:C221($colSize_aL; 0)
	ARRAY LONGINT:C221($repeated_aL; 0)
	ARRAY TEXT:C222($format_atxt; 0)
	
	OB GET ARRAY:C1229($Info_o; "columnTitle"; $colTitle_atxt)
	OB GET ARRAY:C1229($Info_o; "columnObject"; $colObject_atxt)
	OB GET ARRAY:C1229($Info_o; "columnHide"; $hide_aL)
	OB GET ARRAY:C1229($Info_o; "columnSize"; $colSize_aL)
	OB GET ARRAY:C1229($Info_o; "repeatedValue"; $repeated_aL)
	OB GET ARRAY:C1229($Info_o; "columnFormat"; $format_atxt)
	
	For ($col_L; 1; Size of array:C274($colTitle_atxt))
		
		If (Position:C15(Char:C90(13); $colTitle_atxt{$col_L})>0)
			$colTitle_atxt{$col_L}:=Replace string:C233($colTitle_atxt{$col_L}; Char:C90(13); "__")
		End if 
		
		$results_txt:=$results_txt+[zSpecialReports:106]Purpose:1+"\t"+\
			[zSpecialReports:106]SubCategory:5+"\t"+\
			[zSpecialReports:106]ReportName:2+"\t"+\
			[Templates:86]TemplateName:2+"\t"+String:C10($col_L)+"\t"+\
			$colTitle_atxt{$col_L}+"\t"+\
			$colObject_atxt{$col_L}+"\t"+\
			String:C10($hide_aL{$col_L})+"\t"+\
			String:C10($colSize_aL{$col_L})+"\t"+\
			String:C10($repeated_aL{$col_L})+"\t"+\
			$format_atxt{$col_L}+"\n"
		
	End for 
	
	NEXT RECORD:C51([Templates:86])
End while 

QR DELETE OFFSCREEN AREA:C754($qrArea_L)

C_TEXT:C284($docname_txt)

$docname_txt:=Select document:C905(""; ".txt"; "Choose results file"; File name entry:K24:17; $colTitle_atxt)

If (ok=1)
	
	TEXT TO DOCUMENT:C1237($colTitle_atxt{1}; $results_txt)
	SHOW ON DISK:C922($colTitle_atxt{1})
	
End if 
//End QRUTIL_ParseStoredQRs