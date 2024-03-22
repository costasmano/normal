If (False:C215)
	//Script: bCopyall  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Copys all fields to export fields array.
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

COPY ARRAY:C226(asFields; asExpImpFld)
COPY ARRAY:C226(apFlds; apExpImp)
OBJECT SET ENABLED:C1123(bExport; True:C214)  // Command Replaced was o_ENABLE BUTTON 
asExpImpFld:=1
//End of script
