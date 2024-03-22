//%attributes = {"invisible":true}
//GP EZSetConjunct
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

//A conjunction has been set...

//TRACE

If (asConjunct=0)
	//Create additional array elements for a built search.
	vBuildCount:=Size of array:C274(asConjunct)+1
	ARRAY TEXT:C222(asConjunct; vBuildCount)  //Command Replaced was o_ARRAY string length was 6
	ARRAY TEXT:C222(asShowFlds; vBuildCount)  //Command Replaced was o_ARRAY string length was 19
	ARRAY POINTER:C280(apShowFlds; vBuildCount)
	ARRAY TEXT:C222(asShowTyps; vBuildCount)  //Command Replaced was o_ARRAY string length was 8
	ARRAY TEXT:C222(asShowRel; vBuildCount)  //Command Replaced was o_ARRAY string length was 24
	ARRAY TEXT:C222(asShowData; vBuildCount)
Else 
	//The user just wants to change an existing conjunction.
	//vBuildCount has already been set by the script for asConjunct.
End if 

If (vBuildCount>1)
	Case of 
		: (sbAnd=1)
			asConjunct{vBuildCount}:="And"
		: (sbOr=1)
			asConjunct{vBuildCount}:="Or"
		: (sbExcept=1)
			asConjunct{vBuildCount}:="Except"
	End case 
End if 