//%attributes = {"invisible":true}
//Method: LSS_GetImages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/15, 13:55:20
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
	Mods_2015_07_bug  // fix bug where [LSS_Photos]LSS_PhotoType_s when savedas blank does not display
	//Modified by: administrator (8/6/15 13:08:19)
	// Modified by: Costas Manousakis-(Designer)-(7/6/20 18:08:04)
	Mods_2020_07_bug
	//  `Set Auto relations to false before sorting - 
	//  `[inventory] record was getting 'lost' from the order by formula when in the Review screen
	//  `Call Reference #723
	
End if 
SET QUERY DESTINATION:C396(Into set:K19:2; "INSPhotoSet")
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
USE SET:C118("INSPhotoSet")
SET QUERY DESTINATION:C396(Into set:K19:2; "INSSkorDMSet")

QUERY SELECTION:C341([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch UT"; *)
QUERY SELECTION:C341([LSS_Photos:166];  | ; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch D Meter")

SET QUERY DESTINATION:C396(Into current selection:K19:1)
DIFFERENCE:C122("INSPhotoSet"; "INSSkorDMSet"; "INSPhotoSet")
USE SET:C118("INSPhotoSet")
CLEAR SET:C117("INSSkorDMSet")
CLEAR SET:C117("INSPhotoSet")

If (Type:C295(LSS_PhotoTypes_atxt)=Is undefined:K8:13)
	ARRAY TEXT:C222(LSS_PhotoTypes_atxt; 0)
End if 
If (Size of array:C274(LSS_PhotoTypes_atxt)=0)
	ARRAY TEXT:C222(LSS_PhotoTypes_atxt; 4)
	LSS_PhotoTypes_atxt{1}:=""
	LSS_PhotoTypes_atxt{2}:="Sketch"
	LSS_PhotoTypes_atxt{3}:="Chart"
	LSS_PhotoTypes_atxt{4}:="Photo"
End if 

C_BOOLEAN:C305($AutoOne_b; $AutoMany_b)
GET AUTOMATIC RELATIONS:C899($AutoOne_b; $AutoMany_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
ORDER BY FORMULA:C300([LSS_Photos:166]; Find in array:C230(LSS_PhotoTypes_atxt; [LSS_Photos:166]LSS_PhotoType_s:3); >; [LSS_Photos:166]LSS_PhotoSequence_L:6; >)
SET AUTOMATIC RELATIONS:C310($AutoOne_b; $AutoMany_b)
//End LSS_GetImages