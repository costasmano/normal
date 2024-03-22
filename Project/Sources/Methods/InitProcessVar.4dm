//%attributes = {"invisible":true}
If (False:C215)
	//GP: InitProcessVar
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Initialize process variables for the MHD BMS application
	
	Mods_2004_CM11
	// Modified by: costasmanousakis-(Designer)-(2/7/2006 11:46:14)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(12/12/2006 12:01:09)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(3/28/2007 15:54:24)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/30/08 14:58:02)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//  `Use ◊aFeatDescr,... global vars for aFeatDescr_,IDaFeatDescr_,BINaFeatDescr_ process vars
	// Modified by: costasmanousakis-(Designer)-(10/1/08 09:18:11)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//Changed size of aItem31 to A(2)
	Mods_2009_03  //CJM  r001   `03/06/09, 12:53:13`Upgrade from open form window to open window
	Mods_2013_05  //r001 ` Add Compiler_NewInspReports so it is only called once at process launch
	//Modified by: Charles Miller (5/2/13 15:49:11)
	Mods_2013_09  //r001 ` 
	//Modified by: Charles Miller (9/18/13 11:00:52)
	//Add fields to [TunnelInspection] to track 
	//Structural Collision Damage
	//[TunnelInspection]StructuralCollisionValue_s
	//[TunnelInspection]StructuralCollisionComments_txt
	//Roadway collision damage
	//[TunnelInspection]RoadwayCollisionValue_s
	//[TunnelInspection]RoadwayCollisionComments_txt
	
	// Modified by: Costas Manousakis (3/27/17)
	Mods_2017_03
	//  //added code to display the item code with the description in dropdowns. use dev_mergeCodeAndDesc
	// Modified by: Costas Manousakis-(Designer)-(6/27/17 16:56:21)
	Mods_2017_06_bug
	//  `<>aFreezeThawDesc can be a text array - also no need to merge code and descr for freeze thaw drop down
	// Modified by: Costas Manousakis-(Designer)-(6/8/18 14:39:01)
	Mods_2018_06
	//  `Added SET DATABASE PARAMETER(49;2) to allow searching by fields in other tables.
	Mods_2019_07  //Create new form to test as designer so width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 11:04:03)
	Mods_2021_10
	//  `move short_message to start of method
End if 

SHORT_MESSAGE("Initializing process data. Please wait…")

Compiler_NewInspReports
Compiler_FieldVariables
ut_InitFieldArray
$v_startMili_L:=Milliseconds:C459
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255//What is the main window title?
C_TEXT:C284(CurInsp)  // Command Replaced was o_C_STRING length was 5//Who is doing the inspection?
C_POINTER:C301(pFile)  //The table that is current
C_TEXT:C284(DefInLay)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(DefOutLay)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($v_startMili_L; $v_Part1_L; $v_Part2_L; $v_Part3_L; $v_Part4_L; $v_Part5_L; $v_Part6_L; $v_Part7_L)
ARRAY INTEGER:C220(aInspLevelCod_; 0)
ARRAY INTEGER:C220(aMonthI; 0)
ARRAY TEXT:C222(BINa7FCodes_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(BINaFeatCodes_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(IDa7FCodes_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(IDaFeatCodes_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(a7FCodes_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(aCulInspC_; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aCulvertI_; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aItem107Des; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aItem107; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem108c; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem108cD; 0)  //Command Replaced was o_ARRAY string length was 26
ARRAY TEXT:C222(aItem31; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aItem43bDes; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aItem44bDes; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aItem43b; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aItem44b; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aItem31Des; 0)  //Command Replaced was o_ARRAY string length was 19
ARRAY TEXT:C222(aItem102; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem102Des; 0)  //Command Replaced was o_ARRAY string length was 28
ARRAY TEXT:C222(aItem26Des; 0)  //Command Replaced was o_ARRAY string length was 23
ARRAY TEXT:C222(aItem26; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aFeatCodes_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(aFndCode_; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aFndtion_; 0)  //Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(aInspCod_; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aInspLevel_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(aInspRcod_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(aInspRdes_; 0)  //Command Replaced was o_ARRAY string length was 45
ARRAY TEXT:C222(aInspType_; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aIntegralC_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aIntegralD_; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aIt8BrCatCode_; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aIt8OwnerCode_; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aItem100_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem100d_; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(aItem101_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem101d_; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(aItem111_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem111d_; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(aItem20_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem20des_; 0)  //Command Replaced was o_ARRAY string length was 65
ARRAY TEXT:C222(aItem33_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem33des_; 0)  //Command Replaced was o_ARRAY string length was 42
ARRAY TEXT:C222(aItem37_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem37des_; 0)  //Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(aItem38_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem38des_; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aItem21; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aItem22; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aItem21Des; 0)  //Command Replaced was o_ARRAY string length was 27
ARRAY TEXT:C222(aItem22Des; 0)  //Command Replaced was o_ARRAY string length was 27
ARRAY TEXT:C222(aItem43a; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem44a; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem43aDes; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(aItem44aDes; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(aItem108b; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem108bD; 0)  //Command Replaced was o_ARRAY string length was 26
ARRAY TEXT:C222(aMonths; 0)  //Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222(aItem41; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aPostStat_; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aPostStatC_; 0)  //Command Replaced was o_ARRAY string length was 6
ARRAY TEXT:C222(aItem41Des; 0)  //Command Replaced was o_ARRAY string length was 32
ARRAY TEXT:C222(aIRatMethD_; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(aORatMethD_; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(aIRatMeth_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aORatMeth_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem42a; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem42b; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem42bDes; 0)  //Command Replaced was o_ARRAY string length was 15
ARRAY TEXT:C222(aItem42aDes; 0)  //Command Replaced was o_ARRAY string length was 24
ARRAY TEXT:C222(aItem64aDes; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(aItem66aDes; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(aItem64a; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem66a; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem75a; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aItem75aDes; 0)  //Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(aItem75b; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem108a; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aItem108aD; 0)  //Command Replaced was o_ARRAY string length was 26
ARRAY TEXT:C222(aItem75bDes; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(BINa7FDescr_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(BINaFeatDescr_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(IDa7FDescr_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(IDaFeatDescr_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(a7FDescr_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(aDefCAT_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aDefCode_; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aDirDescr_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aDirIndex_; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(aFeatDescr_; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(aIt8BrCatDes_; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(aIt8OwnerDes_; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(aKeyCodes_; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aKeyDescr_; 0)  //Command Replaced was o_ARRAY string length was 35
ARRAY TEXT:C222(aRatCAT1_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aRatCAT2_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aRatCAT3_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aRatCAT4_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aRatCode_; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aRatingFT_; 0)  //Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222(aTownName_; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aUORCAT_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aUORCode_; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aTempBridgeC_; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aTempBridge_; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aNBIPages; 0)  //moved here.... 2004-05-05//Command Replaced was o_ARRAY string length was 25


pFile:=->[Bridge MHD NBIS:1]
DefInLay:="Bridge Input"  //Default input layout
//If (Current user="designer")
DefOutLay:="NewNBIS_StackInfo"
//Else 
//DefOutLay:="NBIS Stack Info"  //Default output layout
//End if 

//Popup menus for SI & A stuff

$v_Part1_L:=Milliseconds:C459
C_LONGINT:C283($loop_L)

COPY ARRAY:C226(<>aMonths; aMonths)
COPY ARRAY:C226(<>aMonthI; aMonthI)
COPY ARRAY:C226(<>aMaintCod; aItem21)
COPY ARRAY:C226(<>aMaintOwner; aItem21Des)
dev_mergeCodeAndDesc(->aItem21Des; ->aItem21)
COPY ARRAY:C226(<>aMaintCod; aItem22)
COPY ARRAY:C226(<>aMaintOwner; aItem22Des)
dev_mergeCodeAndDesc(->aItem22Des; ->aItem22)

COPY ARRAY:C226(<>aFC_Cod; aItem26)
COPY ARRAY:C226(<>aFC; aItem26Des)
dev_mergeCodeAndDesc(->aItem26Des; ->aItem26)
COPY ARRAY:C226(<>aDesLoadCod; aItem31)
COPY ARRAY:C226(<>aDesignLoad; aItem31Des)
dev_mergeCodeAndDesc(->aItem31Des; ->aItem31)
COPY ARRAY:C226(<>aPostCode; aItem41)
COPY ARRAY:C226(<>aPosting; aItem41Des)
dev_mergeCodeAndDesc(->aItem41Des; ->aItem41)
COPY ARRAY:C226(<>aSerOvrCode; aItem42a)
COPY ARRAY:C226(<>aServiceOvr; aItem42aDes)
dev_mergeCodeAndDesc(->aItem42aDes; ->aItem42a)
COPY ARRAY:C226(<>aSerUndrCod; aItem42b)
COPY ARRAY:C226(<>aServUndr; aItem42bDes)
dev_mergeCodeAndDesc(->aItem42bDes; ->aItem42b)
COPY ARRAY:C226(<>aMatCode; aItem43a)
COPY ARRAY:C226(<>aMaterial; aItem43aDes)
dev_mergeCodeAndDesc(->aItem43aDes; ->aItem43a)
COPY ARRAY:C226(<>aMatCode; aItem44a)
COPY ARRAY:C226(<>aMaterial; aItem44aDes)
dev_mergeCodeAndDesc(->aItem44aDes; ->aItem44a)
COPY ARRAY:C226(<>aDesignCod; aItem43b)
COPY ARRAY:C226(<>aDesign; aItem43bDes)
dev_mergeCodeAndDesc(->aItem43bDes; ->aItem43b)
COPY ARRAY:C226(<>aDesignCod; aItem44b)
COPY ARRAY:C226(<>aDesign; aItem44bDes)
dev_mergeCodeAndDesc(->aItem44bDes; ->aItem44b)
COPY ARRAY:C226(<>aTruckCod; aItem64a)
COPY ARRAY:C226(<>aTruck; aItem64aDes)
dev_mergeCodeAndDesc(->aItem64aDes; ->aItem64a)
COPY ARRAY:C226(<>aTruckCod; aItem66a)
COPY ARRAY:C226(<>aTruck; aItem66aDes)
dev_mergeCodeAndDesc(->aItem66aDes; ->aItem66a)
COPY ARRAY:C226(<>aDirCode; aItem102)
COPY ARRAY:C226(<>aDirection; aItem102Des)
dev_mergeCodeAndDesc(->aItem102Des; ->aItem102)
COPY ARRAY:C226(<>aDeckCod; aItem107)
COPY ARRAY:C226(<>aDeck; aItem107Des)
dev_mergeCodeAndDesc(->aItem107Des; ->aItem107)
COPY ARRAY:C226(<>aWearCod; aItem108a)
COPY ARRAY:C226(<>aWearing; aItem108aD)
dev_mergeCodeAndDesc(->aItem108aD; ->aItem108a)
COPY ARRAY:C226(<>aMembCod; aItem108b)
COPY ARRAY:C226(<>aMembrane; aItem108bD)
dev_mergeCodeAndDesc(->aItem108bD; ->aItem108b)
COPY ARRAY:C226(<>aDeckPCod; aItem108c)
COPY ARRAY:C226(<>aDeckProt; aItem108cD)
dev_mergeCodeAndDesc(->aItem108cD; ->aItem108c)
COPY ARRAY:C226(<>aTypeofWCod; aItem75a)
COPY ARRAY:C226(<>aTypeofWork; aItem75aDes)
dev_mergeCodeAndDesc(->aItem75aDes; ->aItem75a)
COPY ARRAY:C226(<>aWdoneBCod; aItem75b)
COPY ARRAY:C226(<>aWorkDoneBy; aItem75bDes)
dev_mergeCodeAndDesc(->aItem75bDes; ->aItem75b)
COPY ARRAY:C226(<>aItem20; aItem20_)
COPY ARRAY:C226(<>aItem20des; aItem20des_)
dev_mergeCodeAndDesc(->aItem20des_; ->aItem20_)
COPY ARRAY:C226(<>aItem33; aItem33_)
COPY ARRAY:C226(<>aItem33des; aItem33des_)
dev_mergeCodeAndDesc(->aItem33des_; ->aItem33_)
COPY ARRAY:C226(<>aItem38; aItem38_)
COPY ARRAY:C226(<>aItem38des; aItem38des_)
dev_mergeCodeAndDesc(->aItem38des_; ->aItem38_)
COPY ARRAY:C226(<>aItem37; aItem37_)
COPY ARRAY:C226(<>aItem37des; aItem37des_)
dev_mergeCodeAndDesc(->aItem37des_; ->aItem37_)
COPY ARRAY:C226(<>aItem100; aItem100_)
COPY ARRAY:C226(<>aItem100des; aItem100d_)
dev_mergeCodeAndDesc(->aItem100d_; ->aItem100_)
COPY ARRAY:C226(<>aItem101; aItem101_)
COPY ARRAY:C226(<>aItem101des; aItem101d_)
dev_mergeCodeAndDesc(->aItem101d_; ->aItem101_)
COPY ARRAY:C226(<>aItem111; aItem111_)
COPY ARRAY:C226(<>aItem111des; aItem111d_)
dev_mergeCodeAndDesc(->aItem111d_; ->aItem111_)
COPY ARRAY:C226(<>aFndCode; aFndCode_)
COPY ARRAY:C226(<>aFndtion; aFndtion_)
COPY ARRAY:C226(<>aInspRcod; aInspRcod_)
COPY ARRAY:C226(<>aInspRdes; aInspRdes_)
COPY ARRAY:C226(<>aInspCod; aInspCod_)
COPY ARRAY:C226(<>aInspType; aInspType_)
COPY ARRAY:C226(<>aCulInspCod; aCulInspC_)
COPY ARRAY:C226(<>aCulvertI; aCulvertI_)
COPY ARRAY:C226(<>aPostStat; aPostStat_)
COPY ARRAY:C226(<>aPostStatC; aPostStatC_)
COPY ARRAY:C226(<>aRatingMeth; aORatMeth_)
COPY ARRAY:C226(<>aRatMethDes; aORatMethD_)
dev_mergeCodeAndDesc(->aORatMethD_; ->aORatMeth_)

COPY ARRAY:C226(<>aRatingMeth; aIRatMeth_)
COPY ARRAY:C226(<>aRatMethDes; aIRatMethD_)
dev_mergeCodeAndDesc(->aIRatMethD_; ->aIRatMeth_)

COPY ARRAY:C226(<>aIntegralC; aIntegralC_)
COPY ARRAY:C226(<>aIntegralD; aIntegralD_)
dev_mergeCodeAndDesc(->aIntegralD_; ->aIntegralC_)
COPY ARRAY:C226(<>aTownName; aTownName_)
COPY ARRAY:C226(<>aKeyCodes; aKeyCodes_)
COPY ARRAY:C226(<>aKeyDescr; aKeyDescr_)
//Added code on 1/10/2000
COPY ARRAY:C226(<>aFeatDescr; aFeatDescr_)
COPY ARRAY:C226(<>aFeatCodes; aFeatCodes_)
COPY ARRAY:C226(<>a7FDescr; a7FDescr_)
COPY ARRAY:C226(<>a7FCodes; a7FCodes_)
//End of code added on 1/10/2000
//Added code on 11/16/2000
COPY ARRAY:C226(<>aFeatDescr; IDaFeatDescr_)
COPY ARRAY:C226(<>aFeatCodes; IDaFeatCodes_)
COPY ARRAY:C226(<>a7FDescr; IDa7FDescr_)
COPY ARRAY:C226(<>a7FCodes; IDa7FCodes_)
//End of code added on 11/16/2000
//Added code on 11/17/2000
COPY ARRAY:C226(<>aFeatDescr; BINaFeatDescr_)
COPY ARRAY:C226(<>aFeatCodes; BINaFeatCodes_)
COPY ARRAY:C226(<>a7FDescr; BINa7FDescr_)
COPY ARRAY:C226(<>a7FCodes; BINa7FCodes_)
//End of code added on 11/17/2000
COPY ARRAY:C226(<>aDirIndex; aDirIndex_)
COPY ARRAY:C226(<>aDirDescr; aDirDescr_)
COPY ARRAY:C226(<>aRatingFT; aRatingFT_)
//3/17/2001 ASL - need three popup menus but only one coding array
COPY ARRAY:C226(<>aRatCAT; aRatCAT1_)
COPY ARRAY:C226(<>aRatCAT; aRatCAT2_)
COPY ARRAY:C226(<>aRatCAT; aRatCAT3_)
//6/22/2002 ASL for previous underwater rating
COPY ARRAY:C226(<>aRatCAT; aRatCAT4_)  //For prev UW rating
COPY ARRAY:C226(<>aRatCode; aRatCode_)
COPY ARRAY:C226(<>aDefCAT; aDefCAT_)
COPY ARRAY:C226(<>aDefCode; aDefCode_)
COPY ARRAY:C226(<>aUORCAT; aUORCAT_)
COPY ARRAY:C226(<>aUORCode; aUORCode_)
//End of code added 3/17/2001 ASL

//6/22/2001 - To code insp level in roman numerals
COPY ARRAY:C226(<>aInspLevel; aInspLevel_)
COPY ARRAY:C226(<>aInspLevelCod; aInspLevelCod_)
//end of 6/22/2001 code

//Added code on 01/26/2001
COPY ARRAY:C226(<>aIt8OwnerDes; aIt8OwnerDes_)
COPY ARRAY:C226(<>aIt8OwnerCode; aIt8OwnerCode_)
COPY ARRAY:C226(<>aIt8BrCatDes; aIt8BrCatDes_)
COPY ARRAY:C226(<>aIt8BrCatCode; aIt8BrCatCode_)
//End of code added on 01/26/2001

COPY ARRAY:C226(<>aTempBridge; aTempBridge_)
COPY ARRAY:C226(<>aTempBridgeC; aTempBridgeC_)

//````````````begin: added code on 8/27/2003 for Bridge Design Sheet
ARRAY TEXT:C222(aDesign_Scour; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(aTrans_Scour; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aDesign_Deck; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aTrans_Deck; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aDesign_SuperStr; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aTrans_SuperStr; 0)  //Fixed 2003-10-17//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aTrans_WearingSurface; 0)  //Command Replaced was o_ARRAY string length was 2
COPY ARRAY:C226(<>aDesign_Scour; aDesign_Scour)
COPY ARRAY:C226(<>aTrans_Scour; aTrans_Scour)
COPY ARRAY:C226(<>aDesign_Deck; aDesign_Deck)
COPY ARRAY:C226(<>aTrans_Deck; aTrans_Deck)
COPY ARRAY:C226(<>aDesign_SuperStr; aDesign_SuperStr)
COPY ARRAY:C226(<>aTrans_SuperStr; aTrans_SuperStr)
COPY ARRAY:C226(<>aTrans_WearingSurface; aTrans_WearingSurface)
//````````````end: added code on 8/27/2003

ARRAY TEXT:C222(aFreezeThawDesc_; 0)  //Freeze Thaw arrays//Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(aFreezeThawCode_; 0)  //Command Replaced was o_ARRAY string length was 2
If (Type:C295(<>aFreezeThawDesc)=Text array:K8:16)
	COPY ARRAY:C226(<>aFreezeThawDesc; aFreezeThawDesc_)
	COPY ARRAY:C226(<>aFreezeThawCode; aFreezeThawCode_)
End if 

//Array for changes
ARRAY POINTER:C280(ptr_Changes; 0; 0)

//5/14/2001 ASL
//Arrays for element dict
ARRAY TEXT:C222(aElementCat_; 5)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aElementCatCode_; 5)  //Command Replaced was o_ARRAY string length was 3
aElementCat_{1}:="Item 58 Deck"
aElementCat_{2}:="Item 59 Superstructure"
aElementCat_{3}:="Item 60 Substructure"
aElementCat_{4}:="Item 61 Channel & Channel Protection"
aElementCat_{5}:="Item 62 Culverts"
aElementCatCode_{1}:="N58"
aElementCatCode_{2}:="N59"
aElementCatCode_{3}:="N60"
aElementCatCode_{4}:="N61"
aElementCatCode_{5}:="N62"
$v_Part2_L:=Milliseconds:C459
If (False:C215)
	//5/21/2001 ASL
	//Drop down menu for [ElementDict];"NewElement"
	ARRAY TEXT:C222(aParent_; 0)  //Command Replaced was o_ARRAY string length was 40
	ARRAY INTEGER:C220(aParentCode_; 0)
	ARRAY TEXT:C222(aParentCat_; 0)  //Command Replaced was o_ARRAY string length was 3
	QUERY:C277([ElementDict:30]; [ElementDict:30]IsParent:5=True:C214)
	ORDER BY:C49([ElementDict:30]; [ElementDict:30]ElementNo:1; >)
	SELECTION TO ARRAY:C260([ElementDict:30]Description:2; aParent_; [ElementDict:30]ElementNo:1; aParentCode_; [ElementDict:30]Category:3; aParentCat_)
	REDUCE SELECTION:C351([ElementDict:30]; 0)
	INSERT IN ARRAY:C227(aParent_; 1)
	INSERT IN ARRAY:C227(aParentCode_; 1)
	INSERT IN ARRAY:C227(aParentCat_; 1)
	aParent_{1}:="none"
	aParentCode_{1}:=0
	aParentCat_{1}:=""
End if 

$v_Part3_L:=Milliseconds:C459
//Images
ARRAY TEXT:C222(aPictCode; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aPictType; 0)  //Command Replaced was o_ARRAY string length was 15
LIST TO ARRAY:C288("PictureCode"; aPictCode)
LIST TO ARRAY:C288("PictureCodeDescr"; aPictType)

//Inspection form arrays
ARRAY TEXT:C222(aCollisionCode; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aCollisionDamage; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aScour; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI59CollisionDamage; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI59LoadDefl; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI59LoadVibr; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aStreamFlow; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI62Scour; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI62CollisionDamage; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI62LoadVibration; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aStreamCode; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aPedTraffNE; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aPedTraffSW; 0)  //Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(aPedTraffCode; 0)  //Command Replaced was o_ARRAY string length was 2

ARRAY TEXT:C222(aI62aCollisionDamage; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI62bCollisionDamage; 0)  //Command Replaced was o_ARRAY string length was 20

LIST TO ARRAY:C288("DamageType"; aCollisionDamage)
LIST TO ARRAY:C288("DamageType"; aScour)
LIST TO ARRAY:C288("DamageType"; aI59CollisionDamage)
LIST TO ARRAY:C288("DamageType"; aI62aCollisionDamage)
LIST TO ARRAY:C288("DamageType"; aI62bCollisionDamage)

LIST TO ARRAY:C288("DamageType"; aI59LoadDefl)
LIST TO ARRAY:C288("DamageType"; aI59LoadVibr)
LIST TO ARRAY:C288("DamageType"; aI62Scour)
LIST TO ARRAY:C288("DamageType"; aI62CollisionDamage)
LIST TO ARRAY:C288("DamageType"; aI62LoadVibration)
LIST TO ARRAY:C288("DamageCode"; aCollisionCode)
LIST TO ARRAY:C288("StreamVelocity"; aStreamFlow)
LIST TO ARRAY:C288("StreamVelocityCode"; aStreamCode)
LIST TO ARRAY:C288("PedTraffic"; aPedTraffNE)
LIST TO ARRAY:C288("PedTraffic"; aPedTraffSW)
LIST TO ARRAY:C288("PedTrafficCode"; aPedTraffCode)

//````````````begin: added code on 11/18/2003 for 4D Word Templates
//ARRAY STRING(20;aDBIEphone;0)
//LIST TO ARRAY("DBIE Phone No";aDBIEphone)
INI_LoadDBIEPhones
//````````````end: added code on 11/13/2003

//added variable for destination
C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
vsForward:=<>Forward
$v_Part4_L:=Milliseconds:C459

//Arrays for Personnel Data entry
//InitPers 
ut_RetrievePersArraysDoc
$v_Part5_L:=Milliseconds:C459

INIT_BMS
$v_Part6_L:=Milliseconds:C459

SET DATABASE PARAMETER:C642(49; 2)

CLOSE WINDOW:C154
If (Shift down:C543)
	C_TEXT:C284(Msg)
	Msg:="Part 1 : "+String:C10($v_Part1_L-$v_startMili_L)+Char:C90(13)
	Msg:=Msg+"Part 2 copy arrays : "+String:C10($v_Part2_L-$v_Part1_L)+Char:C90(13)
	Msg:=Msg+"Part 3  Elmt dict: "+String:C10($v_Part3_L-$v_Part2_L)+Char:C90(13)
	Msg:=Msg+"Part 4 copy lists : "+String:C10($v_Part4_L-$v_Part3_L)+Char:C90(13)
	Msg:=Msg+"Part 5  initpers: "+String:C10($v_Part5_L-$v_Part4_L)+Char:C90(13)
	Msg:=Msg+"Part 6 initbms : "+String:C10($v_Part6_L-$v_Part5_L)+Char:C90(13)
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Dialogs:21]; "stats"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; 0; $Title_txt; "ut_CloseCancel")
	//$ref:=Open form window([Dialogs];"stats";0)
	DIALOG:C40([Dialogs:21]; "stats")
	CLOSE WINDOW:C154($Win_l)
	Msg:=""
End if 