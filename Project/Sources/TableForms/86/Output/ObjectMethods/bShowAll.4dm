If (False:C215)
	//Object Method: bShowAll 
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 16:04:53)
	Mods_2007_CM07
End if 

ALL RECORDS:C47(Current form table:C627->)
ORDER BY:C49([Templates:86]; [Templates:86]TemplateName:2)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76(Current form table:C627->))
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
