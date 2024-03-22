//%attributes = {"invisible":true}
If (False:C215)
	//M_GetNonNBISBr
	//reduce selection to NBIS bridges that fulfill the criteria
	// Modified by: costasmanousakis-(Designer)-(4/4/08 17:00:33)
	Mods_2008_CM_5403  //Apply sort
End if 

QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; bNBISBridge([Bridge MHD NBIS:1]Item5:59; [Bridge MHD NBIS:1]Item49:93; [Bridge MHD NBIS:1]Item42:85)=False:C215)
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle