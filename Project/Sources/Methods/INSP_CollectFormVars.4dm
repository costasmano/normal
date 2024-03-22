//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/06/11, 22:59:24
	// ----------------------------------------------------
	// Method: INSP_CollectFormVars
	// Description
	//  ` Collect the variables used in the various inspection forms.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
	//`Inspection form variables mods 
End if 
ARRAY LONGINT:C221(INSPRTNVARS_AL; 0)
ARRAY LONGINT:C221(INSPRTAVARS_AL; 0)
ARRAY LONGINT:C221(INSPCULVARS_AL; 0)
ARRAY LONGINT:C221(INSPRRRVARS_AL; 0)
InitProcessVar
G_InitInspVars
INSP_PRN_InitVars

C_BOOLEAN:C305(INSPFORMVARSDO_B)
//SET PRINT OPTION(_o_Hide printing progress option; 1)
SHORT_MESSAGE("starting...")
INSPFORMVARSDO_B:=True:C214
C_LONGINT:C283(INSPFORMVARMAXNO_L)
READ ONLY:C145([ElementDict:30])
ALL RECORDS:C47([ElementDict:30])
ORDER BY:C49([ElementDict:30]; [ElementDict:30]ElementNo:1; <)
FIRST RECORD:C50([ElementDict:30])
INSPFORMVARMAXNO_L:=[ElementDict:30]ElementNo:1
MESSAGE:C88("To "+String:C10(INSPFORMVARMAXNO_L)+"...")
MESSAGE:C88("Routine...")
ARRAY LONGINT:C221(INSPFORMVARS_AL; 0)
Print form:C5([Inspections:27]; "Routine Pr Pg 1")
Print form:C5([Inspections:27]; "Routine Pr Pg 2")
Print form:C5([Inspections:27]; "RoutinePrPg2_v2")
COPY ARRAY:C226(INSPFORMVARS_AL; INSPRTNVARS_AL)
ARRAY LONGINT:C221(INSPFORMVARS_AL; 0)
MESSAGE:C88("Arch...")
Print form:C5([Inspections:27]; "Routine Arch Pr Pg 1")
Print form:C5([Inspections:27]; "Routine Pr Pg 2")
Print form:C5([Inspections:27]; "RoutinePrPg2_v2")
COPY ARRAY:C226(INSPFORMVARS_AL; INSPRTAVARS_AL)
ARRAY LONGINT:C221(INSPFORMVARS_AL; 0)
MESSAGE:C88("Culvert...")
Print form:C5([Inspections:27]; "Culvert Pr Pg 1")
Print form:C5([Inspections:27]; "Culvert Pr Pg 2")
Print form:C5([Inspections:27]; "CulvertPrPg1_v2")
COPY ARRAY:C226(INSPFORMVARS_AL; INSPCULVARS_AL)
ARRAY LONGINT:C221(INSPFORMVARS_AL; 0)
MESSAGE:C88("Rail-Transit...")
Print form:C5([Inspections:27]; "RailRoutinePrPg1")
Print form:C5([Inspections:27]; "RailRoutinePrPg2")
COPY ARRAY:C226(INSPFORMVARS_AL; INSPRRRVARS_AL)
PAGE BREAK:C6(*)  //cancel
INSPFORMVARSDO_B:=False:C215
//SET PRINT OPTION(_o_Hide printing progress option; 0)
MESSAGE:C88("DONE")
CLOSE WINDOW:C154