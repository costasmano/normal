//%attributes = {"invisible":true}
If (False:C215)
	//M_GetOffSystem
	//reduce selection to bridges that are off system
	// Modified by: costasmanousakis-(Designer)-(4/4/08 16:59:23)
	Mods_2008_CM_5403  //apply sort
End if 

QUERY SELECTION BY FORMULA:C207([Bridge MHD NBIS:1]; bOffSystem([Bridge MHD NBIS:1]Item26:120)=True:C214)
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle