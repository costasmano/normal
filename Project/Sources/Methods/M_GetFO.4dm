//%attributes = {"invisible":true}
If (False:C215)
	//M_GetFO
	//reduce selection to bridges that are FO
	// Modified by: costasmanousakis-(Designer)-(4/4/08 17:00:33)
	Mods_2008_CM_5403  //Apply sort
End if 

ALERT:C41("The bridges in this list may not have up to date information!")
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FunctObs:106=True:C214)
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle