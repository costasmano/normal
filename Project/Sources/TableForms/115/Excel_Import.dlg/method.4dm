// ----------------------------------------------------
// Form Method: Excel_Import.dlg
// User name (OS): cjmiller
// Date and time: 11/09/06, 11:59:23
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(ExcelDisplay_txt)
	ExcelDisplay_txt:="This process will import from an excel spreadsheet and create new project and rel"+"ated records."
	
	ExcelDisplay_txt:=ExcelDisplay_txt+Char:C90(Carriage return:K15:38)+"[PRJ_ProjectDetails] "+String:C10(Records in table:C83([PRJ_ProjectDetails:115]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_ReportData] "+String:C10(Records in table:C83([PRJ_ReportData:118]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_TypeStudy] "+String:C10(Records in table:C83([PRJ_TypeStudy:121]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_SketchPlans] "+String:C10(Records in table:C83([PRJ_SketchPlans:120]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_StructuralReview] "+String:C10(Records in table:C83([PRJ_StructuralReview:119]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_ProjectDetailsIncludedBINS] "+String:C10(Records in table:C83([PRJ_ProjectDetailsIncludedBINS:122]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_ProjectTimeTracking] "+String:C10(Records in table:C83([PRJ_ProjectTimeTracking:124]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_ConstructionProject] "+String:C10(Records in table:C83([PRJ_ConstructionProject:116]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_Contractor] "+String:C10(Records in table:C83([PRJ_Contractor:114]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_DesignContracts] "+String:C10(Records in table:C83([PRJ_DesignContracts:123]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt+"[PRJ_ProjectFile] "+String:C10(Records in table:C83([PRJ_ProjectFile:117]))+Char:C90(Carriage return:K15:38)
	
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="Program")
	ExcelDisplay_txt:=ExcelDisplay_txt+"Program "+String:C10(Records in selection:C76([TableOfLists:125]))+Char:C90(Carriage return:K15:38)
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="FederalAid")
	ExcelDisplay_txt:=ExcelDisplay_txt+"Federal Aid "+String:C10(Records in selection:C76([TableOfLists:125]))+Char:C90(Carriage return:K15:38)
	ExcelDisplay_txt:=ExcelDisplay_txt
	
	
	
End if 
//End Form Method: Excel_Import.dlg