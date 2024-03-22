//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/29/08, 14:56:17
	// ----------------------------------------------------
	// Method: INIT_FIELDS_ARRAYS
	// Description
	// Declare global arrays used in method Init_Fields_DES.
	// Added comments to show matching process arrays. 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
	// Modified by: costasmanousakis-(Designer)-(10/1/08 09:18:11)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//Changed size of ◊aDesLoadCod to A(2)
	// Modified by: costasmanousakis-(Designer)-(1/18/11 15:25:51)
	Mods_2011_01
	//` Rail Road changes
	Mods_2013_05  //r003 ` Change [Element Cat]Description from 15 to 20 characters
	//Modified by: Charles Miller (5/7/13 14:36:10)
End if 

ARRAY TEXT:C222(<>aCulInspCod; 0)  // - aCulInspC_ - TEMP_A_CulInspCod//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(<>aCulvertI; 0)  // - aCulvertI_ - TEMP_A_CulvertI//Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(<>aDeck; 0)  // - aItem107Des - TEMP_A_Deck//Command Replaced was o_ARRAY string length was 25
ARRAY TEXT:C222(<>aDeckCod; 0)  // - aItem107 - TEMP_A_DeckCod//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aDeckPCod; 0)  // - aItem108c - TEMP_A_DeckPCod//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aDeckProt; 0)  // - aItem108cD - TEMP_A_DeckProt//Command Replaced was o_ARRAY string length was 26
ARRAY TEXT:C222(<>aDesign; 0)  // - aItem43bDes - aItem44bDes - TEMP_A_Design//Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(<>aDesignCod; 0)  // - aItem43b - aItem44b - TEMP_A_DesignCod//Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aDesignLoad; 0)  // - aItem31Des - TEMP_A_DesignLoad//Command Replaced was o_ARRAY string length was 19
ARRAY TEXT:C222(<>aDesLoadCod; 0)  // - aItem31 - TEMP_A_DesLoadCod//Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aDirCode; 0)  // - aItem102 - TEMP_A_DirCode//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aDirection; 0)  // - aItem102Des - TEMP_A_Direction//Command Replaced was o_ARRAY string length was 28
ARRAY TEXT:C222(<>aFC; 0)  // - aItem26Des - TEMP_A_FC//Command Replaced was o_ARRAY string length was 23
ARRAY TEXT:C222(<>aFC_Cod; 0)  // - aItem26 - TEMP_A_FC_Cod//Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aFndCode; 0)  // - aFndCode_ - TEMP_A_FndCode//Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aFndtion; 0)  // - aFndtion_ - TEMP_A_Fndtion//Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(<>aInspCod; 0)  // - aInspCod_ - TEMP_A_InspCod//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(<>aInspRcod; 0)  // - aInspRcod_ - TEMP_A_InspRcod//Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(<>aInspRdes; 0)  // - aInspRdes_ - TEMP_A_InspRdes//Command Replaced was o_ARRAY string length was 45
ARRAY TEXT:C222(<>aInspType; 0)  // - aInspType_ - TEMP_A_InspType//Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(<>aIntegralC; 0)  // - aIntegralC_ - TEMP_A_IntegralC//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aIntegralD; 0)  // - aIntegralD_ - TEMP_A_IntegralD//Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(<>aItem100; 0)  // - aItem100_ - TEMP_A_Item100//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aItem100des; 0)  // - aItem100d_ - TEMP_A_Item100des//Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(<>aItem101; 0)  // - aItem101_ - TEMP_A_Item101//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aItem101des; 0)  // - aItem101d_ - TEMP_A_Item101des//Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(<>aItem111; 0)  // - aItem111_ - TEMP_A_Item111//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aItem111des; 0)  // - aItem111d_ - TEMP_A_Item111des//Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(<>aItem20; 0)  // - aItem20_ - TEMP_A_Item20//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aItem20des; 0)  // - aItem20des_ - TEMP_A_Item20des//Command Replaced was o_ARRAY string length was 65
ARRAY TEXT:C222(<>aItem33; 0)  // - aItem33_ - TEMP_A_Item33//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aItem33des; 0)  // - aItem33des_ - TEMP_A_Item33des//Command Replaced was o_ARRAY string length was 42
ARRAY TEXT:C222(<>aItem37; 0)  // - aItem37_ - TEMP_A_Item37//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aItem37des; 0)  // - aItem37des_ - TEMP_A_Item37des//Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(<>aItem38; 0)  // - aItem38_ - TEMP_A_Item38//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aItem38des; 0)  // - aItem38des_ - TEMP_A_Item38des//Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(<>aMaintCod; 0)  // - aItem21 - aItem22 - TEMP_A_MaintCod//Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aMaintOwner; 0)  // - aItem21Des - aItem22Des - TEMP_A_MaintOwner//Command Replaced was o_ARRAY string length was 27
ARRAY TEXT:C222(<>aMatCode; 0)  // - aItem43a - aItem44a - TEMP_A_MatCode//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aMaterial; 0)  // - aItem43aDes - aItem44aDes - TEMP_A_Material//Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(<>aMembCod; 0)  // - aItem108b - TEMP_A_MembCod//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aMembrane; 0)  // - aItem108bD - TEMP_A_Membrane//Command Replaced was o_ARRAY string length was 26
ARRAY TEXT:C222(<>aPostCode; 0)  // - aItem41 - TEMP_A_PostCode//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aPosting; 0)  // - aItem41Des - TEMP_A_Posting//Command Replaced was o_ARRAY string length was 32
ARRAY TEXT:C222(<>aPostStat; 0)  // - aPostStat_ - TEMP_A_PostStat//Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(<>aPostStatC; 0)  // - aPostStatC_ - TEMP_A_PostStatC//Command Replaced was o_ARRAY string length was 6
ARRAY TEXT:C222(<>aRatingMeth; 0)  // - aIRatMeth_ - aORatMeth_ - TEMP_A_RatingMeth//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aRatMethDes; 0)  // - aIRatMethD_ - aORatMethD_ - TEMP_A_RatMethDes//Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(<>aSerOvrCode; 0)  // - aItem42a - TEMP_A_SerOvrCode//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aSerUndrCod; 0)  // - aItem42b - TEMP_A_SerUndrCod//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aServiceOvr; 0)  // - aItem42aDes - TEMP_A_ServiceOvr//Command Replaced was o_ARRAY string length was 24
ARRAY TEXT:C222(<>aServUndr; 0)  // - aItem42bDes - TEMP_A_ServUndr//Command Replaced was o_ARRAY string length was 15
ARRAY TEXT:C222(<>aTruck; 0)  // - aItem64aDes - aItem66aDes - TEMP_A_Truck//Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(<>aTruckCod; 0)  // - aItem64a - aItem66a - TEMP_A_TruckCod//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aTypeofWCod; 0)  // - aItem75a - TEMP_A_TypeofWCod//Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(<>aTypeofWork; 0)  // - aItem75aDes - TEMP_A_TypeofWork//Command Replaced was o_ARRAY string length was 60
ARRAY TEXT:C222(<>aWdoneBCod; 0)  // - aItem75b - TEMP_A_WdoneBCod//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aWearCod; 0)  // - aItem108a - TEMP_A_WearCod//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(<>aWearing; 0)  // - aItem108aD - TEMP_A_Wearing//Command Replaced was o_ARRAY string length was 26
ARRAY TEXT:C222(<>aWorkDoneBy; 0)  // - aItem75bDes - TEMP_A_WorkDoneBy//Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(<>ELMTDICT_Cat_as; 0)  // - TEMP_A_Cat_as//Command Replaced was o_ARRAY string length was 3
ARRAY INTEGER:C220(<>ELMTDICT_ELNum_ai; 0)  // - TEMP_A_ELNum_ai
ARRAY BOOLEAN:C223(<>ELMTDICT_IsPar_ab; 0)  // - TEMP_A_IsPar_ab
ARRAY INTEGER:C220(<>ELMTDICT_Parent_ai; 0)  // - TEMP_A_Parent_ai
ARRAY TEXT:C222(<>ELMTDICT_Part_as; 0)  // - TEMP_A_Part_as//Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222(<>ELMTDICT_Prefix_as; 0)  // - TEMP_A_Prefix_as//Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222(<>ELMTDICT_Txt_as; 0)  // - TEMP_A_Txt_as//Command Replaced was o_ARRAY string length was 40
ARRAY TEXT:C222(<>ALLElmtCatCode_as; 0)  // - TEMP_A_CatCode_as//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(<>ALLElmtCatDesc_as; 0)  // - TEMP_A_CatDesc_as//Command Replaced was o_ARRAY string length was 20