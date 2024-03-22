//%attributes = {"invisible":true}
If (False:C215)
	//procedure: CheckSpelling
	//by: Albert Leung
	//created: 2/13/96
	//purpose: Uses Forsight Technologies SpellsWell to correct spelling  
	//
	// modified 25-oct-2000 : CM
	//  removed call to SpellsWell since we cannot get new version for Mac and PC
End if 

C_POINTER:C301($1)
//C_TEXT(vText)  `This has to be a process or interprocess variable to work!
//C_INTEGER($result)

//vText:=$1->

//$result:=SW_SpellCheck(vText;1;0)
//$1->:=vText