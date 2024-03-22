
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/18/14, 14:56:33
// ----------------------------------------------------
// Method: Object Method: [LSS_Inspection].Input_Signal.DMeterButton_L
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2020_09  //Make changes so that UT and d-meter pictures Added and modified using the [LSS_Photos];"Input" form
	//Modified by: CJ (9/3/20 15:39:44)
	//Replaced the following
	//ut_LSSControlPictureMod ("Sketch D Meter";"Image";->LSS_DMeterPicture_pct)
End if 

v_166_003_txt:="Sketch D Meter"

LSS_ControlUTDmeterSketches

BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_UTPicture_pct)
LSS_PhotoDescription_txt:=[LSS_Photos:166]LSS_Photo_txt:4
If (Records in selection:C76([LSS_Photos:166])=1)
	OBJECT SET VISIBLE:C603(*; "NODMeterPict"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "NODMeterPict"; True:C214)
End if 
UNLOAD RECORD:C212([LSS_Photos:166])



