If (False:C215)
	//Script: bDelete
	//Created By: Tom Nee
	//Date:  2/6/98
End if 

C_LONGINT:C283($NumElems)  //Command Replaced was o_C_INTEGER

//TRACE

$NumElems:=Size of array:C274(asConjunct)
//Don't delete if there is only one element.
If ($NumElems>1)
	DELETE FROM ARRAY:C228(asConjunct; vBuildCount)
	If (vBuildCount=1)
		asConjunct{1}:=""
	End if 
	DELETE FROM ARRAY:C228(asShowFlds; vBuildCount)
	DELETE FROM ARRAY:C228(apShowFlds; vBuildCount)
	DELETE FROM ARRAY:C228(asShowTyps; vBuildCount)
	DELETE FROM ARRAY:C228(asShowRel; vBuildCount)
	DELETE FROM ARRAY:C228(asShowData; vBuildCount)
	If (vBuildCount=$NumElems)
		vBuildCount:=vBuildCount-1
	End if 
	EZSrchActivate(1)
End if 
//End of script


