//SC aFileNames on layout [zDialogs];"EasySearch".
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

//Pop up menu for File Names.

C_LONGINT:C283(vBuildCount)
C_LONGINT:C283(vSearchType)  //Command Replaced was o_C_INTEGER

//TRACE

REDRAW:C174(aFileNames)

If (Form event code:C388=On Load:K2:1)
	vEntryData:=""
	aFileNames:=Table:C252(pFile)
	vBuildCount:=1
	If (pFile#pFileOld)
		//New file, clear the arrays.    
		ARRAY TEXT:C222(asConjunct; 0)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222(asShowFlds; 0)  //Command Replaced was o_ARRAY string length was 19
		ARRAY POINTER:C280(apShowFlds; 0)
		ARRAY TEXT:C222(asShowTyps; 0)  //Command Replaced was o_ARRAY string length was 8
		ARRAY TEXT:C222(asShowRel; 0)  //Command Replaced was o_ARRAY string length was 24
		ARRAY TEXT:C222(asShowData; 0)
		ARRAY TEXT:C222(asConjunct; 1)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222(asShowFlds; 1)  //Command Replaced was o_ARRAY string length was 19
		ARRAY POINTER:C280(apShowFlds; 1)
		ARRAY TEXT:C222(asShowTyps; 1)  //Command Replaced was o_ARRAY string length was 8
		ARRAY TEXT:C222(asShowRel; 1)  //Command Replaced was o_ARRAY string length was 24
		ARRAY TEXT:C222(asShowData; 1)
		vSearchType:=1  //Search in selection is the default.
	End if 
	Case of 
		: (vSearchType=1)
			//Search in selection.      
			ckWithin:=1
			ckAddTo:=0
		: (vSearchType=2)
			//Add to current selection by searching the original selection of this process.
			ckWithin:=0
			ckAddTo:=1
		Else 
			//Search the original selection of this process.
			ckWithin:=0
			ckAddTo:=0
	End case 
End if 

Case of 
	: (aFileNames=1)
		COPY ARRAY:C226(<>asFields; asFields)
		COPY ARRAY:C226(<>apFlds; apFlds)
		COPY ARRAY:C226(<>asFldTypes; asFldTypes)
	: (aFileNames>1)
		//Declare the array to store the field names
		ARRAY TEXT:C222(asFields; 0)  //Command Replaced was o_ARRAY string length was 19
		//Declare the array to store pointers to the fields
		ARRAY POINTER:C280(apFlds; 0)
		//Declare the array to store the field types
		ARRAY TEXT:C222(asFldTypes; 0)  //Command Replaced was o_ARRAY string length was 8
		FieldsToArray(apFiles{aFileNames}; ->asFields; ->apFlds; False:C215; False:C215; ->asFldTypes)
		SORT ARRAY:C229(asFields; apFlds; asFldTypes)
End case 

EZSrchActivate(1)