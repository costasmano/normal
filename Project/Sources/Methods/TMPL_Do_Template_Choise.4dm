//%attributes = {"invisible":true}
// Method: TMPL_Do_Template_Choise
// Description
//  Open a dialog to execute items built from table [zSpecialReports]
// Parameters
// $1 : Text : Purpose - Req'd
// $2 : Text : Title - Req'd
// $3 : Text : OK Button Label - optional
// $4 : Text : Icon name from Picture Library - optional 
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/06, 11:53:36
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(2/12/2007 11:01:36)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(3/27/2007 09:49:34)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/24/08 21:13:31)
	Mods_2008_CM_5404  // ("HLISTSELECT")
	//  `Use new method TMPL_HListOnSelect to find the selected item
	Mods_2009_03  //CJM  r001   `03/06/09, 14:38:13`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(12/23/10 09:58:06)
	Mods_2010_12
	//  `Save the selected item no in a process variable in the dialog
	
	Mods_2011_06  // CJ Miller`06/14/11, 10:36:56      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2022-05-17 16:56:47)
	Mods_2022_05
	//  `use components to create Excel file when doing a print of QR to 4D View , or QR to HTML
	// Modified by: Costas Manousakis-(Designer)-(2022-05-23 20:25:49)
	Mods_2022_05
	//  `Use the Header and footer defined in the QR to fill the title and subtitle.
	//  `Verify that the report table is the same as the current form table.
	// Modified by: Costas Manousakis-(Designer)-(2022-05-31 19:59:03)
	Mods_2022_05
	//  `clean up code
	// Modified by: Costas Manousakis-(Designer)-(2024-02-21 10:20:21)
	Mods_2024_02
	//  `before running a Quick report check to see if there are any records in the current selection
	//  `of the quick report table.
	//  `clean up code to define the offscreen qr area once.
	
End if 
C_TEXT:C284($1; $2; $3; $4)

C_TEXT:C284(vsReportTemplateTitle; vsReportTemplateOKBtn; $vPurpose_txt; $vIconName_txt)
$vPurpose_txt:=$1
vsReportTemplateTitle:=$2
If (Count parameters:C259>2)
	vsReportTemplateOKBtn:=$3
Else 
	vsReportTemplateOKBtn:=""
End if 
If (Count parameters:C259>3)
	$vIconName_txt:=$4
Else 
	$vIconName_txt:=""
End if 

C_LONGINT:C283(vReportTemplPictID_i)  //Command Replaced was o_C_INTEGER
vReportTemplPictID_i:=ut_GetLibraryPicID($vIconName_txt)

C_TEXT:C284($sReportName)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($vlElem; $i)

//Reset them when their jobs are done
ARRAY TEXT:C222(atQRT_MethodNames; 0)
ARRAY TEXT:C222(atQRT_ReportNames; 0)
ARRAY TEXT:C222(atQRT_ReportDescr; 0)
ARRAY TEXT:C222(atReportTemplates; 0)
ARRAY TEXT:C222($atQRT_SubCategories; 0)
READ ONLY:C145([Templates:86])
READ ONLY:C145([zSpecialReports:106])
QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1=$vPurpose_txt)
If (Records in selection:C76([zSpecialReports:106])>0)
	//fill up the arrays for later use in G_LoadReportTemplates
	ORDER BY:C49([zSpecialReports:106]; [zSpecialReports:106]SubCategory:5; >; [zSpecialReports:106]ReportName:2; >)
	SELECTION TO ARRAY:C260([zSpecialReports:106]ReportName:2; atQRT_ReportNames; [zSpecialReports:106]MethodName:3; atQRT_MethodNames; [zSpecialReports:106]SubCategory:5; $atQRT_SubCategories)
	SELECTION TO ARRAY:C260([zSpecialReports:106]LongDescription:4; atQRT_ReportDescr; [zSpecialReports:106]ReportName:2; atReportTemplates)
	For ($i; 1; Size of array:C274(atReportTemplates))
		If (Substring:C12($atQRT_SubCategories{$i}; 5)#"")
			atReportTemplates{$i}:=atReportTemplates{$i}+" ("+Substring:C12($atQRT_SubCategories{$i}; 5)+")"
		End if 
	End for 
	atReportTemplates:=0
	vRptDestOption_i:=0
End if 
C_LONGINT:C283(aHL_ReportTemplates)
C_LONGINT:C283(TMPL_HLSelectedItem_L)
aHL_ReportTemplates:=ut_ArrayToHL(->atReportTemplates)

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "ReportTemplateSelect"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$FormWindow:=Open form window([Dialogs];"ReportTemplateSelect";13)
DIALOG:C40([Dialogs:21]; "ReportTemplateSelect")
CLOSE WINDOW:C154($Win_l)
vsReportTemplateOKBtn:=""

If (OK=1)
	C_LONGINT:C283($ItemSelected)
	$ItemSelected:=TMPL_HLSelectedItem_L
	If ($ItemSelected>0)
		Case of 
			: (atQRT_MethodNames{$ItemSelected}="QRT_@")
				QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=atQRT_MethodNames{$ItemSelected})
				If (Records in selection:C76([Templates:86])=1)
					
					//start of Mods_2024_02
					C_LONGINT:C283($QuickRptArea_L; $Qrtable; $currTable_L)
					C_BLOB:C604($qrblob)
					$qrblob:=[Templates:86]Template_:3  // use this blob to pass to XLSX_QRpt2XLSX
					$QuickRptArea_L:=QR New offscreen area:C735
					QR BLOB TO REPORT:C771($QuickRptArea_L; $qrBlob)
					$Qrtable:=QR Get report table:C758($QuickRptArea_L)
					//need to have some records for the report table
					
					If (Records in selection:C76(Table:C252($Qrtable)->)=0)
						ALERT:C41("There are no records in the current list for table ["+Table name:C256($Qrtable)+"] !\n")
					Else 
						//end of Mods_2024_02
						
						SHORT_MESSAGE("Executing Quick Report....")
						
						Case of 
							: (vRptDestOption_i=_o_qr 4D View area:K14903:3)
								// instead of 4D View make an excel file
								ALERT:C41("Converting report to Excel file...")
								
								$currTable_L:=Table:C252(Current form table:C627)
								C_TEXT:C284($LeftTitle; $centerTitle; $rightTitle; $LeftFooter; $CenterFooter; $rightFooter)
								C_LONGINT:C283($TitleHt)
								QR GET HEADER AND FOOTER:C775($QuickRptArea_L; 1; $LeftTitle; $centerTitle; $rightTitle; $TitleHt)
								QR GET HEADER AND FOOTER:C775($QuickRptArea_L; 2; $LeftFooter; $CenterFooter; $rightFooter; $TitleHt)
								
								If ($Qrtable=$currTable_L)
									C_TEXT:C284($tempExcelfile; $excelFile)
									If (($LeftTitle+$centerTitle+$rightTitle)#"")
										$LeftTitle:=$LeftTitle+" "+$centerTitle+" "+$rightTitle
										$LeftTitle:=Replace string:C233($LeftTitle; "#D"; String:C10(Current date:C33))
										$LeftTitle:=Replace string:C233($LeftTitle; "#H"; String:C10(Current time:C178))
										$LeftTitle:=Replace string:C233($LeftTitle; "#P"; "")  //no page numbers
										
									Else 
										$LeftTitle:=atQRT_ReportNames{$ItemSelected}
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
										ALERT:C41("Error generating Excel file from stored report "+atQRT_ReportNames{$ItemSelected})
									End if 
								Else 
									ALERT:C41("Master table for stored report "+atQRT_ReportNames{$ItemSelected}+" is ["+Table name:C256($Qrtable)+\
										"] which does not match the current Master table ["+Table name:C256($currTable_L)+"]")
								End if 
								
							: (vRptDestOption_i=qr HTML file:K14903:5)
								// send to HTML file
								C_TEXT:C284($htmlFile_txt)
								ARRAY TEXT:C222($files_atxt; 0)
								$htmlFile_txt:=Select document:C905(""; "html"; "Select .html file output"; File name entry:K24:17; $files_atxt)
								
								If (Ok=1)
									$htmlFile_txt:=$files_atxt{1}
									
									//start of Mods_2024_02
									//C_LONGINT($QuickRptArea_L)
									//$QuickRptArea_L:=QR New offscreen area
									//QR BLOB TO REPORT($QuickRptArea_L;[Templates]Template_)
									//end of Mods_2024_02
									
									QR SET DESTINATION:C745($QuickRptArea_L; vRptDestOption_i; $htmlFile_txt)
									QR RUN:C746($QuickRptArea_L)
									
									//start of Mods_2024_02
									//CLOSE WINDOW
									//QR DELETE OFFSCREEN AREA($QuickRptArea_L)  
									//end of Mods_2024_02
									
									//SHOW ON DISK($htmlFile_txt)
									CONFIRM:C162("Convert generated html to Excel?"; "Convert"; "Leave as is")
									If (Ok=1)
										C_TEXT:C284($wk1; $wk2; $ExcelFile_txt)
										$ExcelFile_txt:=Select document:C905(""; "xlsx"; "Select Excel file to save to"; File name entry:K24:17; $files_atxt)
										
										If (OK=1)
											$ExcelFile_txt:=$files_atxt{1}
											$wk1:=XCEL_Workbook_open($htmlFile_txt)
											$wk2:=XCEL_workbook_save_as_xlsx($wk1; $ExcelFile_txt)
											XCEL_workbook_close($wk1)
											XCEL_workbook_close($wk2)
											SHOW ON DISK:C922($ExcelFile_txt)
										Else 
											SHOW ON DISK:C922($htmlFile_txt)
										End if 
										
									End if 
								End if 
								
								
							Else 
								//regular quick report run
								QR SET DOCUMENT PROPERTY:C772($QuickRptArea_L; qr printing dialog:K14907:1; 1)
								If (vRptDestOption_i>0)
									QR SET DESTINATION:C745($QuickRptArea_L; vRptDestOption_i)
									RptDestination:=vRptDestOption_i
								End if 
								Case of 
									: (RptDestination=1)
										QR EXECUTE COMMAND:C791($QuickRptArea_L; qr cmd page setup:K14900:24)
									: (RptDestination=2)
										C_LONGINT:C283($Cols_L; $ColNo_L; $hide_L; $Size_L; $RepeatV_L)
										C_TEXT:C284($Title_txt; $Obj_txt; $DispFormat_txt)
										$Cols_L:=QR Count columns:C764($QuickRptArea_L)
										For ($ColNo_L; 1; $Cols_L)
											QR GET INFO COLUMN:C766($QuickRptArea_L; $ColNo_L; $Title_txt; $Obj_txt; $hide_L; $Size_L; $RepeatV_L; $DispFormat_txt)
											$Title_txt:=Replace string:C233($Title_txt; Char:C90(13); " ")
											$DispFormat_txt:=Replace string:C233($DispFormat_txt; Char:C90(13); " ")
											QR SET INFO COLUMN:C765($QuickRptArea_L; $ColNo_L; $Title_txt; $Obj_txt; $hide_L; $Size_L; $RepeatV_L; $DispFormat_txt)
										End for 
										
								End case 
								QR RUN:C746($QuickRptArea_L)
								
								//start of Mods_2024_02
								//CLOSE WINDOW
								//QR DELETE OFFSCREEN AREA($QuickRptArea_L)
								//end of Mods_2024_02
								
						End case 
						
						CLOSE WINDOW:C154
						
					End if 
					
					QR DELETE OFFSCREEN AREA:C754($QuickRptArea_L)  //  ---  Mods_2024_02
					
					
				Else 
					ALERT:C41("Error locating Quick report "+<>sQu+atReportTemplates{$ItemSelected}+<>sQu+" : <"+atQRT_MethodNames{$ItemSelected}+">")
				End if 
			Else 
				ON ERR CALL:C155("QRT_LaunchMethodError")
				EXECUTE FORMULA:C63(atQRT_MethodNames{$ItemSelected})
				ON ERR CALL:C155("")
		End case 
		
	End if 
	
End if 

//Reset them when their jobs are done
TMPL_HLSelectedItem_L:=-1
ARRAY TEXT:C222(atQRT_MethodNames; 0)
ARRAY TEXT:C222(atQRT_ReportNames; 0)
ARRAY TEXT:C222(atQRT_ReportDescr; 0)
ARRAY TEXT:C222(atReportTemplates; 0)
ARRAY TEXT:C222($atQRT_SubCategories; 0)
If (Is a list:C621(aHL_ReportTemplates))
	CLEAR LIST:C377(aHL_ReportTemplates; *)
End if 

READ WRITE:C146([Templates:86])
READ WRITE:C146([zSpecialReports:106])