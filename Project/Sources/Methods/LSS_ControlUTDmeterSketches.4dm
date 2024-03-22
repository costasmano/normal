//%attributes = {"invisible":true}
//Method: LSS_ControlUTDmeterSketches
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/03/20, 13:15:36
	// ----------------------------------------------------
	//Created : 
	Mods_2020_09  //Make changes so that UT and d-meter pictures Added and modified using the [LSS_Photos];"Input" form
	//Modified by: CJ (9/3/20 15:39:44)
	
End if 
//
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_PhotoType_s:3=v_166_003_txt)

Case of 
	: (Records in selection:C76([LSS_Photos:166])=1)  //we are modifying
		LSS_ControlModification(->[LSS_Photos:166]; "Input")
		
		READ ONLY:C145([LSS_Photos:166])
	: (Records in selection:C76([LSS_Photos:166])>1)  //we are modifying
		ALERT:C41("Please notify admin as there is more than one "+v_166_003_txt+" record")
		
	Else   // we are adding
		LSS_CreatePhotoRecord
		
End case 
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_PhotoType_s:3=v_166_003_txt)


If (v_166_003_txt="Sketch D Meter")
	If (Records in selection:C76([LSS_Photos:166])=1)
		OBJECT SET VISIBLE:C603(*; "NODMeterPict"; False:C215)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_1"; True:C214)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_2"; True:C214)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_3"; True:C214)
		OBJECT SET TITLE:C194(*; "DMeterButton_L"; "Modify D Meter Sketch")
	Else 
		OBJECT SET VISIBLE:C603(*; "NODMeterPict"; True:C214)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_1"; False:C215)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_2"; False:C215)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_3"; False:C215)
		OBJECT SET TITLE:C194(*; "DMeterButton_L"; "Add D Meter Sketch")
	End if 
Else 
	If (Records in selection:C76([LSS_Photos:166])=1)
		OBJECT SET VISIBLE:C603(*; "NOUTPict"; False:C215)
		OBJECT SET VISIBLE:C603(*; "UTInput_1"; True:C214)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_5"; True:C214)
		OBJECT SET VISIBLE:C603(*; "UT_SketchComents"; True:C214)
		OBJECT SET TITLE:C194(*; "UTButton_L"; "Modify UT Sketch")
	Else 
		OBJECT SET VISIBLE:C603(*; "NOUTPict"; True:C214)
		OBJECT SET VISIBLE:C603(*; "UTInput_1"; False:C215)
		OBJECT SET VISIBLE:C603(*; "DMeterInput_5"; False:C215)
		OBJECT SET VISIBLE:C603(*; "UT_SketchComents"; False:C215)
		OBJECT SET TITLE:C194(*; "UTButton_L"; "Add UT Sketch")
		
	End if 
	
	
	
	
End if 
v_166_003_txt:=""
//End LSS_ControlUTDmeterSketches