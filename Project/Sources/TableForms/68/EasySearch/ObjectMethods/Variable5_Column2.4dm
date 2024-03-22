//SC asConjunct on layout [zDialogs];"EasySearch".
//Copyright © 1998, Thomas D. Nee, All Rights Reserved.

If (asConjunct=1)
	//No conjunction allowed on the first line.  
	asConjunct:=0
Else 
	vBuildCount:=asConjunct
	EZSrchActivate(0)
End if 