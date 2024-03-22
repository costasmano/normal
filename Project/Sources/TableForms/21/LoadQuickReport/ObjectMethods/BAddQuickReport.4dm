//ALERT("Hello!")
C_TEXT:C284($Msg_txt)
QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1=PURPOSE_TXT; *)
QUERY:C277([zSpecialReports:106];  & ; [zSpecialReports:106]SubCategory:5=SUBCATEGORY_TXT; *)
QUERY:C277([zSpecialReports:106];  & ; [zSpecialReports:106]ReportName:2=MENUNAME_TXT; *)
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=REPORTNAME_TXT)
CREATE RECORD:C68([zSpecialReports:106])
Inc_Sequence("SpecialRptsTbl"; ->[zSpecialReports:106]Record_ID:7)
[zSpecialReports:106]CreatedBy:6:=Current user:C182
[zSpecialReports:106]LongDescription:4:=LONGDESCR_TXT
[zSpecialReports:106]MethodName:3:=REPORTNAME_TXT
[zSpecialReports:106]Purpose:1:=PURPOSE_TXT
[zSpecialReports:106]ReportName:2:=MENUNAME_TXT
[zSpecialReports:106]SubCategory:5:=SUBCATEGORY_TXT
SAVE RECORD:C53([zSpecialReports:106])
LogNewRecord(->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; 0; "SpecialRptsTbl")
InitChangeStack(1)
PushChange(1; ->[zSpecialReports:106]CreatedBy:6)
PushChange(1; ->[zSpecialReports:106]LongDescription:4)
PushChange(1; ->[zSpecialReports:106]MethodName:3)
PushChange(1; ->[zSpecialReports:106]Purpose:1)
PushChange(1; ->[zSpecialReports:106]ReportName:2)
PushChange(1; ->[zSpecialReports:106]SubCategory:5)
FlushGrpChgs(1; ->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; ->[zSpecialReports:106]Record_ID:7; 0)
CREATE RECORD:C68([Templates:86])
Inc_Sequence("TemplateInc"; ->[Templates:86]TemplateID:1)
[Templates:86]TemplateName:2:=REPORTNAME_TXT
DOCUMENT TO BLOB:C525(SOURCEFILE_TXT; [Templates:86]Template_:3)
[Templates:86]TemplateDesc:4:=TEMPLDESCR_TXT
SAVE RECORD:C53([Templates:86])
InitChangeStack(1)
LogNewRecord(->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; 0; "TemplateInc")
PushChange(1; ->[Templates:86]TemplateName:2)
PushChange(1; ->[Templates:86]Template_:3)
FlushGrpChgs(1; ->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; 0)

//blank everything
PURPOSE_TXT:=""
SUBCATEGORY_TXT:=""
MENUNAME_TXT:=""
REPORTNAME_TXT:=""
LONGDESCR_TXT:=""
SOURCEFILE_TXT:=""
TEMPLDESCR_TXT:=""