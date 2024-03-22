If (False:C215)
	//Object Method: [Dialogs];"ReportTemplateSelect".RptSaveToDisk 
	// Modified by: costasmanousakis-(Designer)-(8/15/2007 11:11:55)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(8/9/10 11:09:04)
	Mods_2010_08
	//  `Fixed problem where report saved was not the correct one.
	Mods_2011_05  //r002 CJ Miller`05/13/11, 14:22:05      `Change way doc is created to"";"4QR" from "";"4DSE" on Macs
End if 

C_LONGINT:C283($LineSelected)
C_LONGINT:C283($vlItemRef; $hSublist; $ItemPos_L)
C_TEXT:C284($vsItemText)
C_BOOLEAN:C305($vbExpanded)
GET LIST ITEM:C378(aHL_ReportTemplates; Selected list items:C379(aHL_ReportTemplates); $vlItemRef; $vsItemText; $hSublist; $vbExpanded)

//$LineSelected:=Selected list items(aHL_ReportTemplates)
$LineSelected:=Find in array:C230(atQRT_ReportNames; $vsItemText)

QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=atQRT_MethodNames{$LineSelected})
If (Records in selection:C76([Templates:86])=1)
	C_TIME:C306($vhDocRef)
	
	$vhDocRef:=Create document:C266(""; "4QR")
	
	
	If (OK=1)
		CLOSE DOCUMENT:C267($vhDocRef)
		BLOB TO DOCUMENT:C526(Document; [Templates:86]Template_:3)
		If (<>PL_LPlatfrm=Windows:K25:3)
		Else 
			//_ O _SET DOCUMENT TYPE(Document;"4DSE")
		End if 
	End if 
Else 
	ALERT:C41("Error locating Quick report "+<>sQu+atReportTemplates{$LineSelected}+<>sQu+" : <"+atQRT_MethodNames{$LineSelected}+">")
End if 

