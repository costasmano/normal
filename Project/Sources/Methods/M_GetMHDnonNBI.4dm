//%attributes = {"invisible":true}
If (False:C215)
	//M_GetMHDnonNBI 
	//Reduce selection to MHD nonNBI bridges only
	// Modified by: costasmanousakis-(Designer)-(4/4/08 16:58:31)
	Mods_2008_CM_5403  //apply sort
	// Modified by: costasmanousakis-(Designer)-(11/1/09 11:49:03)
	Mods_2009_10("MASSDOT")
	//  `Use the new DOT designation 
End if 
QUERY SELECTION:C341(pfile->; [Bridge MHD NBIS:1]FHWARecord:174=False:C215; *)
QUERY SELECTION:C341(pfile->;  & ; [Bridge MHD NBIS:1]Item8 Owner:208="DOT")
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle