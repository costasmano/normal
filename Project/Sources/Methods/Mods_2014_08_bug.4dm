//%attributes = {"invisible":true}
//Method: Mods_2014_08_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/05/14, 08:34:10
	// ----------------------------------------------------
	//Created : 
	Mods_2014_08_bug
End if 
//

// Modified Table(s) : 
//[SQL_Connections]
//  `added field SQL_SCHEMA_s (A80)

// Modified Forms : 
//[SQL_Connections];"Connect_dlg"
//  `added field SQL_SCHEMA_s 

// Modified Method(s) : 
//Compiler_SQL 
//ut_LoadSQLConnectionInfo
//  `added SQL_SCHEMA_s

//maximo_UpdateMaximo
//  `modified code to use the SQL_Schema  from SQL_connections tbale for table prefix.
//  ` present a chose of available SQL connections starting with MAX@ - assume default connection is MAXPROD
//  `added new parameter max_DefaultDBName
//  `added message if Inspection record is skipped because it is locked


//**********`Modified by: Costas Manousakis-(Designer)-(8/6/14)
// Modified Method(s) : 
//GenerateCondRep
//  `removed = True comparisons in bdeficient , etc.

//iAgeofBridge
//  `fixed first Count parameters to > 1 from = 2
//bFuncObsCheck
//  `fixed first count parameters to > 5 from = 6

// Modified Method(s) : 
//maximo_UpdateMaximo
//  `added save record after setting [inspections]UpdateMaximo = 2
//  `changed starting search to [inspections]UpdateMaximo=Ï1


//**********`Modified by: Costas Manousakis-(Designer)-(8/7/14)
// Modified Method(s) : 
//ut_SQLTellServerNRC
//  `  `mark record as sent here when  ut_SQLUpdateServerActLog will not becalled due to Duplcate key ignore

// Modified Object Methods : 
//Object Method: [Cons Inspection];"Cslt Insp In".btnConsInspDel 
//  `Moved the Delete Record after the LogDeletion

//**********`Modified by: Costas Manousakis-(Designer)-(8/8/14)
// Modified Object Methods : 
//Object Method: [Conslt Rating]."Cslt Rating In".btnDeleteCRtg 
//  `Moved the Delete Record after the LogDeletion

// Modified Forms : 
//[Inspections];"TunnelRoutinePg1"
//[Inspections];"TunnelRoutinePg1-0"
//[Inspections];"TunnelRoutinePg1-sample"
//  `fixed  typo in variable vRSTR_16

// Modified Method(s) : 
//Compiler_NewInspReports
//  `Added vxWET_8 and vxWET_9 set of variables
//  `did some cleanup of duplicate declarations

// Modified Forms : 
//[Inspections];"TunnelRoutinePg2"
//  `Added vxWET_8 and vxWET_9 set of variables

//```
//```   **** End of Release 6.3.3 08/28/14
//```

//End Mods_2014_08_bug