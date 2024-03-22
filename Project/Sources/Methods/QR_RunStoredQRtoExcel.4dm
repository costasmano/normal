//%attributes = {"invisible":true}
//Method: QR_RunStoredQRtoExcel
//Description
// execute a stored quick report to Excel. Can be  used using execute formula
// Parameters
// $1 : $masterTable_ptr
// $2 : $TemplateName_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-05-31 16:43:03
	// ----------------------------------------------------
	//Created : 
	Mods_2022_05
	
	C_POINTER:C301(QR_RunStoredQRtoExcel; $1)
	C_TEXT:C284(QR_RunStoredQRtoExcel; $2)
End if 
//

C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($TemplateName_txt)
C_LONGINT:C283($MasterTable_L)

If (Is nil pointer:C315($1))
Else 
	C_TEXT:C284($varname)
	C_LONGINT:C283($fieldnum)
	RESOLVE POINTER:C394($1; $varname; $MasterTable_L; $fieldnum)
End if 
$TemplateName_txt:=$2

If (Is table number valid:C999($MasterTable_L))
	C_BOOLEAN:C305($roState_b)
	$roState_b:=Read only state:C362([Templates:86])
	If ($TemplateName_txt="QRT@")
		READ ONLY:C145([Templates:86])
		QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$TemplateName_txt)
		
		Case of 
			: (Records in selection:C76([Templates:86])=0)
				ALERT:C41("No Template named "+$TemplateName_txt+" was found!")
			: (Records in selection:C76([Templates:86])#1)
				ALERT:C41("Multiple ("+String:C10(Records in selection:C76([Templates:86]))+") Templates named "+$TemplateName_txt+" were found!")
				
			Else 
				C_BLOB:C604($qrBlob)
				$qrBlob:=[Templates:86]Template_:3
				C_LONGINT:C283($vnQRArea; $Qrtable)
				$vnQRArea:=QR New offscreen area:C735
				C_BOOLEAN:C305()
				C_TEXT:C284($prevOnErr)
				$prevOnErr:=Method called on error:C704
				C_BOOLEAN:C305(4DError_b)
				4DError_b:=False:C215
				ON ERR CALL:C155("4D_Errors")
				QR BLOB TO REPORT:C771($vnQRArea; $qrBlob)
				If (Not:C34(4DError_b))
					$Qrtable:=QR Get report table:C758($vnQRArea)
					C_TEXT:C284($LeftTitle; $centerTitle; $rightTitle; $LeftFooter; $CenterFooter; $rightFooter)
					C_LONGINT:C283($TitleHt)
					QR GET HEADER AND FOOTER:C775($vnQRArea; 1; $LeftTitle; $centerTitle; $rightTitle; $TitleHt)
					QR GET HEADER AND FOOTER:C775($vnQRArea; 2; $LeftFooter; $CenterFooter; $rightFooter; $TitleHt)
				Else 
					ALERT:C41("Error loading report from template "+$TemplateName_txt+Char:C90(Carriage return:K15:38)+\
						"Error message(s) : "+ut_ArrayToText(->SQL_InternalDescriptions_atxt; Char:C90(Carriage return:K15:38)))
				End if 
				
				QR DELETE OFFSCREEN AREA:C754($vnQRArea)
				
				If ($Qrtable=$MasterTable_L)
					C_TEXT:C284($tempExcelfile; $excelFile)
					If (($LeftTitle+$centerTitle+$rightTitle)#"")
						$LeftTitle:=$LeftTitle+" "+$centerTitle+" "+$rightTitle
						$LeftTitle:=Replace string:C233($LeftTitle; "#D"; String:C10(Current date:C33))
						$LeftTitle:=Replace string:C233($LeftTitle; "#H"; String:C10(Current time:C178))
						$LeftTitle:=Replace string:C233($LeftTitle; "#P"; "")  //no page numbers
						
					Else 
						$LeftTitle:=$TemplateName_txt
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
						ALERT:C41("Error generating Excel file from template "+$TemplateName_txt)
					End if 
				Else 
					ALERT:C41("Master table for report in template "+$TemplateName_txt+" is ["+Table name:C256($Qrtable)+\
						"] which does not match the specified Master table ["+Table name:C256($MasterTable_L)+"]")
				End if 
				
		End case 
		
	Else 
		ALERT:C41("Template name "+$TemplateName_txt+" is not a Quick report template!")
	End if 
	
Else 
	ALERT:C41("Pointer to invalid table number was passed to method "+Current method name:C684+"!")
End if 

//End QR_RunStoredQRtoExcel