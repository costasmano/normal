//%attributes = {"invisible":true}
//Method: PON_SendToBrM_test
//Description
// testing of creating SQL statements to update BrM
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/03/19, 17:42:48
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
End if 
//

READ ONLY:C145(*)  // everything is read only
//connect to BrM SQL

C_TEXT:C284($BIN_txt; $BRM_DBName_txt)
C_LONGINT:C283($inspID_L)
$BIN_txt:="C04"
$inspID_L:=94518
$BIN_txt:=Request:C163("Enter BIN"; $BIN_txt)
//$inspID_L:=Num(Request("Enter insp ID";String($inspID_L)))
$BRM_DBName_txt:=ut_GetSysParameter("PON_BRMDBName"; "[BRM53]")
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_txt)
C_DATE:C307($LastBrMUpdate_d)
$LastBrMUpdate_d:=!2016-12-31!
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]DateModified:194>=$LastBrMUpdate_d)
QUERY:C277([Bridge MHD NBIS:1];  & [Bridge MHD NBIS:1]FHWARecord:174=True:C214)


//QUERY([Bridge MHD NBIS])
C_TEXT:C284($sql_txt; $ElemSql_txt)
$sql_txt:=SQL_sp_Update_NBI_Data
$ElemSql_txt:="Execute "+$BRM_DBName_txt+".[dbo]."+"[sp_pontis_Update_NBI]"+" "+$sql_txt+";\n"
ARRAY TEXT:C222($dbgInspTYpe_atxt; 0)
ARRAY DATE:C224($dbgInspDate_ad; 0)
ARRAY DATE:C224($dbgInsp1stDBIDate_ad; 0)
ARRAY DATE:C224($dbgInspDBIDate_ad; 0)

SET TEXT TO PASTEBOARD:C523($sql_txt)
//need method to find last inspection approved by DBIE after last BRM update
QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$inspID_L)

// set auto relations
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
//get BIN inspections
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)

//inspections that have been approved since last BrM update
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspDBIE1stApprDate:225>$LastBrMUpdate_d; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]InspDBIEApprDate:206>$LastBrMUpdate_d)

//get inspections that do have NBEs
QUERY SELECTION:C341([Inspections:27]; [PON_ELEM_INSP:179]INSPID:21>0)  // this works

//get inspections that can have NBEs 
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="OTH"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CMI"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="RT@")

ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78)

SELECTION TO ARRAY:C260([Inspections:27]Insp Date:78; $dbgInspDate_ad; \
[Inspections:27]Insp Type:6; $dbgInspTYpe_atxt; \
[Inspections:27]InspDBIE1stApprDate:225; $dbgInsp1stDBIDate_ad; \
[Inspections:27]InspDBIEApprDate:206; $dbgInspDBIDate_ad\
)

C_DATE:C307($LastInspDate_d)

C_TEXT:C284($SingleQuote_s; $QuoteMark_s; $SQLStatement_txt; $Notes_txt)
$SingleQuote_s:=Char:C90(39)
$QuoteMark_s:=Char:C90(34)

C_LONGINT:C283($inspLoop_L)

For ($inspLoop_L; 1; Size of array:C274($dbgInspDate_ad))
	
	$ElemSql_txt:=$ElemSql_txt+"\n"
	
	$LastInspDate_d:=$dbgInspDate_ad{$inspLoop_L}
	
	ARRAY LONGINT:C221($En_AL; 0)
	ARRAY LONGINT:C221($Env_AL; 0)
	ARRAY LONGINT:C221($ESTRU_AL; 0)
	ARRAY LONGINT:C221($EPN_AL; 0)
	ARRAY LONGINT:C221($EGPPN_AL; 0)
	ARRAY TEXT:C222($EN_Notes_atxt; 0)
	ARRAY REAL:C219($ENScaleF_ar; 0)
	ARRAY REAL:C219($TotQ_Ar; 0)
	ARRAY REAL:C219($CS1_Ar; 0)
	ARRAY REAL:C219($CS2_Ar; 0)
	ARRAY REAL:C219($CS3_Ar; 0)
	ARRAY REAL:C219($CS4_Ar; 0)
	
	C_OBJECT:C1216($mergedNBEDs_o)
	$mergedNBEDs_o:=PON_CombineRecent(True:C214; True:C214; Add to date:C393($LastInspDate_d; 0; 0; 1))  //add one day to the inspection date
	
	OB GET ARRAY:C1229($mergedNBEDs_o; "keys"; $En_AL)
	OB GET ARRAY:C1229($mergedNBEDs_o; "env"; $Env_AL)
	OB GET ARRAY:C1229($mergedNBEDs_o; "strunit"; $ESTRU_AL)
	OB GET ARRAY:C1229($mergedNBEDs_o; "parent"; $EPN_AL)
	OB GET ARRAY:C1229($mergedNBEDs_o; "grandparent"; $EGPPN_AL)
	OB GET ARRAY:C1229($mergedNBEDs_o; "notes"; $EN_Notes_atxt)
	OB GET ARRAY:C1229($mergedNBEDs_o; "scalef"; $ENScaleF_ar)
	OB GET ARRAY:C1229($mergedNBEDs_o; "totq"; $TotQ_Ar)
	OB GET ARRAY:C1229($mergedNBEDs_o; "q1"; $CS1_Ar)
	OB GET ARRAY:C1229($mergedNBEDs_o; "q2"; $CS2_Ar)
	OB GET ARRAY:C1229($mergedNBEDs_o; "q3"; $CS3_Ar)
	OB GET ARRAY:C1229($mergedNBEDs_o; "q4"; $CS4_Ar)
	
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($En_AL))
		$SQLStatement_txt:=""
		
		C_TEXT:C284($Spaces_txt)
		$SQLStatement_txt:=$SingleQuote_s+SQL_SetUpStrings([Bridge MHD NBIS:1]Item8:206)+$SingleQuote_s+", "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10($ESTRU_AL{$loop_L})+", "
		$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+String:C10($LastInspDate_d; 7)+$SingleQuote_s+", "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10($En_AL{$loop_L})+", "
		Case of 
			: ($Env_AL{$loop_L}<=0)
				$SQLStatement_txt:=$SQLStatement_txt+"2, "
			: ($Env_AL{$loop_L}>4)
				$SQLStatement_txt:=$SQLStatement_txt+"2, "
			Else 
				$SQLStatement_txt:=$SQLStatement_txt+String:C10($Env_AL{$loop_L})+", "
		End case 
		$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($TotQ_Ar{$loop_L}; 7))+", "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS1_Ar{$loop_L}; 6))+", "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS2_Ar{$loop_L}; 6))+", "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS3_Ar{$loop_L}; 6))+", "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10(Round:C94($CS4_Ar{$loop_L}; 6))+", "
		
		$Notes_txt:=Substring:C12(SQL_SetUpStrings($EN_Notes_atxt{$loop_L}); 1; 3990)
		$SQLStatement_txt:=$SQLStatement_txt+$SingleQuote_s+$Notes_txt+$SingleQuote_s+" , "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10($EPN_AL{$loop_L})+" , "
		$SQLStatement_txt:=$SQLStatement_txt+String:C10($EGPPN_AL{$loop_L})+"  "
		
		$ElemSql_txt:=$ElemSql_txt+"Execute "+$BRM_DBName_txt+".[dbo]."+"[sp_pontis_update_eleminsp]"+" "+$SQLStatement_txt+";\n"
		
	End for   // end of element loop
	
End for   //end of inspection loop

SET TEXT TO PASTEBOARD:C523($ElemSql_txt)

ALERT:C41("Statements are on pasteboard!")
//End PON_SendToBrM_test