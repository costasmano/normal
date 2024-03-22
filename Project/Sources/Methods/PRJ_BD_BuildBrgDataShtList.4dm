//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/25/07, 15:50:35
	// ----------------------------------------------------
	// Method: PRJ_BD_BuildBrgDataShtList
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_DataSheet
End if 
C_LONGINT:C283(PRJ_BD_BrgDataSht_hL)
If (Is a list:C621(PRJ_BD_BrgDataSht_hL))
	CLEAR LIST:C377(PRJ_BD_BrgDataSht_hL; *)
End if 

ARRAY TEXT:C222($MyBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY BOOLEAN:C223($NeworNot_ab; 0)
C_LONGINT:C283($NumExis_L; $NumNew_L; $NumBins_L; $i; $K)
SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $MyBins_as; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4; $NeworNot_ab)
$NumBins_L:=Size of array:C274($MyBins_as)
Case of 
	: ($NumBins_L=0)
		//No related BINs
	Else 
		$NumExis_L:=0
		$NumNew_L:=0
		For ($i; 1; $NumBins_L)
			If ($NeworNot_ab{$i})
				$NumNew_L:=$NumNew_L+1
			Else 
				$NumExis_L:=$NumExis_L+1
			End if 
		End for 
		QUERY WITH ARRAY:C644([Bridge Design:75]BIN:1; $MyBins_as)
		QUERY SELECTION:C341([Bridge Design:75]; [Bridge Design:75]PROJIS:2=String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3))
		ARRAY TEXT:C222($BDesignBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY LONGINT:C221($BDesignIDs_aL; 0)
		SELECTION TO ARRAY:C260([Bridge Design:75]BIN:1; $BDesignBINs_as; [Bridge Design:75]BridgeDesignID:35; $BDesignIDs_aL)
		C_LONGINT:C283($OpenExist_hL; $MakeNew_hL)
		PRJ_BD_BrgDataSht_hL:=New list:C375
		Case of 
			: (Size of array:C274($BDesignBINs_as)>1)
				SORT ARRAY:C229($BDesignBINs_as; $BDesignIDs_aL)
				//open exist enabled
				$OpenExist_hL:=New list:C375
				For ($i; 1; Size of array:C274($BDesignBINs_as))
					APPEND TO LIST:C376($OpenExist_hL; $BDesignBINs_as{$i}; $BDesignIDs_aL{$i})
				End for 
				APPEND TO LIST:C376(PRJ_BD_BrgDataSht_hL; "Open Data sheet"; (-1); $OpenExist_hL; True:C214)
			: (Size of array:C274($BDesignBINs_as)=1)
				APPEND TO LIST:C376(PRJ_BD_BrgDataSht_hL; ("Open Data sheet for BIN "+$BDesignBINs_as{1}); $BDesignIDs_aL{1})
		End case 
		//now make the sublist for make new data sheet
		If (User in group:C338(Current user:C182; "BridgeDataSheet"))
			ARRAY TEXT:C222($BDesignPossBINs_as; 0)  //Command Replaced was o_ARRAY string length was 3
			For ($i; 1; $NumBins_L)
				
				If ($NumNew_L>0)
					//If there are new- allow only the new ones
					If ($NeworNot_ab{$i})
						$K:=Find in array:C230($BDesignBINs_as; $MyBins_as{$i})
						If ($K<=0)
							INSERT IN ARRAY:C227($BDesignPossBINs_as; (Size of array:C274($BDesignPossBINs_as)+1))
							$BDesignPossBINs_as{Size of array:C274($BDesignPossBINs_as)}:=$MyBins_as{$i}
						End if 
					End if 
				Else 
					//if no new BINs then allow all
					$K:=Find in array:C230($BDesignBINs_as; $MyBins_as{$i})
					If ($K<=0)
						INSERT IN ARRAY:C227($BDesignPossBINs_as; (Size of array:C274($BDesignPossBINs_as)+1))
						$BDesignPossBINs_as{Size of array:C274($BDesignPossBINs_as)}:=$MyBins_as{$i}
					End if 
				End if 
				
			End for 
			Case of 
				: (Size of array:C274($BDesignPossBINs_as)>1)
					$MakeNew_hL:=New list:C375
					For ($i; 1; Size of array:C274($BDesignPossBINs_as))
						APPEND TO LIST:C376($MakeNew_hL; $BDesignPossBINs_as{$i}; (-100-$i))
					End for 
					APPEND TO LIST:C376(PRJ_BD_BrgDataSht_hL; "Create Data sheet"; (-2); $MakeNew_hL; True:C214)
				: (Size of array:C274($BDesignPossBINs_as)=1)
					APPEND TO LIST:C376(PRJ_BD_BrgDataSht_hL; ("Create Data sheet for BIN "+$BDesignPossBINs_as{1}); (-100-1))
					
			End case 
		End if 
End case 