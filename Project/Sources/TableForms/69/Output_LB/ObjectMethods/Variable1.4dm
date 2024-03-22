If (False:C215)
	//Script: bzAdd
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

GenerateCondRep(False:C215)  //don't use custom bridge selection

MODIFY RECORD:C57([Status Report:69])

ALL RECORDS:C47([Status Report:69])
ORDER BY:C49([Status Report:69]; [Status Report:69]Date_Created:1; <; [Status Report:69]Time_Created:134; <)
WindowTitle
//End of procedure