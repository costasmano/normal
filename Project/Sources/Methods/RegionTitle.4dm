//%attributes = {"invisible":true}
//GP: RegionTitle($ptrFile)
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//Fix the window title of the region
//

C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 255

$RecSel:=String:C10(Records in selection:C76(pFile->))
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")