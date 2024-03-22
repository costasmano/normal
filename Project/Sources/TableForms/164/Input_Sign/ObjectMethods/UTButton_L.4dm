//Method: [LSS_Inspection].Input_Sign.UTButton_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/03/20, 15:47:29
	// ----------------------------------------------------
	//Created : 
	
	Mods_2020_09  //Make changes so that UT and d-meter pictures Added and modified using the [LSS_Photos];"Input" form
	//Modified by: CJ (9/3/20 15:39:44)
	//ut_LSSControlPictureMod ("Sketch UT";"Image";->LSS_DMeterPicture_pct)
	//above was old method
End if 
v_166_003_txt:="Sketch UT"

LSS_ControlUTDmeterSketches

BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_UTPicture_pct)
LSS_PhotoDescription_txt:=[LSS_Photos:166]LSS_Photo_txt:4
If (Records in selection:C76([LSS_Photos:166])=1)
	OBJECT SET VISIBLE:C603(*; "NOUTPict"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "NOUTPict"; True:C214)
End if 
UNLOAD RECORD:C212([LSS_Photos:166])

//End [LSS_Inspection].Input_Sign.UTButton_L