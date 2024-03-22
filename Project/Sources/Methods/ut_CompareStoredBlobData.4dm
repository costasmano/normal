//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/03/06, 10:15:19
	// ----------------------------------------------------
	// Method: ut_CompareStoredBlobData
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(10/22/2007 08:54:01)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(12/19/07 10:19:19)
	Mods_2007_CM_5401
	//Added IsPar_b array for element dict
	// Modified by: costasmanousakis-(Designer)-(10/1/08 09:18:11)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//Changed size of $Temp_A_DesLoadCod to A(2)
	// Modified by: costasmanousakis-(Designer)-(1/18/11 15:28:19)
	Mods_2011_01
	//` Rail Road changes
	// Modified by: costasmanousakis-(Designer)-(3/23/11 16:25:30)
	Mods_2011_03
	//Bug Fix in declaration of $Temp_A_CatDesc_as, $Temp_A_CatCode_as
	Mods_2013_05  //r001 `  Changed to use local arrays for comparison
	//Modified by: Charles Miller (5/2/13 16:32:34)
End if 
C_TEXT:C284($1; $OPTION)

If (Count parameters:C259=1)
	$OPTION:="INIT"
Else 
	C_BOOLEAN:C305($0; $UseFile_b; $ArraysSame_b)
	$OPTION:=""
End if 
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)
Case of 
	: ($OPTION="")
		$UseFile_b:=False:C215
		$ArraysSame_b:=False:C215
		$Filename:="InitVariables.txt"
		$UseFile_b:=ut_LoadBlobArrDoc($Filename)
		If ($UseFile_b=True:C214)
			C_LONGINT:C283($BlobOffSet_l)
			$ArraysSame_b:=True:C214
			
			ut_CompareStoredBlobData("INIT")
			
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_MaintOwner; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_MaintCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_FC; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_FC_Cod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DesignLoad; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DesLoadCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Posting; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_PostCode; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_ServiceOvr; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_SerOvrCode; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_ServUndr; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_SerUndrCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Material; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_MatCode; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Design; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DesignCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Truck; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_TruckCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Direction; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DirCode; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Deck; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DeckCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Wearing; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_WearCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Membrane; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_MembCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DeckProt; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_DeckPCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_TypeofWork; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_TypeofWCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_WorkDoneBy; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_WdoneBCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item20des; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item20; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item33des; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item33; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item38des; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item38; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item37des; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item37; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item100des; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item100; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item101des; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item101; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item111des; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Item111; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Fndtion; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_FndCode; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_InspRdes; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_InspRcod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_PostStat; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_PostStatC; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_InspType; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_InspCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_CulvertI; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_CulInspCod; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_RatingMeth; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_RatMethDes; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_IntegralC; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_IntegralD; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_ELNum_ai; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Cat_as; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Parent_ai; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Prefix_as; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Part_as; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_Txt_as; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_IsPar_ab; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_CatDesc_as; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBLobDocArrays; $Temp_A_CatCode_as; $BlobOffSet_l)
			
			Case of 
				: (Not:C34(F_CompareArrays(->$Temp_A_MaintOwner; -><>aMaintOwner)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_MaintCod; -><>aMaintCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_FC; -><>aFC)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_FC_Cod; -><>aFC_Cod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_DesignLoad; -><>aDesignLoad)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_DesLoadCod; -><>aDesLoadCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Posting; -><>aPosting)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_PostCode; -><>aPostCode)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_ServiceOvr; -><>aServiceOvr)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_SerOvrCode; -><>aSerOvrCode)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_ServUndr; -><>aServUndr)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_SerUndrCod; -><>aSerUndrCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Material; -><>aMaterial)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_MatCode; -><>aMatCode)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Design; -><>aDesign)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_DesignCod; -><>aDesignCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Truck; -><>aTruck)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_TruckCod; -><>aTruckCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Direction; -><>aDirection)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_DirCode; -><>aDirCode)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Deck; -><>aDeck)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_DeckCod; -><>aDeckCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Wearing; -><>aWearing)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_WearCod; -><>aWearCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Membrane; -><>aMembrane)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_MembCod; -><>aMembCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_DeckProt; -><>aDeckProt)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_DeckPCod; -><>aDeckPCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_TypeofWork; -><>aTypeofWork)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_TypeofWCod; -><>aTypeofWCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_WorkDoneBy; -><>aWorkDoneBy)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_WdoneBCod; -><>aWdoneBCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item20des; -><>aItem20des)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item20; -><>aItem20)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item33des; -><>aItem33des)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item33; -><>aItem33)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item38des; -><>aItem38des)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item38; -><>aItem38)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item37des; -><>aItem37des)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item37; -><>aItem37)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item100des; -><>aItem100des)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item100; -><>aItem100)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item101des; -><>aItem101des)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item101; -><>aItem101)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item111des; -><>aItem111des)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Item111; -><>aItem111)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Fndtion; -><>aFndtion)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_FndCode; -><>aFndCode)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_InspRdes; -><>aInspRdes)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_InspRcod; -><>aInspRcod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_PostStat; -><>aPostStat)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_PostStatC; -><>aPostStatC)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_InspType; -><>aInspType)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_InspCod; -><>aInspCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_CulvertI; -><>aCulvertI)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_CulInspCod; -><>aCulInspCod)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_RatingMeth; -><>aRatingMeth)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_RatMethDes; -><>aRatMethDes)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_IntegralC; -><>aIntegralC)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_IntegralD; -><>aIntegralD)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_ELNum_ai; -><>ELMTDICT_ELNum_ai)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Cat_as; -><>ELMTDICT_Cat_as)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Parent_ai; -><>ELMTDICT_Parent_ai)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Prefix_as; -><>ELMTDICT_Prefix_as)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Part_as; -><>ELMTDICT_Part_as)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_Txt_as; -><>ELMTDICT_Txt_as)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_IsPar_ab; -><>ELMTDICT_IsPar_ab)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_CatDesc_as; -><>ALLElmtCatDesc_as)))
					$ArraysSame_b:=False:C215
				: (Not:C34(F_CompareArrays(->$Temp_A_CatCode_as; -><>ALLElmtCatCode_as)))
					$ArraysSame_b:=False:C215
					
			End case 
			
			ut_CompareStoredBlobData("INIT")
			
		End if 
		
		SET BLOB SIZE:C606(vBlobDocArrays; 0)
		$Filename:=""
		$0:=$ArraysSame_b
		
	: ($OPTION="INIT")
		ARRAY TEXT:C222($Temp_A_MaintOwner; 0)  //Command Replaced was o_ARRAY string length was 27
		ARRAY TEXT:C222($Temp_A_MaintCod; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($Temp_A_FC; 0)  //Command Replaced was o_ARRAY string length was 23
		ARRAY TEXT:C222($Temp_A_FC_Cod; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($Temp_A_DesignLoad; 0)  //Command Replaced was o_ARRAY string length was 19
		ARRAY TEXT:C222($Temp_A_DesLoadCod; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($Temp_A_Posting; 0)  //Command Replaced was o_ARRAY string length was 32
		ARRAY TEXT:C222($Temp_A_PostCode; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_ServiceOvr; 0)  //Command Replaced was o_ARRAY string length was 24
		ARRAY TEXT:C222($Temp_A_SerOvrCode; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_ServUndr; 0)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($Temp_A_SerUndrCod; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Material; 0)  //Command Replaced was o_ARRAY string length was 30
		ARRAY TEXT:C222($Temp_A_MatCode; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Design; 0)  //Command Replaced was o_ARRAY string length was 40
		ARRAY TEXT:C222($Temp_A_DesignCod; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($Temp_A_Truck; 0)  //Command Replaced was o_ARRAY string length was 30
		ARRAY TEXT:C222($Temp_A_TruckCod; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Direction; 0)  //Command Replaced was o_ARRAY string length was 28
		ARRAY TEXT:C222($Temp_A_DirCode; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Deck; 0)  //Command Replaced was o_ARRAY string length was 25
		ARRAY TEXT:C222($Temp_A_DeckCod; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Wearing; 0)  //Command Replaced was o_ARRAY string length was 26
		ARRAY TEXT:C222($Temp_A_WearCod; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Membrane; 0)  //Command Replaced was o_ARRAY string length was 26
		ARRAY TEXT:C222($Temp_A_MembCod; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_DeckProt; 0)  //Command Replaced was o_ARRAY string length was 26
		ARRAY TEXT:C222($Temp_A_DeckPCod; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_TypeofWork; 0)  //Command Replaced was o_ARRAY string length was 60
		ARRAY TEXT:C222($Temp_A_TypeofWCod; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($Temp_A_WorkDoneBy; 0)  //Command Replaced was o_ARRAY string length was 30
		ARRAY TEXT:C222($Temp_A_WdoneBCod; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Item20des; 0)  //Command Replaced was o_ARRAY string length was 65
		ARRAY TEXT:C222($Temp_A_Item20; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Item33des; 0)  //Command Replaced was o_ARRAY string length was 42
		ARRAY TEXT:C222($Temp_A_Item33; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Item38des; 0)  //Command Replaced was o_ARRAY string length was 40
		ARRAY TEXT:C222($Temp_A_Item38; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Item37des; 0)  //Command Replaced was o_ARRAY string length was 60
		ARRAY TEXT:C222($Temp_A_Item37; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Item100des; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222($Temp_A_Item100; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Item101des; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222($Temp_A_Item101; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Item111des; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222($Temp_A_Item111; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_Fndtion; 0)  //Command Replaced was o_ARRAY string length was 60
		ARRAY TEXT:C222($Temp_A_FndCode; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($Temp_A_InspRdes; 0)  //Command Replaced was o_ARRAY string length was 45
		ARRAY TEXT:C222($Temp_A_InspRcod; 0)  //Command Replaced was o_ARRAY string length was 5
		ARRAY TEXT:C222($Temp_A_PostStat; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY TEXT:C222($Temp_A_PostStatC; 0)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222($Temp_A_InspType; 0)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($Temp_A_InspCod; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($Temp_A_CulvertI; 0)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($Temp_A_CulInspCod; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($Temp_A_RatingMeth; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_RatMethDes; 0)  //Command Replaced was o_ARRAY string length was 50
		ARRAY TEXT:C222($Temp_A_IntegralC; 0)  //Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($Temp_A_IntegralD; 0)  //Command Replaced was o_ARRAY string length was 40
		ARRAY INTEGER:C220($Temp_A_ELNum_ai; 0)
		ARRAY TEXT:C222($Temp_A_Cat_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY INTEGER:C220($Temp_A_Parent_ai; 0)
		ARRAY TEXT:C222($Temp_A_Prefix_as; 0)  //Command Replaced was o_ARRAY string length was 10
		ARRAY TEXT:C222($Temp_A_Part_as; 0)  //Command Replaced was o_ARRAY string length was 10
		ARRAY TEXT:C222($Temp_A_Txt_as; 0)  //Command Replaced was o_ARRAY string length was 40
		ARRAY BOOLEAN:C223($Temp_A_IsPar_ab; 0)
		ARRAY TEXT:C222($Temp_A_CatDesc_as; 0)  //Command Replaced was o_ARRAY string length was 15
		ARRAY TEXT:C222($Temp_A_CatCode_as; 0)  //Command Replaced was o_ARRAY string length was 3
		
End case 