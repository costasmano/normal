//%attributes = {"invisible":true}
//Method: G_NBEElmtQuery
//Description
// Search a selection of NBEs for :
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/06/15, 14:03:38
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
	// to search for elementkey with a defectkey
	//  ` find defects with elemkey=defectkey, with parent key = elemem key
	//  `  ` then verify envkey
	//  `  ` verify parent q 
	//  `  ` verify defect q
	// to search for elementkey with a protsyskey
	//  ` find prot sys with elemkey=protsyskey, with parent key = elemem key
	// Modified by: Costas Manousakis-(Designer)-(2/23/16 17:33:02)
	Mods_2016_02_bug
	//  `continue developing code
	// Modified by: Costas Manousakis-(Designer)-(6/9/17 15:46:38)
	Mods_2017_06_bug
	//  `fix bug in calculating percent of quantity below the target state
	// Modified by: Costas Manousakis-(Designer)-(8/29/17 12:42:31)
	Mods_2017_08
	//  `adjustments / bug fixes with introduction of filtering by material / type / category
End if 
//

// Element Category
C_LONGINT:C283($iCount; $isc)
C_LONGINT:C283($Progressbar_L)
$Progressbar_L:=Progress New
Progress SET TITLE($Progressbar_L; "Applying Element Criteria")

If (PON_CATEGORIES_Desc_atxt>1)
	//***** NOT IMPLEMENTED YET ****
	//only the element category is selected  
	Case of 
			//specific element is selected    
		: (PON_MASTERELEM_Desc_atxt#0)
			QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_KEY:3=PON_MASTERELEM_KEY_aL{PON_MASTERELEM_Desc_atxt})
			
		: (PON_CATEGORIES_Desc_atxt>1)
			//***** NOT IMPLEMENTED YET ****
			//Picked category but not specific element 
			QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_CAT_KEY:5=PON_CATEGORIES_Key_atxt{PON_CATEGORIES_Desc_atxt})
			ARRAY LONGINT:C221($alSearchIDs; 0)
			SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_KEY:1; $alSearchIDs)
			QUERY SELECTION WITH ARRAY:C1050([PON_ELEM_INSP:179]ELEM_KEY:3; $alSearchIDs)
			If (False:C215)
				ARRAY LONGINT:C221($alCURecIDs; 0)
				ARRAY LONGINT:C221($alCUElIDs; 0)
				LONGINT ARRAY FROM SELECTION:C647([PON_ELEM_INSP:179]; $alCURecIDs)
				SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEM_KEY:3; $alCUElIDs)
				C_LONGINT:C283($NumCUs; $i)
				$NumCUs:=Size of array:C274($alCUElIDs)
				For ($i; $NumCUs; 1; -1)
					If (Find in array:C230($alSearchIDs; $alCUElIDs{$i})<0)
						DELETE FROM ARRAY:C228($alCURecIDs; $i)
					End if 
					
				End for 
				CREATE SELECTION FROM ARRAY:C640([PON_ELEM_INSP:179]; $alCURecIDs; "CUsFromArray")
				USE NAMED SELECTION:C332("CUsFromArray")
				CLEAR NAMED SELECTION:C333("CUsFromArray")
				
			End if 
	End case 
	
	$iCount:=Records in selection:C76([PON_ELEM_INSP:179])
End if 

If (PON_MASTERELEM_Desc_atxt#0)
	QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_KEY:3=PON_MASTERELEM_KEY_aL{PON_MASTERELEM_Desc_atxt})
Else 
	//apply filters
	If (PON_CATEGORIES_Desc_atxt>1)
		Progress SET MESSAGE($Progressbar_L; "Category ...")
		
		//Picked category but not specific element 
		QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_CAT_KEY:5=PON_CATEGORIES_Key_atxt{PON_CATEGORIES_Desc_atxt})
		ARRAY LONGINT:C221($alSearchIDs; 0)
		SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_KEY:1; $alSearchIDs)
		QUERY SELECTION WITH ARRAY:C1050([PON_ELEM_INSP:179]ELEM_KEY:3; $alSearchIDs)
		
		$iCount:=Records in selection:C76([PON_ELEM_INSP:179])
	End if 
	
	If (PON_TYPES_Desc_atxt>1)
		Progress SET MESSAGE($Progressbar_L; "Type ...")
		
		//Picked category but not specific element 
		QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_TYPE_KEY:6=PON_TYPES_KEY_atxt{PON_TYPES_Desc_atxt})
		ARRAY LONGINT:C221($alSearchIDs; 0)
		SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_KEY:1; $alSearchIDs)
		QUERY SELECTION WITH ARRAY:C1050([PON_ELEM_INSP:179]ELEM_KEY:3; $alSearchIDs)
		
		$iCount:=Records in selection:C76([PON_ELEM_INSP:179])
	End if 
	
	If (PON_MATERIALS_Desc_atxt>1)
		Progress SET MESSAGE($Progressbar_L; "Material ...")
		
		//Picked category but not specific element 
		QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_MAT_KEY:7=PON_MATERIALS_KEY_atxt{PON_MATERIALS_Desc_atxt})
		ARRAY LONGINT:C221($alSearchIDs; 0)
		SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_KEY:1; $alSearchIDs)
		QUERY SELECTION WITH ARRAY:C1050([PON_ELEM_INSP:179]ELEM_KEY:3; $alSearchIDs)
		
		$iCount:=Records in selection:C76([PON_ELEM_INSP:179])
	End if 
End if 

If (cboElmtEnv>1)
	Progress SET MESSAGE($Progressbar_L; "Enviroment...")
	QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ENVKEY:5=(cboElmtEnv-1))
End if 

//Comparison of total Quantity
If ((cboElmttotQtyOp>1) & (vrSearchElmttotQty>0))
	Progress SET MESSAGE($Progressbar_L; "Total Quantity...")
	
	Case of 
		: (cboElmttotQtyOp=2)  //"=")
			QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QUANTITY:7=vrSearchElmttotQty)
			
		: (cboElmttotQtyOp=3)  //"#")
			QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QUANTITY:7#vrSearchElmttotQty)
			
		: (cboElmttotQtyOp=4)  //">")
			QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QUANTITY:7>vrSearchElmttotQty)
		: (cboElmttotQtyOp=5)  //"<")
			QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QUANTITY:7<vrSearchElmttotQty)
			
		: (cboElmttotQtyOp=6)  //">=")
			QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QUANTITY:7>=vrSearchElmttotQty)
			
		: (cboElmttotQtyOp=7)  //"<=")
			QUERY SELECTION:C341([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_QUANTITY:7<=vrSearchElmttotQty)
			
	End case 
	
End if 

ARRAY REAL:C219($arCS1; 0)
ARRAY REAL:C219($arCS2; 0)
ARRAY REAL:C219($arCS3; 0)
ARRAY REAL:C219($arCS4; 0)
ARRAY LONGINT:C221($arGP; 0)
ARRAY LONGINT:C221($arP; 0)
ARRAY REAL:C219($arTotQ; 0)
ARRAY LONGINT:C221($alRecNums; 0)
ARRAY LONGINT:C221($NBEElemIDS_aL; 0)
Progress SET MESSAGE($Progressbar_L; "Loading Data...")
SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEM_QTYSTATE1:13; $arCs1; [PON_ELEM_INSP:179]ELEM_QTYSTATE2:14; $arCs2; [PON_ELEM_INSP:179]ELEM_QTYSTATE3:15; $arCs3; [PON_ELEM_INSP:179]ELEM_QTYSTATE4:16; $arCs4)
SELECTION TO ARRAY:C260([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; $arGP; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; $arP; [PON_ELEM_INSP:179]ELEM_QUANTITY:7; $arTotQ; [PON_ELEM_INSP:179]ELEMID:22; $NBEElemIDS_aL)
LONGINT ARRAY FROM SELECTION:C647([PON_ELEM_INSP:179]; $alRecNums)
C_LONGINT:C283($vlNumCUs; $i)
$vlNumCUs:=Size of array:C274($arTotQ)

C_REAL:C285($vrPctQty_St; $vrPctQty_GT; $vrPctQty_LT; $vrTotQ; $vrPctQty_comp)
ARRAY REAL:C219($arCState; 4)
C_LONGINT:C283($TargetState)

// Element State
If ((cboElmtState>0) & (cboElmtStateOp>1) & (Records in selection:C76([PON_ELEM_INSP:179])>0))
	Progress SET MESSAGE($Progressbar_L; "Element State...")
	
	$TargetState:=cboElmtState
	Progress SET PROGRESS($Progressbar_L; 0)
	
	For ($i; $vlNumCUs; 1; -1)
		$arCState{1}:=$arCS1{$i}
		$arCState{2}:=$arCS2{$i}
		$arCState{3}:=$arCS3{$i}
		$arCState{4}:=$arCS4{$i}
		$vrTotQ:=$arTotQ{$i}
		$vrPctQty_St:=($arCState{$TargetState}/$vrTotQ)  // percent of qty at state
		$vrPctQty_GT:=0  // percent of quantity at states above the target state
		$vrPctQty_LT:=0  // percent of quantity at states below the target state
		For ($isc; ($TargetState+1); 4)
			If ($arCState{$isc}>=0)
				$vrPctQty_GT:=$vrPctQty_GT+($arCState{$isc}/$vrTotQ)
			End if 
		End for 
		For ($isc; 1; ($TargetState-1))
			If ($arCState{$isc}>=0)
				$vrPctQty_LT:=$vrPctQty_LT+($arCState{$isc}/$vrTotQ)
			End if 
		End for 
		$vrPctQty_St:=Round:C94((100*$vrPctQty_St); 1)
		$vrPctQty_GT:=Round:C94((100*$vrPctQty_GT); 1)
		$vrPctQty_LT:=Round:C94((100*$vrPctQty_LT); 1)
		
		//Comparison of Condition State
		Case of 
			: (cboElmtStateOp=2)  //"INST")  //any quantity at a state
				If ($vrPctQty_St>0)
					$vrPctQty_comp:=$vrPctQty_St
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
			: (cboElmtStateOp=3)  //"ATST")  //at state but not over
				If (($vrPctQty_St>0) & ($vrPctQty_GT<=0))
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
			: (cboElmtStateOp=4)  //"ATAFTST")  //at state and over
				If (($vrPctQty_St>0) | ($vrPctQty_GT>0))
					$vrPctQty_comp:=$vrPctQty_St+$vrPctQty_GT
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
			: (cboElmtStateOp=5)  //"AFTST")  //has exceeded state
				If ($vrPctQty_GT>0)
					$vrPctQty_comp:=$vrPctQty_GT
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
			: (cboElmtStateOp=6)  //"BEFST")  //not reached state
				If (($vrPctQty_St<=0) & ($vrPctQty_GT<=0))
					$vrPctQty_comp:=$vrPctQty_LT
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
		End case 
		
		//Comparison of state Quantity
		If ((cboElmtQtyOp>1) & ($alRecNums{$i}#-1) & (vrSearchElmtQty>0))
			Case of 
				: (cboElmtQtyOp=2)  //"=")
					If ($vrPctQty_comp#vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
					
				: (cboElmtQtyOp=3)  //"#")
					If ($vrPctQty_comp=vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
					
				: (cboElmtQtyOp=4)  //">")
					If ($vrPctQty_comp<=vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
				: (cboElmtQtyOp=5)  //"<")
					If ($vrPctQty_comp>=vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
				: (cboElmtQtyOp=6)  //">=")
					If ($vrPctQty_comp<vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
				: (cboElmtQtyOp=7)  //"<=")
					If ($vrPctQty_comp>vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
					
			End case 
			
		End if 
		
		Progress SET PROGRESS($Progressbar_L; ($vlNumCUs-$i)/$vlNumCUs)
		
	End for 
End if 

//now search for items in LB1 (prot sys and  Defects)
C_BOOLEAN:C305($match_b)
ARRAY LONGINT:C221($FoundChildren_aL; 0)  //array of children found that match criteria
C_LONGINT:C283($loop_L)

If ((Size of array:C274(NBESRC_LB1_ElemKey_aL)>0))
	Progress SET MESSAGE($Progressbar_L; "Filtering for Prot sys/Defects ...")
	
	For ($i; $vlNumCUs; 1; -1)
		
		ARRAY LONGINT:C221($FoundChildren_aL; 0)  //array of children found that match criteria
		
		If ($alRecNums{$i}#-1)  //skip removed ones
			
			For ($loop_L; 1; Size of array:C274(NBESRC_LB1_ElemKey_aL))
				QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_PARENTID:27=$NBEElemIDS_aL{$i}; *)
				QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_KEY:3=NBESRC_LB1_ElemKey_aL{$loop_L})
				
				If (Records in selection:C76([PON_ELEM_INSP:179])=1)
					//prepare quantity check variables
					$TargetState:=NBESRC_LB1_StateN_aL{$loop_L}
					$arCState{1}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13
					$arCState{2}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14
					$arCState{3}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15
					$arCState{4}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16
					$vrTotQ:=[PON_ELEM_INSP:179]ELEM_QUANTITY:7
					$vrPctQty_St:=($arCState{$TargetState}/$vrTotQ)  // percent of qty at state
					$vrPctQty_GT:=0  // percent of quantity at states above the target state
					$vrPctQty_LT:=0  // percent of quantity at states below the target state
					For ($isc; ($TargetState+1); 4)
						If ($arCState{$isc}>=0)
							$vrPctQty_GT:=$vrPctQty_GT+($arCState{$isc}/$vrTotQ)
						End if 
					End for 
					For ($isc; 1; ($TargetState-1))
						If ($arCState{$isc}>=0)
							$vrPctQty_LT:=$vrPctQty_LT+($arCState{$isc}/$vrTotQ)
						End if 
					End for 
					$vrPctQty_St:=Round:C94((100*$vrPctQty_St); 1)
					$vrPctQty_GT:=Round:C94((100*$vrPctQty_GT); 1)
					$vrPctQty_LT:=Round:C94((100*$vrPctQty_LT); 1)
					$match_b:=True:C214
					
					//total quantity
					If ((NBESRC_LB1_TotQV_ar{$loop_L}>0) & (NBESRC_LB1_TotQ_atxt{$loop_L}#""))
						$match_b:=False:C215
						Case of 
							: (NBESRC_LB1_TotQ_atxt{$loop_L}="EQ")
								$match_b:=(NBESRC_LB1_TotQV_ar{$loop_L}=[PON_ELEM_INSP:179]ELEM_QUANTITY:7)
							: (NBESRC_LB1_TotQ_atxt{$loop_L}="GT")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7>NBESRC_LB1_TotQV_ar{$loop_L})
							: (NBESRC_LB1_TotQ_atxt{$loop_L}="GTE")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7>=NBESRC_LB1_TotQV_ar{$loop_L})
							: (NBESRC_LB1_TotQ_atxt{$loop_L}="LT")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7<NBESRC_LB1_TotQV_ar{$loop_L})
							: (NBESRC_LB1_TotQ_atxt{$loop_L}="LTE")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7<=NBESRC_LB1_TotQV_ar{$loop_L})
						End case 
						If (Not:C34($match_b))
							$alRecNums{$i}:=-1  //remove from list
						End if 
						
					End if 
					
					// at state - skip if match failed before
					If ((NBESRC_LB1_StateN_aL{$loop_L}>0) & (NBESRC_LB1_State_atxt{$loop_L}#"") & ($alRecNums{$i}#-1))
						$match_b:=False:C215
						//"In State;At Most State;At State and After;Past State;Before State"
						Case of 
							: (NBESRC_LB1_State_atxt{$loop_L}="In State")
								If ($vrPctQty_St>0)
									$vrPctQty_comp:=$vrPctQty_St
									$match_b:=True:C214
								End if 
							: (NBESRC_LB1_State_atxt{$loop_L}="At Most State")
								If (($vrPctQty_St>0) & ($vrPctQty_GT<=0))
									$match_b:=True:C214
								End if 
							: (NBESRC_LB1_State_atxt{$loop_L}="At State and After")
								If (($vrPctQty_St>0) | ($vrPctQty_GT>0))
									$vrPctQty_comp:=$vrPctQty_St+$vrPctQty_GT
									$match_b:=True:C214
									
								End if 
							: (NBESRC_LB1_State_atxt{$loop_L}="Past State")
								If ($vrPctQty_GT>0)
									$vrPctQty_comp:=$vrPctQty_GT
									$match_b:=True:C214
									
								End if 
							: (NBESRC_LB1_State_atxt{$loop_L}="Before State")
								If (($vrPctQty_St<=0) & ($vrPctQty_GT<=0))
									$vrPctQty_comp:=$vrPctQty_LT
									$match_b:=True:C214
									
								End if 
								
						End case 
						
						If (Not:C34($match_b))
							$alRecNums{$i}:=-1  //remove from list
						End if 
						
					End if 
					
					//state quantity - skip if match failed before
					If ((NBESRC_LB1_StateQV_ar{$loop_L}>0) & (NBESRC_LB1_StateQ_atxt{$loop_L}#"") & ($alRecNums{$i}#-1))
						$match_b:=False:C215
						
						Case of 
							: (NBESRC_LB1_StateQ_atxt{$loop_L}="EQ")
								If ($vrPctQty_comp#NBESRC_LB1_StateQV_ar{$loop_L})
									$alRecNums{$i}:=-1  //remove from list
								End if 
							: (NBESRC_LB1_StateQ_atxt{$loop_L}="GT")
								If ($vrPctQty_comp<=NBESRC_LB1_StateQV_ar{$loop_L})
									$alRecNums{$i}:=-1  //remove from list
								End if 
							: (NBESRC_LB1_StateQ_atxt{$loop_L}="LT")
								If ($vrPctQty_comp>=NBESRC_LB1_StateQV_ar{$loop_L})
									$alRecNums{$i}:=-1  //remove from list
								End if 
							: (NBESRC_LB1_StateQ_atxt{$loop_L}="GTE")
								If ($vrPctQty_comp<NBESRC_LB1_StateQV_ar{$loop_L})
									$alRecNums{$i}:=-1  //remove from list
								End if 
							: (NBESRC_LB1_StateQ_atxt{$loop_L}="LTE")
								If ($vrPctQty_comp>NBESRC_LB1_StateQV_ar{$loop_L})
									$alRecNums{$i}:=-1  //remove from list
								End if 
								
						End case 
						
						If (Not:C34($match_b))
							$alRecNums{$i}:=-1  //remove from list
						End if 
						
					End if 
					
					If ($alRecNums{$i}#-1)
						//not removed - add the current element to the list of children
						APPEND TO ARRAY:C911($FoundChildren_aL; Record number:C243([PON_ELEM_INSP:179]))
					End if 
					
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
				If ($alRecNums{$i}=-1)
					//skip rest in this listbox - already no good
					$loop_L:=Size of array:C274(NBESRC_LB1_ElemKey_aL)+1
				End if 
				
			End for 
			
		End if 
		
		// If there is a second lisbox with prot system defects
		If ((Size of array:C274(NBESearch_LB2)>0) & ($alRecNums{$i}#-1))
			
			For ($loop_L; 1; Size of array:C274(NBESRC_LB2_ElemKey_aL))
				//NBESRC_LB2_ElemKey_aL{$loop_L}
				QUERY:C277([PON_ELEM_INSP:179]; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28=$NBEElemIDS_aL{$i}; *)
				QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_KEY:3=NBESRC_LB2_ElemKey_aL{$loop_L}; *)
				QUERY:C277([PON_ELEM_INSP:179];  & ; [PON_ELEM_INSP:179]ELEM_PARENT_KEY:4=NBESRC_LB2_PSYSKEY_aL{$loop_L})
				If (Records in selection:C76([PON_ELEM_INSP:179])=1)
					//prepare quantity check variables
					$arCState{1}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13
					$arCState{2}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14
					$arCState{3}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15
					$arCState{4}:=[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16
					$vrTotQ:=[PON_ELEM_INSP:179]ELEM_QUANTITY:7
					$vrPctQty_St:=($arCState{$TargetState}/$vrTotQ)  // percent of qty at state
					$vrPctQty_GT:=0  // percent of quantity at states above the target state
					$vrPctQty_LT:=0  // percent of quantity at states below the target state
					For ($isc; ($TargetState+1); 4)
						If ($arCState{$isc}>=0)
							$vrPctQty_GT:=$vrPctQty_GT+($arCState{$isc}/$vrTotQ)
						End if 
					End for 
					For ($isc; 1; ($TargetState-1))
						If ($arCState{$isc}>=0)
							$vrPctQty_LT:=$vrPctQty_LT+($arCState{$isc}/$vrTotQ)
						End if 
					End for 
					$vrPctQty_St:=Round:C94((100*$vrPctQty_St); 1)
					$vrPctQty_GT:=Round:C94((100*$vrPctQty_GT); 1)
					$vrPctQty_LT:=Round:C94((100*$vrPctQty_LT); 1)
					$match_b:=True:C214
					
					If ((NBESRC_LB2_TotQV_ar{$loop_L}>0) & (NBESRC_LB2_TotQ_atxt{$loop_L}#""))
						$match_b:=False:C215
						Case of 
							: (NBESRC_LB2_TotQ_atxt{$loop_L}="EQ")
								$match_b:=(NBESRC_LB1_TotQV_ar{$loop_L}=[PON_ELEM_INSP:179]ELEM_QUANTITY:7)
							: (NBESRC_LB2_TotQ_atxt{$loop_L}="GT")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7>NBESRC_LB2_TotQV_ar{$loop_L})
							: (NBESRC_LB2_TotQ_atxt{$loop_L}="GTE")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7>=NBESRC_LB2_TotQV_ar{$loop_L})
							: (NBESRC_LB2_TotQ_atxt{$loop_L}="LT")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7<NBESRC_LB2_TotQV_ar{$loop_L})
							: (NBESRC_LB2_TotQ_atxt{$loop_L}="LTE")
								$match_b:=([PON_ELEM_INSP:179]ELEM_QUANTITY:7<=NBESRC_LB2_TotQV_ar{$loop_L})
						End case 
						If (Not:C34($match_b))
							$alRecNums{$i}:=-1  //remove from list
						End if 
					End if 
					
					// at state
					If ((NBESRC_LB2_StateN_aL{$loop_L}>0) & (NBESRC_LB2_State_atxt{$loop_L}#"") & ($alRecNums{$i}#-1))
						$match_b:=False:C215
						//"In State;At Most State;At State and After;Past State;Before State"
						Case of 
							: (NBESRC_LB2_State_atxt{$loop_L}="In State")
								If ($vrPctQty_St>0)
									$vrPctQty_comp:=$vrPctQty_St
									$match_b:=True:C214
								End if 
							: (NBESRC_LB2_State_atxt{$loop_L}="At Most State")
								If (($vrPctQty_St>0) & ($vrPctQty_GT<=0))
									$match_b:=True:C214
								End if 
								
							: (NBESRC_LB2_State_atxt{$loop_L}="At State and After")
								If (($vrPctQty_St>0) | ($vrPctQty_GT>0))
									$vrPctQty_comp:=$vrPctQty_St+$vrPctQty_GT
									$match_b:=True:C214
								End if 
								
							: (NBESRC_LB2_State_atxt{$loop_L}="Past State")
								If ($vrPctQty_GT>0)
									$vrPctQty_comp:=$vrPctQty_GT
									$match_b:=True:C214
								End if 
								
							: (NBESRC_LB2_State_atxt{$loop_L}="Before State")
								If (($vrPctQty_St<=0) & ($vrPctQty_GT<=0))
									$vrPctQty_comp:=$vrPctQty_LT
									$match_b:=True:C214
								End if 
								
						End case 
						
						If (Not:C34($match_b))
							$alRecNums{$i}:=-1  //remove from list
						End if 
						
					End if 
					
					//state quantity - skip if match failed before
					
					If ((NBESRC_LB2_StateQV_ar{$loop_L}>0) & (NBESRC_LB2_StateQ_atxt{$loop_L}#"") & ($alRecNums{$i}#-1))
						$match_b:=False:C215
						
						Case of 
							: (NBESRC_LB2_StateQ_atxt{$loop_L}="EQ")
								If ($vrPctQty_comp=NBESRC_LB2_StateQV_ar{$loop_L})
									$match_b:=True:C214
								End if 
							: (NBESRC_LB2_StateQ_atxt{$loop_L}="GT")
								If ($vrPctQty_comp>NBESRC_LB2_StateQV_ar{$loop_L})
									$match_b:=True:C214
								End if 
							: (NBESRC_LB2_StateQ_atxt{$loop_L}="LT")
								If ($vrPctQty_comp<NBESRC_LB2_StateQV_ar{$loop_L})
									$match_b:=True:C214
								End if 
							: (NBESRC_LB2_StateQ_atxt{$loop_L}="GTE")
								If ($vrPctQty_comp>=NBESRC_LB2_StateQV_ar{$loop_L})
									$match_b:=True:C214
								End if 
							: (NBESRC_LB2_StateQ_atxt{$loop_L}="LTE")
								If ($vrPctQty_comp<=NBESRC_LB2_StateQV_ar{$loop_L})
									$match_b:=True:C214
								End if 
								
						End case 
						
						If (Not:C34($match_b))
							$alRecNums{$i}:=-1  //remove from list
						End if 
						
					End if 
					
					
					If ($alRecNums{$i}#-1)
						//not removed - add this element to the list
						APPEND TO ARRAY:C911($FoundChildren_aL; Record number:C243([PON_ELEM_INSP:179]))
					End if 
					
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
				If ($alRecNums{$i}=-1)
					//skip rest - already no good
					$loop_L:=Size of array:C274(NBESRC_LB2_ElemKey_aL)+1
				End if 
				
			End for 
			
		End if 
		
		If ($alRecNums{$i}#-1)
			//for valid element add the relevant children to the  list
			For ($loop_L; 1; Size of array:C274($FoundChildren_aL))
				APPEND TO ARRAY:C911($alRecNums; $FoundChildren_aL{$loop_L})
			End for 
			
			
		End if 
	End for 
	
End if 

Progress SET MESSAGE($Progressbar_L; "Cleanup ...")

For ($i; $vlNumCUs; 1; -1)
	If ($alRecNums{$i}<0)
		DELETE FROM ARRAY:C228($alRecNums; $i)
	End if 
End for 

CREATE SET FROM ARRAY:C641([PON_ELEM_INSP:179]; $alRecNums; "CondUnitsElmtSrch")
USE SET:C118("CondUnitsElmtSrch")
$iCount:=Records in selection:C76([PON_ELEM_INSP:179])

Progress QUIT($Progressbar_L)

CLEAR SET:C117("CondUnitsElmtSrch")
//End G_NBEElmtQuery