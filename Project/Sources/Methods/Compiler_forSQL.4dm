//%attributes = {"invisible":true}
//Method: COMPILER_forSQL
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 09/07/10, 13:24:15
	//----------------------------------------------------
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/7/10 13:24:17)
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 15:16:41)
	// Modified by: Charles Miller-(Designer)-(5/30/13 )
	Mods_2013_05
	//  `added C_LONGINT(Count_l)
	
End if 
C_TEXT:C284(SQL_Select)
C_TEXT:C284(SeverStructureName_txt)
C_LONGINT:C283(WKHR_SRCH_AssgnNo_L; WKHR_SRCH_AddendNo_L)
C_TEXT:C284(WKHR_SRCH_ContractNo_s)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(vsDialogTxt)
C_TEXT:C284(vsPassword; vUserName)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305(vbInspRefresh; SQLConnectionMade_b; SQLError_b; 4DError_b; DeletionOK_b; InWHKRUpdate_b; vbOnScreenMessage; vbToFileMessage; DeletionOK_b; RecordLocked_b; AbortDueToLockedRecord_b; DataRefernceError_b)
C_LONGINT:C283(OwnerFileID_l; ActFileID_l; OwnerRef_l; OwnerName_l; InspDownLd_L)
C_BLOB:C604(NewFieldID; OldFieldID)
C_TEXT:C284(aStuff)  // Command Replaced was o_C_STRING length was 80
C_REAL:C285(rStuff)
C_TEXT:C284(tStuff)
C_DATE:C307(dStuff)
C_BOOLEAN:C305(bStuff)
C_LONGINT:C283(iStuff)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(lStuff)
C_TIME:C306(timeStuff)
C_PICTURE:C286(picStuff)
C_BLOB:C604(xStuff)
C_LONGINT:C283(ParentID_l; RefID_l)
C_TEXT:C284(ParentID_s)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(REFID_s)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283(vKey_l)
C_TEXT:C284(vCurrBIN_s; vApprVar_s)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283(Count_l)

ARRAY TEXT:C222(Bdepts_atxt; 0)
ARRAY LONGINT:C221(CONTRACT_ID_aL; 0)
ARRAY LONGINT:C221(PROJECT_NO_aL; 0)
ARRAY TEXT:C222(ITEM_NO_Atxt; 0)
ARRAY TEXT:C222(UNIT_OF_MEASUREMENT_atxt; 0)
ARRAY REAL:C219(ITEM_PROJECTED_QUANTITY_ar; 0)
ARRAY REAL:C219(ITEM_BID_QUANTITY_ar; 0)
ARRAY REAL:C219(UNIT_PRICE_ar; 0)
ARRAY LONGINT:C221(CONTRACT_NO_aL; 0)
ARRAY TEXT:C222(AWARD_DATE_aD; 0)
ARRAY TEXT:C222(ACTUAL_NTP_DATE_aD; 0)
ARRAY TEXT:C222(CONTRACT_DESCPT_atxt; 0)
ARRAY TEXT:C222(DESCRIPTION_atxt; 0)
ARRAY TEXT:C222(CHILD_NAME_atxt; 0)
ARRAY TEXT:C222(MODIFIED_DATE_ad; 0)
ARRAY TEXT:C222(BID_OPEN_DATE_ad; 0)
C_TEXT:C284(startDate_txt; EndDate_txt)

ARRAY TEXT:C222(ItemNo_atxt; 0)
ARRAY TEXT:C222(Unit_atxt; 0)
ARRAY TEXT:C222(Descr_atxt; 0)
ARRAY REAL:C219(ItemQ_ar; 0)
ARRAY REAL:C219(UnitPrice_ar; 0)

C_LONGINT:C283(ContrID_L)

//End COMPILER_forSQL