If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 11/22/05, 11:07:13
	// ----------------------------------------------------
	// Method: Form Method: ReportTemplateSelect
	// Description
	// 
	//
	// Parameters
	//
	//
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/7/2006 12:08:54)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/27/2007 09:51:54)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(5/21/2007 10:45:41)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(9/24/08 21:13:01)
	Mods_2008_CM_5404  // ("HLISTSELECT")
	//  `Use new method TMPL_HListOnSelect to act on the selected item
	// Modified by: costasmanousakis-(Designer)-(12/23/10 09:58:06)
	Mods_2010_12
	//  `Save the selected item no in a process variable
	// Modified by: costasmanousakis-(Designer)-(5/13/11 16:38:47)
	Mods_2011_05
	//declared and initialize the pull down for RptDestination
	// Modified by: costasmanousakis-(Designer)-(10/5/11 17:21:19)
	Mods_2011_10
	//check if aHL_ReportTemplates is a list
	// Modified by: Costas Manousakis-(Designer)-(2022-06-08 14:56:43)
	Mods_2022_06
	//  `changed Destination list to show Excel instead of 4D View and replace 4D chart with "-"
End if 

If (Form event code:C388=On Load:K2:1)
	OBJECT SET VISIBLE:C603(*; "Rpt@"; False:C215)
	C_TEXT:C284(vSelectionDescription; vsReportTemplateTitle; vsReportTemplateOKBtn)
	C_LONGINT:C283(TMPL_HLSelectedItem_L)
	
	//````Mods_2010_12 
	//  `Save the selected item no in a process variable
	C_LONGINT:C283(vReportTemplPictID_i)  //Command Replaced was o_C_INTEGER
	If (vReportTemplPictID_i>0)
		OBJECT SET FORMAT:C236(*; "PictureButton_v"; "1;4;?"+String:C10(vReportTemplPictID_i)+";96;0")
	End if 
	If (vsReportTemplateOKBtn#"")
		OBJECT SET TITLE:C194(*; "OKButton"; vsReportTemplateOKBtn)
	End if 
	vSelectionDescription:=""
	ARRAY TEXT:C222(RptDestination; 0)
	APPEND TO ARRAY:C911(RptDestination; "Print")
	APPEND TO ARRAY:C911(RptDestination; "Disk File")
	APPEND TO ARRAY:C911(RptDestination; "Excel")
	APPEND TO ARRAY:C911(RptDestination; "-")
	APPEND TO ARRAY:C911(RptDestination; "HTML File")
	RptDestination:=0
	If (Is a list:C621(aHL_ReportTemplates))
		SELECT LIST ITEMS BY POSITION:C381(aHL_ReportTemplates; 1)
	End if 
	
	C_LONGINT:C283($ItemPos)
	$ItemPos:=TMPL_HListOnSelect
	If ($ItemPos>0)
		TMPL_HList_OM($ItemPos)
	End if 
	
End if 
//End of method