If (False:C215)
	//OM CulvertTabCtrl
	//Created 5/31/04
	//AL
	//We have to keep the current record of [Combined Inspections]
	//current on this form.
	Mods_2005_CM06
End if 

If (False:C215)
	//USE NAMED SELECTION("curCombinedInspection")
	//RELATE ONE([Combined Inspections])
	//DISPL_CUs 
	//LOAD RECORD([Combined Inspections])
Else 
	RememberCombined
End if 