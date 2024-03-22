//%attributes = {"invisible":true}
//Method: Compiler_MoveRating
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/14/17, 16:32:41
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/14/17 16:39:12)
End if 
//
If (False:C215)
	C_TEXT:C284(OM_SetColoronForm; $1)
	C_TEXT:C284(ut_ReturnServerIP; $0)
	C_BOOLEAN:C305(MR_CheckandResetDocumentLock; $0)
	C_BOOLEAN:C305(MR_CheckandResetDocumentLock; $2)
	C_TEXT:C284(MR_CheckandResetDocumentLock; $1)
	
End if 
C_TEXT:C284(RatingRPTBDEPTFolder_txt; CopyFrom_txt)
ARRAY TEXT:C222(MatchedDocuments_atxt; 0)

//End Compiler_MoveRating