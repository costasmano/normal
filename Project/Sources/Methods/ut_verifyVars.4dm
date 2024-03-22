//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/26/12, 10:46:20
// ----------------------------------------------------
//Method: ut_verifyVars
//Description
//  ` Verify existance of variables in POA forms
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	//Run through all forms
	READ ONLY:C145(*)
	ALL RECORDS:C47([ScourPOA:132])
	FIRST RECORD:C50([ScourPOA:132])
	//get the save to blob file
	C_TIME:C306($DocRef_t)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	
	ALERT:C41("open file with Var to blob cmds")
	$DocRef_t:=Open document:C264("")
	C_BLOB:C604($SaveVars_blb)
	C_TEXT:C284(TTTTSaveVars_txt; TTTTInpVars_txt)
	C_TEXT:C284(TTTTFileName_txt)
	TTTTFileName_txt:=""
	TTTTInpVars_txt:=""
	TTTTSaveVars_txt:=""
	C_BOOLEAN:C305(TTTTDOVARSCAN_B)  // used by ut_getFormVariables whether to run or not
	TTTTDOVARSCAN_B:=True:C214
	If (OK=1)
		TTTTFileName_txt:=Document
		DOCUMENT TO BLOB:C525(Document; $SaveVars_blb)
		CLOSE DOCUMENT:C267($DocRef_t)
		TTTTSaveVars_txt:=BLOB to text:C555($SaveVars_blb; Mac text without length:K22:10)
	End if 
	FORM SET OUTPUT:C54([ScourPOA:132]; "Input-a")
	PRINT RECORD:C71([ScourPOA:132])
	//get the input form variables
	$DocRef_t:=Open document:C264(TTTTFileName_txt+"_ObjNames")
	
	If (Ok=1)
		DOCUMENT TO BLOB:C525(Document; $SaveVars_blb)
		CLOSE DOCUMENT:C267($DocRef_t)
		TTTTInpVars_txt:=BLOB to text:C555($SaveVars_blb; Mac text without length:K22:10)
		SET BLOB SIZE:C606($SaveVars_blb; 0)
	End if 
	
	SET PRINT PREVIEW:C364(True:C214)
	FORM SET OUTPUT:C54([ScourPOA:132]; "Print1-A")
	PRINT RECORD:C71([ScourPOA:132]; >)
	
	FORM SET OUTPUT:C54([ScourPOA:132]; "Print2-A")
	PRINT RECORD:C71([ScourPOA:132]; >)
	
	FORM SET OUTPUT:C54([ScourPOA:132]; "Print3-A")
	PRINT RECORD:C71([ScourPOA:132]; >)
	
	FORM SET OUTPUT:C54([ScourPOA:132]; "Print4-A")
	PRINT RECORD:C71([ScourPOA:132]; >)
	
	FORM SET OUTPUT:C54([ScourPOA:132]; "Print5-A")
	PRINT RECORD:C71([ScourPOA:132]; >)
	
	FORM SET OUTPUT:C54([ScourPOA:132]; "Print6-A")
	PRINT RECORD:C71([ScourPOA:132]; >)
	
	FORM SET OUTPUT:C54([ScourPOA:132]; "Summary-A")
	PRINT RECORD:C71([ScourPOA:132]; >)
	
	TTTTDOVARSCAN_B:=False:C215
End if 


//End Temp_verifyVarsHOW about nothing blank!!!