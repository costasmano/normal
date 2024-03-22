//%attributes = {"invisible":true}
If (False:C215)
	//M_GetSD
	//reduce selection to bridges that are SD
	// Modified by: costasmanousakis-(Designer)-(4/4/08 16:59:52)
	Mods_2008_CM_5403  //apply sort
End if 

ALERT:C41("The bridges in this list may not have up to date information!")
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=True:C214)
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle