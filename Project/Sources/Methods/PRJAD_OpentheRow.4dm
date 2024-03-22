//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): root
	// User name (4D): Designer
	// Date and time: 10/18/07, 12:14:15
	// ----------------------------------------------------
	// Method: PRJAD_OpentheRow
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_BOOLEAN:C305($0)
C_LONGINT:C283($1; $2; $3; $4; $5; $6)
If ($5>0)  //If the click takes place in a header
	$0:=True:C214  //Cancels the event
	READ WRITE:C146([PRJ_ProjectDetails:115])
	GOTO SELECTED RECORD:C245([PRJ_ProjectDetails:115]; $5)
	ut_LoadRecordInteractive(->[PRJ_ProjectDetails:115])
	C_LONGINT:C283($WL; $WT; $WR; $WB; $WW; $WH)
	GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
	$WW:=$WR-$WL
	$WH:=$WB-$WT
	FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.i")
	MODIFY RECORD:C57([PRJ_ProjectDetails:115])
	C_LONGINT:C283(PRJ_CurrentRecNum_L)
	C_LONGINT:C283($CurrRecNum; $CurrRecID; $i; $k)
	$CurrRecNum:=Record number:C243([PRJ_ProjectDetails:115])
	If ($CurrRecNum<=0)  //deleted
		$CurrRecNum:=PRJ_CurrentRecNum_L
		//  `$CurrRecID:=[PRJ_ProjectDetails]PRJ_ProjectID_l
		//  `SET QUERY DESTINATION(Into variable ;$RecFound)
		//  `QUERY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_ProjectID_l=$CurrRecID)
		//  `SET QUERY DESTINATION(Into current selection )
		//If ($RecFound=0)
		//
		//End if 
		$K:=Find in array:C230(PRJAD_RecNum_aL; PRJ_CurrentRecNum_L)
		C_POINTER:C301($aptr)
		For ($i; 1; Size of array:C274(PRJAD_Cols_at))
			$aptr:=Get pointer:C304(PRJAD_Cols_at{$i})
			DELETE FROM ARRAY:C228($aptr->; $K)
		End for 
		If ($K>1)
			$CurrRecNum:=PRJAD_RecNum_aL{$k-1}
		Else 
			$CurrRecNum:=PRJAD_RecNum_aL{1}
		End if 
		
	End if 
	If (Is record loaded:C669([PRJ_ProjectDetails:115]))
		UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
	End if 
	
	READ ONLY:C145([PRJ_ProjectDetails:115])
	
	$K:=Find in array:C230(PRJAD_RecNum_aL; $CurrRecNum)
	PV_SetSelectedRow($1; $K)
	GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
	SET WINDOW RECT:C444($WL; $WT; ($WL+$WW); ($WT+$WH))
	//PRJ_ShowAdPrjStatus ("LOAD")
	
End if   //Linked values in the columns are automatically sorted