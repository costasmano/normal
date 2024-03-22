//%attributes = {"invisible":true}
If (False:C215)
	
	If (False:C215)
		//add_change_del code 
		// Modified by: Costas Manousakis-(Designer)-(9/17/15 15:05:35)
		Mods_2015_09_bug
		//  `placed code in IF FALSE
	End if 
	
	//  `placed in  IF False
	READ WRITE:C146([Standard Photos:36])
	QUERY:C277([Standard Photos:36]; [Standard Photos:36]StdPhotoID:7=564640)
	APPLY TO SELECTION:C70([Standard Photos:36]; [Standard Photos:36]maximo_UpdateTimeStamp_s:9:="")
	READ ONLY:C145([Standard Photos:36])
	
	//Modified by: administrator (4/7/15 14:06:45)
	
	
	[LSS_ElementInspection:163]LSS_InspectionId_s:3:=[LSS_Inspection:164]LSS_InspectionId_s:1
	C_LONGINT:C283($ID_L)
	
	Inc_Sequence("LSS_ElementInspectionId_s"; ->$ID_L)
	[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1:=String:C10($ID_L; <>KeyMask_s)
	
	LogNewRecord(->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; 0; "LSS_ElementInspection")
	
	
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	//[LSS_ElementInspection]LSS_ElementInspectionId_s
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_ElementInspectionId_s")
	If (ACT_PushGroupChanges(Table:C252(->[LSS_ElementInspection:163]); 3; ->$FieldsToSkip_atxt))
		SAVE RECORD:C53([LSS_ElementInspection:163])
	End if 
	UNLOAD RECORD:C212([LSS_ElementInspection:163])
	
	
	LogDeletion(->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; 0)
	
End if 