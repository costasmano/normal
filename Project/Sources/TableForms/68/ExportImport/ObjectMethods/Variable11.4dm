If (False:C215)
	//Script: ck4DFormat  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Uses the 4D Internal Export Format if checked
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

ARRAY TEXT:C222(asExpImpFld; 0)  //Command Replaced was o_ARRAY string length was 19
ARRAY POINTER:C280(apExpImp; 0)
asExpImpFld:=0
ckInclude:=0
ckLayout:=0
ckCRLF:=0
//End of script
