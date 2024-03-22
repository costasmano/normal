//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_QueryForDetailReport
// User name (OS): cjmiller
// Date and time: 11/17/04, 16:45:15
// ----------------------------------------------------
// Description
// 

//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2009_12  // r004 CJ Miller`12/29/09, 15:09:39      ``Add [Bridge MHD NBIS]LegacyOwner to SD Data
End if 


C_LONGINT:C283($1; $QryNumber_l)
$QryNumber_l:=$1

C_TEXT:C284($2; $3; $4; $Month_txt; $Year_txt; $AddedorRemove_txt)
$Month_txt:=$2
$Year_txt:=$3
$AddedorRemove_txt:=$4
QUERY:C277([SD_History:89]; [SD_History:89]SD_Month:3=$Month_txt; *)
QUERY:C277([SD_History:89];  & [SD_History:89]SD_Year:2=$Year_txt)

Case of 
	: ($QryNumber_l=1)
		Case of 
			: (<>SD_IncludeALL_l=1)  //we are reporting all owners
				QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_DefectAddRemoveStatus_s:16=$AddedorRemove_txt; *)
				QUERY SELECTION:C341([SD_History:89];  | ; [SD_History:89]SD_DefectAddRemoveStatus_s:16="B")
				//: (◊SD_SubTotalByOwner_l=1)  `we are subtotaling by owner
				//QUERY SELECTION([SD_History];[SD_History]SD_DefectAddRemoveStatus_s=$AddedorRemove_txt;*)
				//QUERY SELECTION([SD_History]; | ;[SD_History]SD_DefectAddRemoveStatus_s="B")
				//QUERY SELECTION([SD_History];[SD_History]SD_Owner_s=SD_OwnerToQuery_s)
			Else   // we are reporting on selected owners
				QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_DefectAddRemoveStatus_s:16=$AddedorRemove_txt; *)
				QUERY SELECTION:C341([SD_History:89];  | ; [SD_History:89]SD_DefectAddRemoveStatus_s:16="B")
				CREATE SET:C116([SD_History:89]; "CurrentSet")
				SET QUERY DESTINATION:C396(Into set:K19:2; "OwnerSet")
				If (<>SD_UseLegacy_l=0)
					QUERY WITH ARRAY:C644([SD_History:89]SD_Owner_s:17; aIt8OwnerDesIncludedCode)
				Else 
					QUERY WITH ARRAY:C644([SD_History:89]SD_PreviousOwner_s:19; aIt8OwnerDesIncludedCode)
				End if 
				
				INTERSECTION:C121("CurrentSet"; "OwnerSet"; "CurrentSet")
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				USE SET:C118("CurrentSet")
				CLEAR SET:C117("CurrentSet")
				CLEAR SET:C117("OwnerSet")
				
				//QUERY SELECTION([SD_History];[SD_History]SD_Owner_s=aIt8OwnerCode{aIt8OwnerDes})
		End case 
		
	: ($QryNumber_l=2)
		Case of 
			: (<>SD_IncludeALL_l=1)
				QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_PostedAddRemoveStatus_s:18=$AddedorRemove_txt; *)
				QUERY SELECTION:C341([SD_History:89];  | ; [SD_History:89]SD_PostedAddRemoveStatus_s:18="B")
				//: (◊SD_SubTotalByOwner_l=1)  `we are subtotaling by owner
				//QUERY SELECTION([SD_History];[SD_History]SD_PostedAddRemoveStatus_s=$AddedorRemove_txt;*)
				//QUERY SELECTION([SD_History]; | ;[SD_History]SD_PostedAddRemoveStatus_s="B")
				//QUERY SELECTION([SD_History];[SD_History]SD_Owner_s=SD_OwnerToQuery_s)
			Else   // we are reporting on selected owners
				QUERY SELECTION:C341([SD_History:89]; [SD_History:89]SD_PostedAddRemoveStatus_s:18=$AddedorRemove_txt; *)
				QUERY SELECTION:C341([SD_History:89];  | ; [SD_History:89]SD_PostedAddRemoveStatus_s:18="B")
				CREATE SET:C116([SD_History:89]; "CurrentSet")
				SET QUERY DESTINATION:C396(Into set:K19:2; "OwnerSet")
				If (<>SD_UseLegacy_l=0)
					QUERY WITH ARRAY:C644([SD_History:89]SD_Owner_s:17; aIt8OwnerDesIncludedCode)
				Else 
					QUERY WITH ARRAY:C644([SD_History:89]SD_PreviousOwner_s:19; aIt8OwnerDesIncludedCode)
				End if 
				
				INTERSECTION:C121("CurrentSet"; "OwnerSet"; "CurrentSet")
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				USE SET:C118("CurrentSet")
				CLEAR SET:C117("CurrentSet")
				CLEAR SET:C117("OwnerSet")
				//QUERY SELECTION([SD_History];[SD_History]SD_Owner_s=aIt8OwnerCode{aIt8OwnerDes})
		End case 
End case 


//End SD_QueryForDetailReport
