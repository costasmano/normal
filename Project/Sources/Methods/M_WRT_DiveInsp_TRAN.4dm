//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/08/08, 21:33:21
	// ----------------------------------------------------
	// Method: M_WRT_DiveInsp_TRAN
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	Mods_2011_06  //r002 CJ Miller`06/03/11, 16:11:27      `Make vDistrict alpha 2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 
C_TEXT:C284($sTransTo)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($bTownLetter)
$sTransTo:="DHD"
If (Count parameters:C259>0)
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 80
	$sTransTo:=$1
End if 
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$bTownLetter:=$2
End if 
C_TEXT:C284(vDistrict)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vPluralCopy)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vContactName; vTownName; vAddressedTo; vAddress1; vAddress2; vOfficialTownName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vDBIEInitial)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(vAssignmentList; $msg; vDiveTransToName_txt; vDiveTransToTitle_txt; vDiveTransFrom_txt; vDiveTransActing_txt; vDiveTransFromTitle_txt)
C_DATE:C307(vToday)
C_LONGINT:C283(vAssignNo)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i; $Recs; $K; $KJ; $KL; $j; $vlicount; $vlSelRecs; $vlUsrRecs)
C_BOOLEAN:C305($bCreateLetter)
C_TEXT:C284($BDept; $otherBDept; $OtherTown_s)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($district)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($town)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284($Item6; $Item7)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284($msg; $GroupbyType)

//multiple bridges
$Recs:=Records in set:C195("UserSet")

If ($Recs>20)
	CONFIRM:C162("Are you sure you want to include all the selected bridges in the letter?"; "Yes"; "No")
	If (Ok=1)
		$bCreateLetter:=True:C214
	Else 
		$bCreateLetter:=False:C215
	End if 
Else 
	$bCreateLetter:=($Recs>0)
End if 
READ ONLY:C145([Bridge MHD NBIS:1])
If ($bCreateLetter=True:C214)
	
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "PrePrintBrgList")
	$vlSelRecs:=Records in selection:C76([Bridge MHD NBIS:1])
	$vlUsrRecs:=Records in set:C195("UserSet")
	ARRAY LONGINT:C221($alRecIDS; $vlSelRecs)
	ARRAY LONGINT:C221($alURecIDs; $vlUsrRecs)
	ARRAY LONGINT:C221($alURecIDsSorted; $vlUsrRecs)
	LONGINT ARRAY FROM SELECTION:C647([Bridge MHD NBIS:1]; $alRecIDs)
	USE SET:C118("UserSet")
	LONGINT ARRAY FROM SELECTION:C647([Bridge MHD NBIS:1]; $alURecIDs)
	$vlicount:=1
	For ($i; 1; $vlSelRecs)
		If (Find in array:C230($alURecIDs; $alRecIDS{$i})>0)
			$alURecIDsSorted{$vlicount}:=$alRecIDS{$i}
			$vlicount:=$vlicount+1
		End if 
	End for 
	CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $alURecIDsSorted)
	ARRAY LONGINT:C221($alRecIDS; 0)
	ARRAY LONGINT:C221($alURecIDs; 0)
	ARRAY LONGINT:C221($alURecIDsSorted; 0)
	CREATE SET:C116([Bridge MHD NBIS:1]; "TempHilightSet")
	//USE SET("UserSet")
	READ ONLY:C145([Templates:86])
	READ ONLY:C145([TownLineInfo:73])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_DiveToDBIETransmittal")
	If (Records in selection:C76([Templates:86])=0)
		
		ALERT:C41("Document template does not exist!")
	Else 
		vToday:=Current date:C33(*)
		
		C_TEXT:C284($InspDate_txt)
		ARRAY TEXT:C222($BINS_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($DistNo_as; 0)  //Command Replaced was o_ARRAY string length was 2
		ARRAY TEXT:C222($BDEPTS_as; 0)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222($Towns_as; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY LONGINT:C221($BMSRecNums_aL; 0)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BINS_as; [Bridge MHD NBIS:1]BDEPT:1; $BDEPTS_as; [Bridge MHD NBIS:1]Town Name:175; $Towns_as)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]; $BMSRecNums_aL; [Bridge MHD NBIS:1]Item2:60; $DistNo_as)
		If ($bTownLetter)
			SORT ARRAY:C229($BDEPTS_as; $BINS_as; $Towns_as; $BMSRecNums_aL; $DistNo_as)  //sort by towns
		Else 
			SORT ARRAY:C229($DistNo_as; $BDEPTS_as; $BINS_as; $Towns_as; $BMSRecNums_aL)  //sort by district
		End if 
		
		ARRAY TEXT:C222($BridgeGrouping_atxt; 1)
		ARRAY TEXT:C222($BINMatrix; 1; 1)  //Command Replaced was o_ARRAY string length was 3
		$BINMatrix{1}{1}:=$BINS_as{1}
		$K:=1
		$Recs:=Size of array:C274($BDEPTS_as)
		If ($bTownLetter)
			$BridgeGrouping_atxt{1}:=$Towns_as{1}
			For ($i; 2; $Recs)
				If ($Towns_as{$i}=$BridgeGrouping_atxt{$K})
					INSERT IN ARRAY:C227($BINMatrix{$K}; (Size of array:C274($BINMatrix{$K})+1))
					$BINMatrix{$K}{Size of array:C274($BINMatrix{$K})}:=$BINS_as{$i}
				Else 
					$K:=$K+1
					INSERT IN ARRAY:C227($BridgeGrouping_atxt; ($K))
					$BridgeGrouping_atxt{$K}:=$Towns_as{$i}
					INSERT IN ARRAY:C227($BINMatrix; $K)
					$BINMatrix{$K}{1}:=$BINS_as{$i}
				End if 
				
			End for 
			
		Else 
			$BridgeGrouping_atxt{1}:=$DistNo_as{1}
			For ($i; 2; $Recs)
				If ($DistNo_as{$i}=$BridgeGrouping_atxt{$K})
					INSERT IN ARRAY:C227($BINMatrix{$K}; (Size of array:C274($BINMatrix{$K})+1))
					$BINMatrix{$K}{Size of array:C274($BINMatrix{$K})}:=$BINS_as{$i}
				Else 
					$K:=$K+1
					INSERT IN ARRAY:C227($BridgeGrouping_atxt; ($K))
					$BridgeGrouping_atxt{$K}:=$DistNo_as{$i}
					INSERT IN ARRAY:C227($BINMatrix; $K)
					$BINMatrix{$K}{1}:=$BINS_as{$i}
				End if 
				
			End for 
		End if 
		ARRAY TEXT:C222($TLineBINS_atxt; 0)
		ARRAY TEXT:C222($TLineBNums_atxt; 0)
		For ($i; 1; $Recs)
			GOTO RECORD:C242([Bridge MHD NBIS:1]; $BMSRecNums_aL{$i})
			If ([Bridge MHD NBIS:1]OnTwnLine:177)
				QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=[Bridge MHD NBIS:1]BIN:3)
				ARRAY TEXT:C222($TwnLineBDept_as; 0)  //Command Replaced was o_ARRAY string length was 6
				If (Records in selection:C76([TownLineInfo:73])>0)
					SELECTION TO ARRAY:C260([TownLineInfo:73]BDEPT:2; $TwnLineBDept_as)
					SORT ARRAY:C229($TwnLineBDept_as)
					For ($j; 1; Records in selection:C76([TownLineInfo:73]))
						$OtherTown_s:=Get_Town_Name($TwnLineBDept_as{$j})
						If ($OtherTown_s#"")
							If ($bTownLetter)
								$KJ:=Find in array:C230($BridgeGrouping_atxt; $OtherTown_s)
								If ($KJ>0)
									INSERT IN ARRAY:C227($BINMatrix{$KJ}; (Size of array:C274($BINMatrix{$KJ})+1))
									$BINMatrix{$KJ}{Size of array:C274($BINMatrix{$KJ})}:=$BINS_as{$i}
								Else 
									$K:=Size of array:C274($BridgeGrouping_atxt)+1
									INSERT IN ARRAY:C227($BridgeGrouping_atxt; ($K))
									$BridgeGrouping_atxt{$K}:=$OtherTown_s
									INSERT IN ARRAY:C227($BINMatrix; $K)
									$BINMatrix{$K}{1}:=$BINS_as{$i}
								End if 
							End if 
							$otherBDept:=Insert string:C231($TwnLineBDept_as{$j}; "-"; 2)
							$otherBDept:=Insert string:C231($otherBDept; "-"; 5)
							$KL:=Find in array:C230($TLineBINS_atxt; [Bridge MHD NBIS:1]BIN:3)
							If ($KL>0)
								$TLineBNums_atxt{$KL}:=$TLineBNums_atxt{$KL}+" = "+$otherBDept
							Else 
								INSERT IN ARRAY:C227($TLineBINS_atxt; (Size of array:C274($TLineBINS_atxt)+1))
								INSERT IN ARRAY:C227($TLineBNums_atxt; (Size of array:C274($TLineBINS_atxt)+1))
								$TLineBINS_atxt{Size of array:C274($TLineBINS_atxt)}:=[Bridge MHD NBIS:1]BIN:3
								$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
								$BDept:=Insert string:C231($BDept; "-"; 5)
								$BDept:=$BDept+" = "+$otherBDept
								$TLineBNums_atxt{Size of array:C274($TLineBINS_atxt)}:=$BDept
							End if 
							
						Else 
							$msg:="WARNING : Bridge Record BIN : "+[Bridge MHD NBIS:1]BIN:3
							If ($TwnLineBDept_as{$j}="")
								$msg:=$msg+" has a blank TownLine record in the MISC section!"
							Else 
								$msg:=$msg+" has a  not valid TownLine record <"+$TwnLineBDept_as{$j}+"> in the MISC section!"
							End if 
							ALERT:C41($msg)
						End if 
					End for 
				Else 
					$msg:="WARNING : Bridge Record BIN : "+[Bridge MHD NBIS:1]BIN:3+" is flagged as a TownLine Bridge "
					$msg:=$msg+"but there are no TownLine records in the MISC section!"
					ALERT:C41($msg)
				End if 
				
			End if 
		End for 
		
		If (Size of array:C274($BridgeGrouping_atxt)>1)
			$GroupbyType:="Districts"
			$msg:="Letters will be generated for "+String:C10(Size of array:C274($BridgeGrouping_atxt))+" "+$GroupbyType
			$msg:=$msg+".  You will be prompted to save each letter individually."+<>sCR
			$Msg:=$msg+" To assist you, the name of the "+$GroupbyType+" with the date of the letter"
			$msg:=$msg+" will be placed on the clipboard so it can be used in the file name."
			ALERT:C41($msg)
		End if 
		
		GetBridgeEngineer
		GetUOEInfo
		GetBIEinfo
		Case of 
			: ($sTransTo="DBIE")
				vDiveTransFrom_txt:=vBIEname
				vDiveTransActing_txt:=vBIEActing
				vDiveTransFromTitle_txt:="Bridge Inspection Engineer"
				vDiveTransToTitle_txt:="Bridge Inspection Engineer"
				
			: ($sTransTo="DHD")
				vDiveTransFrom_txt:=vBridgeEngineer
				vDiveTransActing_txt:=vBEActing
				vDiveTransFromTitle_txt:="Director of Bridges and Structures"
				vDiveTransToTitle_txt:="Highway Director"
		End case 
		C_LONGINT:C283($iTwn)
		For ($iTwn; 1; Size of array:C274($BridgeGrouping_atxt))
			QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $BINMatrix{$iTwn})
			$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
			ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >; [Bridge MHD NBIS:1]BIN:3; >)
			
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			$district:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			
			vDistrict:=$district
			GetDBIEinfo($district)
			GetDHDinfo($district)
			$town:=$BridgeGrouping_atxt{$iTwn}
			vAssignmentList:=""
			SET TEXT TO PASTEBOARD:C523($sTransTo+" "+$town+" "+String:C10(vToday; Internal date short special:K1:4))
			For ($i; 1; $Recs)
				$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
				$BDept:=Insert string:C231($BDept; "-"; 5)
				$KL:=Find in array:C230($TLineBINS_atxt; [Bridge MHD NBIS:1]BIN:3)
				If ($KL>0)
					$BDept:=$TLineBNums_atxt{$KL}
				End if 
				If (vAssignmentList="")
					vAssignmentList:=$BDept
				Else 
					vAssignmentList:=vAssignmentList+", "+$BDept
				End if 
				NEXT RECORD:C51([Bridge MHD NBIS:1])
			End for 
			Case of 
				: ($sTransTo="DBIE")
					vDiveTransToName_txt:=vDBIEname
				: ($sTransTo="DHD")
					vDiveTransToName_txt:=vDHDname
			End case 
			
			//````4D WR commands
			G_WP_MakeDocument
		End for 
		
		ARRAY TEXT:C222($BINS_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($BDEPTS_as; 0)  //Command Replaced was o_ARRAY string length was 6
		ARRAY TEXT:C222($Towns_as; 0)  //Command Replaced was o_ARRAY string length was 20
		ARRAY LONGINT:C221($BMSRecNums_aL; 0)
		ARRAY TEXT:C222($BridgeGrouping_atxt; 0)
		ARRAY TEXT:C222($BINMatrix; 0; 0)  //Command Replaced was o_ARRAY string length was 3
		
	End if 
	READ WRITE:C146([Templates:86])
	READ WRITE:C146([TownLineInfo:73])
	
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("TempHilightSet")
	CLEAR SET:C117("TempHilightSet")
	REDRAW WINDOW:C456
End if   //matches If ($bCreateLetter=True)
READ WRITE:C146([Bridge MHD NBIS:1])