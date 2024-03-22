//%attributes = {"invisible":true}
ARRAY TEXT:C222($IDs_atxt; 0)
ARRAY LONGINT:C221($Ids_aL; 0)
ARRAY TEXT:C222($DupIds_atxt; 0)
ARRAY LONGINT:C221($DupIds_aL; 0)
C_LONGINT:C283($Loop_L; $Count_L)
ARRAY TEXT:C222($IDs_atxt; 0)

ALL RECORDS:C47([LSS_Accessibility:159])
DISTINCT VALUES:C339([LSS_Accessibility:159]LSS_AccessibilityId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_Accessibility:159])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_Accessibility:159]; [LSS_Accessibility:159]LSS_AccessibilityId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_Accessibility:159]LSS_AccessibilityId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_Accessibility:159]; "Output")
		MODIFY SELECTION:C204([LSS_Accessibility:159]; *)
	End if 
End if 


ARRAY TEXT:C222($IDs_atxt; 0)

ALL RECORDS:C47([LSS_DMeter:161])
DISTINCT VALUES:C339([LSS_DMeter:161]LSS_DMeterId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_DMeter:161])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_DMeterId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_DMeter:161]LSS_DMeterId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_DMeter:161]; "Output")
		MODIFY SELECTION:C204([LSS_DMeter:161]; *)
	End if 
End if 
ARRAY TEXT:C222($IDs_atxt; 0)

ALL RECORDS:C47([LSS_ElementInspection:163])
DISTINCT VALUES:C339([LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_ElementInspection:163])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_ElementInspectionId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_ElementInspection:163]; "Output")
		MODIFY SELECTION:C204([LSS_ElementInspection:163]; *)
	End if 
End if 
ARRAY TEXT:C222($IDs_atxt; 0)

ALL RECORDS:C47([LSS_Inspection:164])
DISTINCT VALUES:C339([LSS_Inspection:164]LSS_InspectionId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_Inspection:164])#Size of array:C274($IDs_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($IDs_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L=1)
		Else 
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InspectionId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_Inspection:164]; "Output")
		MODIFY SELECTION:C204([LSS_Inspection:164]; *)
	End if 
End if 
ARRAY TEXT:C222($IDs_atxt; 0)

ALL RECORDS:C47([LSS_Inventory:165])
DISTINCT VALUES:C339([LSS_Inventory:165]LSS_InventoryId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_Inventory:165])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		ARRAY TEXT:C222($DupIds_atxt; 0)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_InventoryId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_InventoryId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_Inventory:165]; "Output")
		MODIFY SELECTION:C204([LSS_Inventory:165]; *)
	End if 
End if 

ARRAY TEXT:C222($IDs_atxt; 0)

ALL RECORDS:C47([LSS_Photos:166])
DISTINCT VALUES:C339([LSS_Photos:166]LSS_PhotoId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_Photos:166])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_Photos:166]LSS_PhotoId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_Photos:166]; "Output")
		MODIFY SELECTION:C204([LSS_Photos:166]; *)
	End if 
End if 

ARRAY TEXT:C222($IDs_atxt; 0)

ALL RECORDS:C47([LSS_SignPanel:172])
DISTINCT VALUES:C339([LSS_SignPanel:172]LSS_SignPanelId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_SignPanel:172])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_SignPanelId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_SignPanel:172]LSS_SignPanelId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_SignPanel:172]; "Output")
		MODIFY SELECTION:C204([LSS_SignPanel:172]; *)
	End if 
End if 


ARRAY TEXT:C222($IDs_atxt; 0)
ALL RECORDS:C47([LSS_TowerDistance:174])
DISTINCT VALUES:C339([LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_TowerDistance:174])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_TowerDistanceId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_TowerDistance:174]; "Output")
		MODIFY SELECTION:C204([LSS_TowerDistance:174]; *)
	End if 
End if 


ARRAY TEXT:C222($IDs_atxt; 0)
ALL RECORDS:C47([LSS_UT:175])
DISTINCT VALUES:C339([LSS_UT:175]LSS_UTId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_UT:175])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_UTId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_UT:175]LSS_UTId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_UT:175]; "Output")
		MODIFY SELECTION:C204([LSS_UT:175]; *)
	End if 
End if 

ARRAY TEXT:C222($IDs_atxt; 0)

ARRAY TEXT:C222($IDs_atxt; 0)
ALL RECORDS:C47([LSS_UtResult:176])
DISTINCT VALUES:C339([LSS_UtResult:176]LSS_UTResultId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_UtResult:176])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTResultId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_UtResult:176]LSS_UTResultId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_UtResult:176]; "Output")
		MODIFY SELECTION:C204([LSS_UtResult:176]; *)
	End if 
End if 

ARRAY TEXT:C222($IDs_atxt; 0)
ALL RECORDS:C47([LSS_VerticalClearance:177])
DISTINCT VALUES:C339([LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; $IDs_atxt)

If (Records in table:C83([LSS_VerticalClearance:177])#Size of array:C274($Ids_atxt))
	ARRAY TEXT:C222($DupIds_atxt; 0)
	For ($Loop_L; 1; Size of array:C274($Ids_atxt))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
		
		QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1=$IDs_atxt{$Loop_L})
		If ($Count_L>1)
			APPEND TO ARRAY:C911($DupIds_atxt; $IDs_atxt{$Loop_L})
		End if 
	End for 
	If (Size of array:C274($DupIds_atxt)>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY WITH ARRAY:C644([LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; $DupIds_atxt)
		FORM SET OUTPUT:C54([LSS_VerticalClearance:177]; "Output")
		MODIFY SELECTION:C204([LSS_VerticalClearance:177]; *)
	End if 
End if 
