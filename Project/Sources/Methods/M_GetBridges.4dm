//%attributes = {"invisible":true}
If (False:C215)
	//M_GetBridges
	//Reduce current seletion to just bridge records
	// Modified by: costasmanousakis-(Designer)-(4/4/08 17:00:33)
	Mods_2008_CM_5403  //Apply sort
End if 

//QUERY SELECTION(pFile->;[Bridge MHD NBIS]Bridge Key#"DUM@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DRE@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"CLO@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DNA@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DNB@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"UTL@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"BLD@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"WRA@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DES@")

QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DUM"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLO"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BKY"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"UTL"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BLD"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES")
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle