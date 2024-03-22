//%attributes = {"invisible":true}
If (False:C215)
	//M_GetMHD_NBI 
	//Reduce selection to MHD NBI bridges only
	// Modified by: costasmanousakis-(Designer)-(4/4/08 16:58:04)
	Mods_2008_CM_5403  //Apply sort
	// Modified by: costasmanousakis-(Designer)-(11/1/09 11:48:17)
	Mods_2009_10("MASSDOT")
	//  `Use the new DOT designation 
End if 
QUERY SELECTION:C341(pfile->; [Bridge MHD NBIS:1]FHWARecord:174=True:C214; *)
QUERY SELECTION:C341(pfile->;  & ; [Bridge MHD NBIS:1]Item8 Owner:208="DOT")
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 

RegionTitle