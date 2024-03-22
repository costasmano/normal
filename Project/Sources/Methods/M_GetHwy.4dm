//%attributes = {"invisible":true}
If (False:C215)
	//M_GetHwy
	//Reduce current seletion to highway structures only
	// Modified by: costasmanousakis-(Designer)-(4/4/08 17:00:33)
	Mods_2008_CM_5403  //Apply sort
End if 

//QUERY SELECTION(pFile->;[Bridge MHD NBIS]Bridge Key#"DUM@";*)  `x
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DRE@";*)  `x
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"CLO@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"BLD@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DNA@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DNB@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"UTL@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"PED@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"RRO@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"WRA@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"TEP@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"TER@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"TET@";*)
//QUERY SELECTION(pFile->; & [Bridge MHD NBIS]Bridge Key#"DES@")  `x

QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DUM@"; *)  //x
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"REM@"; *)  //x
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BKY@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLO@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"CLP@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BLD@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"UTL@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"PED@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"RRO@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"WRA@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"TRO@"; *)
QUERY SELECTION:C341(pFile->;  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES@")  //x
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 

RegionTitle