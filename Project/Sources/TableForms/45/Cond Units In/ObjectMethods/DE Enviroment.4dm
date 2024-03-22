//SC [Cond Units]Environment on layout [Cond Units];"Cond Units In".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

REDRAW:C174(aEnv)
aEnv:=[Cond Units:45]Environment:4
aEnv{0}:=String:C10(aEnv)  //Save this choice as the new default.

If (Form event code:C388=On Data Change:K2:15) & ([Cond Units:45]Environment:4#Old:C35([Cond Units:45]Environment:4))
	PushChange(2; ->[Cond Units:45]Environment:4)
End if 