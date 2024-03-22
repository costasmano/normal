//%attributes = {"invisible":true}
//Method: Compiler_MAP
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/02/13, 10:55:07
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
	// Modified by: Costas Manousakis-(Designer)-(3/20/14 17:41:52)
	Mods_2014_03
	//  `added vars for  ut_MapListofBridges
	// Modified by: Costas Manousakis-(Designer)-(5/20/15 13:35:14)
	Mods_2015_05
	//  `added  MAP_BubbleCode_s
	// Modified by: Costas Manousakis-(Designer)-(11/28/16 16:30:31)
	Mods_2016_11
	//  `Added new vars and  methods for KML mapping
End if 
//
C_LONGINT:C283(MAP_BridgeCount_L)
C_DATE:C307(MAP_Date_d)
C_REAL:C285(MAP_CenterLat_r; MAP_CenterLon_r)
ARRAY REAL:C219(MAP_ArrayLat_ar; 0)
ARRAY REAL:C219(MAP_ArrayLon_ar; 0)
ARRAY TEXT:C222(MAP_ArrayDesc_atxt; 0)
ARRAY TEXT:C222(MAP_ArrayBIN_atxt; 0)
ARRAY TEXT:C222(MAP_ArrayInfoWin_atxt; 0)
C_TEXT:C284(MAP_WebArea; MAP_WebArea_url)
C_LONGINT:C283(MAP_WebArea_progress)
C_TEXT:C284(MAP_HTMLOutputFile_txt)
C_LONGINT:C283(MAP_Bridge_LB)
C_TEXT:C284(MAP_GetTownCenterLatLong; $1)
C_POINTER:C301(MAP_GetTownCenterLatLong; $2; $3)
C_BOOLEAN:C305(MAP_OutOfStateBoundary_b; $0)
C_REAL:C285(MAP_OutOfStateBoundary_b; $1; $2)
C_REAL:C285(BRGLATCENTER; BRGLONGCENTER)
ARRAY REAL:C219(BRIDGELATDEG_ar; 0)
ARRAY REAL:C219(BRIDGELONGDEG_ar; 0)
ARRAY TEXT:C222(BRIDGEBINLABEL_atxt; 0)
C_LONGINT:C283(BRIDGECOUNT)
C_TEXT:C284(MAP_BubbleCode_s; $0)  // was length of 2
C_LONGINT:C283(MAP_BubbleCode_s; $1)
ARRAY POINTER:C280(KML_Fields_aptr; 0)
ARRAY TEXT:C222(KML_FieldLabels_atxt; 0)
ARRAY TEXT:C222(KML_Fields_Value_atxt; 0)
C_TEXT:C284(KML_DocDescription_txt; KML_DocName_txt; KML_DocTitle_txt; KML_BridgeName_txt)
C_REAL:C285(KML_BridgeLon_r; KML_BridgeLat_r)
ARRAY POINTER:C280(KML_LabelFields_aptr; 0)
C_TEXT:C284(MAP_PrepBridgeData; $0)
C_TEXT:C284(MAP_PrepBridgeData; $1)
C_REAL:C285(F_MDistance; $0)
C_REAL:C285(F_MDistance; $1)
C_REAL:C285(F_MDistance; $2)
C_REAL:C285(F_MDistance; $3)
C_REAL:C285(F_MDistance; $4)

C_TEXT:C284(MAP_FormatDate; $0)
C_DATE:C307(MAP_FormatDate; $1)
C_LONGINT:C283(MAP_FormatDate; $2)

C_LONGINT:C283(MAP_SetDateFormat; $0)

C_OBJECT:C1216(MAP_BuildGeoJSONProperties; $0; $1)

//End Compiler_MAP
