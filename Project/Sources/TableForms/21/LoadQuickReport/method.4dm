Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		ARRAY TEXT:C222(PURPOSELIST_ATXT; 0)
		ARRAY TEXT:C222(SUBCATEGLIST_ATXT; 0)
		ARRAY TEXT:C222(EXISTITEMSLIST_ATXT; 0)
		C_BOOLEAN:C305(ADDQUICKREPORTOK_b)
		C_TEXT:C284(PURPOSE_TXT; MENUNAME_TXT; REPORTNAME_TXT; LONGDESCR_TXT; SOURCEFILE_TXT; SUBCATEGORY_TXT; TEMPLDESCR_TXT)
		READ ONLY:C145([zSpecialReports:106])
		PURPOSE_TXT:=""
		SUBCATEGORY_TXT:=""
		MENUNAME_TXT:=""
		REPORTNAME_TXT:=""
		LONGDESCR_TXT:=""
		SOURCEFILE_TXT:=""
		TEMPLDESCR_TXT:=""
		ADDQUICKREPORTOK_b:=False:C215
		QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]MethodName:3="QRT_@")
		DISTINCT VALUES:C339([zSpecialReports:106]Purpose:1; PURPOSELIST_ATXT)
		SORT ARRAY:C229(PURPOSELIST_ATXT)
		INSERT IN ARRAY:C227(PURPOSELIST_ATXT; 1; 1)
		PURPOSELIST_ATXT{1}:="NEWPURPOSE"
		POPUPMENUC(->PURPOSELIST_ATXT; ->PURPOSELIST_ATXT; ->PURPOSE_TXT)
		OBJECT SET ENABLED:C1123(*; "BAddQuickReport@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "SUBCATE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "SOURCEFILEbtn@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "PURPOSE_TXT"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "SUBCATEGORY_TXT"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "MENUNAME_TXT"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "REPORTNAME_TXT"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "LONGDESCR_TXT"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "TEMPLDESCR_TXT"; False:C215)
		
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
		QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1=PURPOSE_TXT; *)
		QUERY:C277([zSpecialReports:106];  & ; [zSpecialReports:106]SubCategory:5=SUBCATEGORY_TXT; *)
		QUERY:C277([zSpecialReports:106];  & ; [zSpecialReports:106]ReportName:2=MENUNAME_TXT)
		If (Records in selection:C76([zSpecialReports:106])>0)
			ALERT:C41("There is another item in "+PURPOSE_TXT+"-"+SUBCATEGORY_TXT+" with the name "+MENUNAME_TXT)
			MENUNAME_TXT:=""
		End if 
		If (REPORTNAME_TXT#"")
			If (REPORTNAME_TXT="QRT_@")
				QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=REPORTNAME_TXT)
				If (Records in selection:C76([Templates:86])>0)
					ALERT:C41("There is another quick report store in the DB with the name "+REPORTNAME_TXT)
					REPORTNAME_TXT:=""
				End if 
			Else 
				ALERT:C41("Quick reports must be named QRT_@")
			End if 
		End if 
		
		ADDQUICKREPORTOK_b:=((MENUNAME_TXT#"") & (REPORTNAME_TXT="QRT_@") & (Test path name:C476(SOURCEFILE_TXT)=Is a document:K24:1))
		If (ADDQUICKREPORTOK_b)
			OBJECT SET ENABLED:C1123(*; "BAddQuickReport"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
End case 
