//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/18/11, 15:20:47
	// ----------------------------------------------------
	// Method: PRJ_GetDataSheetFedAidNos
	// Description
	//  ` Get the FA numbers stored in the data sheets for a project Detail record.
	//
	// 
	// Parameters
	// $0 : $FedAidNos_txt
	// ----------------------------------------------------
	
	Mods_2011_08
End if 
C_TEXT:C284($0; $FedAidNos_txt)

$FedAidNos_txt:=""
READ ONLY:C145([Bridge Design:75])
ARRAY TEXT:C222($MyBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY BOOLEAN:C223($NeworNot_ab; 0)
C_LONGINT:C283($NumExis_L; $NumNew_L; $NumBins_L; $i; $K)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
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
		ARRAY TEXT:C222($BDesignFANo_atxt; 0)
		SELECTION TO ARRAY:C260([Bridge Design:75]BIN:1; $BDesignBINs_as; [Bridge Design:75]BridgeDesignID:35; $BDesignIDs_aL; [Bridge Design:75]FAPNumber:3; $BDesignFANo_atxt)
		Case of 
			: (Size of array:C274($BDesignBINs_as)>1)
				SORT ARRAY:C229($BDesignBINs_as; $BDesignIDs_aL; $BDesignFANo_atxt)
				$FedAidNos_txt:=$BDesignFANo_atxt{1}
				C_LONGINT:C283($loop_L)
				For ($loop_L; 2; Size of array:C274($BDesignFANo_atxt))
					$FedAidNos_txt:=$FedAidNos_txt+","+$BDesignFANo_atxt{$loop_L}
				End for 
				
				//open exist enabled
			: (Size of array:C274($BDesignBINs_as)=1)
				$FedAidNos_txt:=$BDesignFANo_atxt{1}
				
		End case 
		
End case 
$0:=$FedAidNos_txt