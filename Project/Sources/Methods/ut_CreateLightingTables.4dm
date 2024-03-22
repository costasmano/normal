//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/05/12, 11:31:24
//----------------------------------------------------
//Method: ut_CreateLightingTables
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_03  //r003 
	//Modified by: Charles Miller (4/5/12 11:31:24)
	
End if 
If (False:C215)
	C_BOOLEAN:C305(SQLError_b)
	C_TEXT:C284(SQL_Select)
	
	ON ERR CALL:C155("SQL_ERROR")
	//ut_SQLExecuteNoReturn ("START")
	
	SQL_Select:="CREATE TABLE IF NOT EXISTS [tbl_inspection_data]"
	SQL_Select:=SQL_Select+"("
	SQL_Select:=SQL_Select+"[InspectionID] INT32,"
	SQL_Select:=SQL_Select+"[IDLargeSignStructures] INT32,"
	SQL_Select:=SQL_Select+"[Milepost] REAL,"
	SQL_Select:=SQL_Select+"[StructureStatus] TEXT,"
	SQL_Select:=SQL_Select+"[Decal_Present] TEXT,"
	SQL_Select:=SQL_Select+"[Inspection_Status] TEXT,"
	SQL_Select:=SQL_Select+"[SANGN] TEXT,"
	SQL_Select:=SQL_Select+"[Inspection Date] TEXT,"
	SQL_Select:=SQL_Select+"[Inspection Type] TEXT,"
	SQL_Select:=SQL_Select+"[Installation Year] TEXT,"
	SQL_Select:=SQL_Select+"[Anchor Bolt UT Date] TEXT,"
	SQL_Select:=SQL_Select+"[Anchor Bolt UT By] TEXT,"
	SQL_Select:=SQL_Select+"[LeadInspectorID] INT32,"
	SQL_Select:=SQL_Select+"[InspectorID] INT32,"
	SQL_Select:=SQL_Select+"[Repair Required] INT32,"
	SQL_Select:=SQL_Select+"[Number of Truss Sections] INT32,"
	SQL_Select:=SQL_Select+"[Number of Towers] INT32,"
	SQL_Select:=SQL_Select+"[TotalSuperstructureLength] TEXT,"
	SQL_Select:=SQL_Select+"[Material Type] TEXT,"
	SQL_Select:=SQL_Select+"[Min Vert Clearance] TEXT,"
	SQL_Select:=SQL_Select+"[Number of Lanes] INT32,"
	SQL_Select:=SQL_Select+"[Walkway] INT32,"
	SQL_Select:=SQL_Select+"[Lighting] INT32,"
	SQL_Select:=SQL_Select+"[VMS Panel] INT32,"
	SQL_Select:=SQL_Select+"[Sign Area] TEXT,"
	SQL_Select:=SQL_Select+"[Design Based on SDA] TEXT,"
	SQL_Select:=SQL_Select+"[Const Cont Designation] TEXT,"
	SQL_Select:=SQL_Select+"[ModsSinceConstruction] TEXT,"
	SQL_Select:=SQL_Select+"[Damage Reports] TEXT,"
	SQL_Select:=SQL_Select+"[Overall Inspection Rating] INT32,"
	SQL_Select:=SQL_Select+"[OverallInspectionComments] TEXT,"
	SQL_Select:=SQL_Select+"[RepairRating] TEXT,"
	SQL_Select:=SQL_Select+"[RepairComment] TEXT,"
	SQL_Select:=SQL_Select+"[DR1] TEXT,"
	SQL_Select:=SQL_Select+"[DC1] TEXT,"
	SQL_Select:=SQL_Select+"[DR2] TEXT,"
	SQL_Select:=SQL_Select+"[DC2] TEXT,"
	SQL_Select:=SQL_Select+"[DR3] TEXT,"
	SQL_Select:=SQL_Select+"[DC3] TEXT,"
	SQL_Select:=SQL_Select+"[DR4] TEXT,"
	SQL_Select:=SQL_Select+"[DC4] TEXT,"
	SQL_Select:=SQL_Select+"[DR5] TEXT,"
	SQL_Select:=SQL_Select+"[DC5] TEXT,"
	SQL_Select:=SQL_Select+"[DR6] TEXT,"
	SQL_Select:=SQL_Select+"[DC6] TEXT,"
	SQL_Select:=SQL_Select+"[DR7] TEXT,"
	SQL_Select:=SQL_Select+"[DC7] TEXT,"
	SQL_Select:=SQL_Select+"[DR8] TEXT,"
	SQL_Select:=SQL_Select+"[DC8] TEXT,"
	SQL_Select:=SQL_Select+"[DR9] TEXT,"
	SQL_Select:=SQL_Select+"[DC9] TEXT,"
	SQL_Select:=SQL_Select+"[DR10] TEXT,"
	SQL_Select:=SQL_Select+"[DC10] TEXT,"
	SQL_Select:=SQL_Select+"[DR11] TEXT,"
	SQL_Select:=SQL_Select+"[DC11] TEXT,"
	SQL_Select:=SQL_Select+"[DR12] TEXT,"
	SQL_Select:=SQL_Select+"[DC12] TEXT,"
	SQL_Select:=SQL_Select+"[DR13] TEXT,"
	SQL_Select:=SQL_Select+"[DC13] TEXT,"
	SQL_Select:=SQL_Select+"[DR14] TEXT,"
	SQL_Select:=SQL_Select+"[DC14] TEXT,"
	SQL_Select:=SQL_Select+"[DR15] TEXT,"
	SQL_Select:=SQL_Select+"[DC15] TEXT,"
	SQL_Select:=SQL_Select+"[DR16] TEXT,"
	SQL_Select:=SQL_Select+"[DC16] TEXT,"
	SQL_Select:=SQL_Select+"[DR17] TEXT,"
	SQL_Select:=SQL_Select+"[DC17] TEXT,"
	SQL_Select:=SQL_Select+"[DR18] TEXT,"
	SQL_Select:=SQL_Select+"[DC18] TEXT,"
	SQL_Select:=SQL_Select+"[Description] TEXT,"
	SQL_Select:=SQL_Select+"[Comments] TEXT);"
	Begin SQL
		
		EXECUTE IMMEDIATE :SQL_Select;
		
	End SQL
	
	
	SQL_Select:="CREATE TABLE IF NOT EXISTS [tbl_lighting_inspection_data]"
	SQL_Select:=SQL_Select+"("
	SQL_Select:=SQL_Select+"[InspectionID_Lighting] INT32,"
	SQL_Select:=SQL_Select+"[Structure_Number_L] TEXT,"
	SQL_Select:=SQL_Select+"[IDLightingStructure] INT32,"
	SQL_Select:=SQL_Select+"[SANGN] TEXT,"
	SQL_Select:=SQL_Select+"[StructureStatus] TEXT,"
	SQL_Select:=SQL_Select+"[InspectionDate] TEXT,"
	SQL_Select:=SQL_Select+"[InspectionType] TEXT,"
	SQL_Select:=SQL_Select+"[InstallationYear] TEXT,"
	SQL_Select:=SQL_Select+"[AnchorBoltUTDate] INT32,"
	SQL_Select:=SQL_Select+"[AnchorBoltUTBy] TEXT,"
	SQL_Select:=SQL_Select+"[NumberOfLanes] INT32,"
	SQL_Select:=SQL_Select+"[LeadInspectorID] INT32,"
	SQL_Select:=SQL_Select+"[AssistantInspectorID] INT32,"
	SQL_Select:=SQL_Select+"[RepairRequired] INT32,"
	SQL_Select:=SQL_Select+"[DamageReports] TEXT,"
	SQL_Select:=SQL_Select+"[Overall Inspection Rating] TEXT,"
	SQL_Select:=SQL_Select+"[OverallInspectionComment] TEXT,"
	SQL_Select:=SQL_Select+"[RR1] TEXT,"
	SQL_Select:=SQL_Select+"[RC1] TEXT,"
	SQL_Select:=SQL_Select+"[DR1] TEXT,"
	SQL_Select:=SQL_Select+"[DC1] TEXT,"
	SQL_Select:=SQL_Select+"[DR2] TEXT,"
	SQL_Select:=SQL_Select+"[DC2] TEXT,"
	SQL_Select:=SQL_Select+"[DR3] TEXT,"
	SQL_Select:=SQL_Select+"[DC3] TEXT,"
	SQL_Select:=SQL_Select+"[DR4] TEXT,"
	SQL_Select:=SQL_Select+"[DC4] TEXT,"
	SQL_Select:=SQL_Select+"[DR5] TEXT,"
	SQL_Select:=SQL_Select+"[DC5] TEXT,"
	SQL_Select:=SQL_Select+"[DR6] TEXT,"
	SQL_Select:=SQL_Select+"[DC6] TEXT,"
	SQL_Select:=SQL_Select+"[DR8] TEXT,"
	SQL_Select:=SQL_Select+"[DC8] TEXT,"
	SQL_Select:=SQL_Select+"[DR13] TEXT,"
	SQL_Select:=SQL_Select+"[DC13] TEXT,"
	SQL_Select:=SQL_Select+"[DR16] TEXT,"
	SQL_Select:=SQL_Select+"[DC16] TEXT,"
	SQL_Select:=SQL_Select+"[DR17] TEXT,"
	SQL_Select:=SQL_Select+"[DC17] TEXT,"
	SQL_Select:=SQL_Select+"[DR18] TEXT,"
	SQL_Select:=SQL_Select+"[DC18] TEXT);"
	
	
	Begin SQL
		
		EXECUTE IMMEDIATE :SQL_Select;
		
	End SQL
	
	
	
	SQL_Select:="CREATE TABLE IF NOT EXISTS [tbl_lighting_structure]"
	SQL_Select:=SQL_Select+"("
	SQL_Select:=SQL_Select+"[IDLightingStructure] INT32,"
	SQL_Select:=SQL_Select+"[Structure_Number_L] TEXT,"
	SQL_Select:=SQL_Select+"[DecalName] TEXT,"
	SQL_Select:=SQL_Select+"[StructureType_L] TEXT,"
	SQL_Select:=SQL_Select+"[DistrictName] TEXT,"
	SQL_Select:=SQL_Select+"[Maint_Juris] TEXT,"
	SQL_Select:=SQL_Select+"[Municipality] TEXT,"
	SQL_Select:=SQL_Select+"[Milepost] REAL,"
	SQL_Select:=SQL_Select+"[Latitude] REAL,"
	SQL_Select:=SQL_Select+"[Longitude] REAL,"
	SQL_Select:=SQL_Select+"[Sync] INT32,"
	SQL_Select:=SQL_Select+"[NumberArms] INT32,"
	SQL_Select:=SQL_Select+"[MaxSpanLength] TEXT,"
	SQL_Select:=SQL_Select+"[MaterialType] TEXT,"
	SQL_Select:=SQL_Select+"[PoleFinish] TEXT,"
	SQL_Select:=SQL_Select+"[FoundationMaterial] TEXT,"
	SQL_Select:=SQL_Select+"[NumOfBolts] INT32,"
	SQL_Select:=SQL_Select+"[NumLuminaires] INT32,"
	SQL_Select:=SQL_Select+"[Wattage] TEXT,"
	SQL_Select:=SQL_Select+"[ActualRoute] TEXT);"
	
	Begin SQL
		
		EXECUTE IMMEDIATE :SQL_Select;
		
	End SQL
	
	SQL_Select:="CREATE TABLE IF NOT EXISTS [tbl_overhead_structures]"
	SQL_Select:=SQL_Select+"("
	SQL_Select:=SQL_Select+"[IDLargeSignStructures] INT32,"
	SQL_Select:=SQL_Select+"[L_ROUTE] TEXT,"
	SQL_Select:=SQL_Select+"[Route] TEXT,"
	SQL_Select:=SQL_Select+"[GISRouteKey] TEXT,"
	SQL_Select:=SQL_Select+"[MHDAssetID] REAL,"
	SQL_Select:=SQL_Select+"[DistanceStamp] REAL,"
	SQL_Select:=SQL_Select+"[GIS_MEAS] REAL,"
	SQL_Select:=SQL_Select+"[Districts] TEXT,"
	SQL_Select:=SQL_Select+"[MaintJurisdiction] TEXT,"
	SQL_Select:=SQL_Select+"[Municipality] TEXT,"
	SQL_Select:=SQL_Select+"[StructureType] TEXT,"
	SQL_Select:=SQL_Select+"[NumberOfSigns] INT32,"
	SQL_Select:=SQL_Select+"[Other] TEXT,"
	SQL_Select:=SQL_Select+"[ImageFolder] TEXT,"
	SQL_Select:=SQL_Select+"[ImageFileName] TEXT,"
	SQL_Select:=SQL_Select+"[Latitude] REAL,"
	SQL_Select:=SQL_Select+"[Longitude] REAL,"
	SQL_Select:=SQL_Select+"[UniqueRun] TEXT,"
	SQL_Select:=SQL_Select+"[IDSession] REAL,"
	SQL_Select:=SQL_Select+"[Sync] INT32);"
	
	
	Begin SQL
		
		EXECUTE IMMEDIATE :SQL_Select;
		
	End SQL
	
	If (SQLError_b)
		//ut_SQLExecuteNoReturn ("ROLLBACK")
	Else 
		//ut_SQLExecuteNoReturn ("COMMIT")
	End if 
	//End ut_CreateLightingTables
	
	
End if 