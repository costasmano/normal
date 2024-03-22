If (False:C215)
	//Script: bReturn  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	//Modified by Tom Nee 2/19/98
	
	//Purpose: 9 Posts a Tab key
	//              3 Posts an Enter key
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

//TRACE

Case of 
	: (vStage=1)
		//Take the current field.    
		EZSetField
	: (vStage=2)
		//Take the current relation.
		EZSetRelation
		EZSrchActivate(3)
	: (vStage=3)
		//Post tab to complete data entry. 
		//This will only happen if the user does not change the entry data. 
		//Otherwise, the script for vEntryData sets vStage to zero.
		// PostKey (9;0)
		// Code changes made 6\6\00
		POST KEY:C465(9; 0)  //changed code to work with 4D v6
		EZCloseEntryDat
	: (vStage=0)
		//Take the current conjunction.
		//    EZSetConjunct 
		//    EZSrchActivate (1)
End case 
//End of script
