If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/21/2007 12:48:10)
	Mods_2007_CM12_5301
End if 
CREATE SET:C116(Current form table:C627->; "TMP_PREADDSET")
C_BOOLEAN:C305(ZRPTS_COPYRECORD_B)
C_TEXT:C284(ZRPTS_Category_txt; ZRPTS_Reportname_txt; ZRPTS_SubCategory_txt; ZRPTS_MethodName_txt; ZRPTS_Descr_txt)
ZRPTS_COPYRECORD_B:=False:C215
If (Shift down:C543)
	If (Records in set:C195("USERSET")>0)
		USE SET:C118("USERSET")
		FIRST RECORD:C50([zSpecialReports:106])
		ZRPTS_Category_txt:=[zSpecialReports:106]Purpose:1
		ZRPTS_Reportname_txt:=[zSpecialReports:106]ReportName:2
		ZRPTS_SubCategory_txt:=[zSpecialReports:106]SubCategory:5
		ZRPTS_MethodName_txt:=[zSpecialReports:106]MethodName:3
		ZRPTS_Descr_txt:=[zSpecialReports:106]LongDescription:4
		CONFIRM:C162("Making a copy of Report/Menu"+<>sCR+"Purpose : <"+ZRPTS_Category_txt+">"+<>sCR+"Report name : <"+ZRPTS_Reportname_txt+">"+<>sCR+"Proceed?")
		If (OK=1)
			ZRPTS_COPYRECORD_B:=True:C214
		End if 
		
	End if 
	
End if 

ADD RECORD:C56(Current form table:C627->)
ADD TO SET:C119(Current form table:C627->; "TMP_PREADDSET")
USE SET:C118("TMP_PREADDSET")
CLEAR SET:C117("TMP_PREADDSET")
ORDER BY:C49([zSpecialReports:106]; [zSpecialReports:106]Purpose:1; >; [zSpecialReports:106]SubCategory:5; >; [zSpecialReports:106]ReportName:2; >)
ZRPTS_COPYRECORD_B:=False:C215
ZRPTS_Category_txt:=""
ZRPTS_Reportname_txt:=""
ZRPTS_SubCategory_txt:=""
ZRPTS_MethodName_txt:=""
ZRPTS_Descr_txt:=""