If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/30/06, 09:47:34
	// ----------------------------------------------------
	// Method: Form Method: [zSpecialReports]Input
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/17/2007 10:27:56)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(8/21/2007 14:25:07)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(5/19/09 09:18:09)
	Mods_2009_05
	//Push the changes on COPYRECORD
	// Modified by: Costas Manousakis-(Designer)-(11/4/13 10:52:46)
	Mods_2013_11
	//  `made size of fields bigger
	// Modified by: Costas Manousakis-(Designer)-(2/12/14 17:24:57)
	Mods_2014_02_bug
	//  `added var ZSPRPT_NewRecord_b to keep track of new record
	// Modified by: Costas Manousakis-(Designer)-(6/5/19 17:09:54)
	Mods_2019_06
	//  `changed appearance of Delete button; made description to grow horiz too.
	// Modified by: Costas Manousakis-(Designer)-(2022-12-28 18:01:30)
	Mods_2022_12_bug
	//  `allowed all other fields to grow horizontal.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		C_BOOLEAN:C305(ZSPRPT_LogActivity_b; ZRPTS_COPYRECORD_B; ZSPRPT_NewRecord_b)
		ZSPRPT_LogActivity_b:=True:C214
		ZSPRPT_NewRecord_b:=False:C215
		InitChangeStack(1)
		If ((Is new record:C668(Current form table:C627->)) | ([zSpecialReports:106]Record_ID:7=0))
			Inc_Sequence("SpecialRptsTbl"; ->[zSpecialReports:106]Record_ID:7)
			ZSPRPT_NewRecord_b:=True:C214
			If (ZRPTS_COPYRECORD_B)
				[zSpecialReports:106]Purpose:1:=ZRPTS_Category_txt
				[zSpecialReports:106]ReportName:2:=ZRPTS_Reportname_txt
				[zSpecialReports:106]SubCategory:5:=ZRPTS_SubCategory_txt
				[zSpecialReports:106]MethodName:3:=ZRPTS_MethodName_txt
				[zSpecialReports:106]LongDescription:4:=ZRPTS_Descr_txt
				PushChange(1; ->[zSpecialReports:106]Purpose:1)
				PushChange(1; ->[zSpecialReports:106]ReportName:2)
				PushChange(1; ->[zSpecialReports:106]SubCategory:5)
				PushChange(1; ->[zSpecialReports:106]MethodName:3)
				PushChange(1; ->[zSpecialReports:106]LongDescription:4)
				
				ZRPTS_COPYRECORD_B:=False:C215
			End if 
			
		Else 
			
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		If (ZSPRPT_LogActivity_b)
			If (ZSPRPT_NewRecord_b)
				LogNewRecord(->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; 0; "SpecialRptsTbl")
			End if 
			FlushGrpChgs(1; ->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; 0)
		End if 
End case 