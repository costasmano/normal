//%attributes = {"invisible":true}
If (False:C215)
	//M_GetNonNBIS
	//Reduce current seletion to non-NBIS bridges only
	// Modified by: costasmanousakis-(Designer)-(4/4/08 16:57:31)
	Mods_2008_CM_5403  //Apply sort
End if 

QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]FHWARecord:174=False:C215)
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle