//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/05, 20:27:45
	// ----------------------------------------------------
	// Method: G_PontisElmtQuery
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM17
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
// Element Category
C_LONGINT:C283($iCount; $isc)
If (cbPonElementCat=1)
	//only the element category is selected  
	Case of 
			//specific element is selected    
		: (cboPontisElem#0)
			QUERY SELECTION:C341([Cond Units:45]; [Cond Units:45]Element ID:3=cboPontisElemID{cboPontisElem})
			
		: (cboPontisElemCat>1)
			//Picked category but not specific element
			Case of 
				: (cboPontisElemCatCod{cboPontisElemCat}>0)
					QUERY:C277([BMS Elements:47]; [BMS Elements:47]Category ID:8=cboPontisElemCatCod{cboPontisElemCat})
				: (cboPontisElemCatCod{cboPontisElemCat}<0)
					QUERY:C277([BMS Elements:47]; [BMS Categories:49]Smart Flag:5=True:C214)
					
			End case 
			ARRAY INTEGER:C220($alSearchIDs; 0)
			SELECTION TO ARRAY:C260([BMS Elements:47]Element ID:1; $alSearchIDs)
			ARRAY LONGINT:C221($alCURecIDs; 0)
			ARRAY INTEGER:C220($alCUElIDs; 0)
			LONGINT ARRAY FROM SELECTION:C647([Cond Units:45]; $alCURecIDs)
			SELECTION TO ARRAY:C260([Cond Units:45]Element ID:3; $alCUElIDs)
			C_LONGINT:C283($NumCUs; $i)
			$NumCUs:=Size of array:C274($alCUElIDs)
			For ($i; $NumCUs; 1; -1)
				If (Find in array:C230($alSearchIDs; $alCUElIDs{$i})<0)
					DELETE FROM ARRAY:C228($alCURecIDs; $i)
				End if 
				
			End for 
			CREATE SELECTION FROM ARRAY:C640([Cond Units:45]; $alCURecIDs; "CUsFromArray")
			USE NAMED SELECTION:C332("CUsFromArray")
			CLEAR NAMED SELECTION:C333("CUsFromArray")
	End case 
	
	$iCount:=Records in selection:C76([Cond Units:45])
End if 

If (cbElmtEnv=1)
	If (cboElmtEnv#0)
		QUERY SELECTION:C341([Cond Units:45]; [Cond Units:45]Environment:4=cboElmtEnv)
	End if 
	
End if 

// Element State
If ((cboElmtState>0) & (Records in selection:C76([Cond Units:45])>0))
	ARRAY REAL:C219($arCS1; 0)
	ARRAY REAL:C219($arCS2; 0)
	ARRAY REAL:C219($arCS3; 0)
	ARRAY REAL:C219($arCS4; 0)
	ARRAY REAL:C219($arCS5; 0)
	ARRAY REAL:C219($arTotQ; 0)
	ARRAY LONGINT:C221($alRecNums; 0)
	SELECTION TO ARRAY:C260([Cond Units:45]CondState1:10; $arCs1; [Cond Units:45]CondState2:11; $arCs2; [Cond Units:45]CondState3:12; $arCs3; [Cond Units:45]CondState4:13; $arCs4; [Cond Units:45]CondState5:14; $arCs5)
	SELECTION TO ARRAY:C260([Cond Units:45]Total Quantity:5; $arTotQ)
	LONGINT ARRAY FROM SELECTION:C647([Cond Units:45]; $alRecNums)
	C_LONGINT:C283($vlNumCUs; $i)
	$vlNumCUs:=Size of array:C274($arTotQ)
	C_LONGINT:C283($TargetState)
	$TargetState:=cboElmtState
	C_REAL:C285($vrPctQty_St; $vrPctQty_GT; $vrPctQty_LT; $vrTotQ; $vrPctQty_comp)
	ARRAY REAL:C219($arCState; 5)
	For ($i; $vlNumCUs; 1; -1)
		$arCState{1}:=$arCS1{$i}
		$arCState{2}:=$arCS2{$i}
		$arCState{3}:=$arCS3{$i}
		$arCState{4}:=$arCS4{$i}
		$arCState{5}:=$arCS5{$i}
		$vrTotQ:=$arTotQ{$i}
		$vrPctQty_St:=($arCState{$TargetState}/$vrTotQ)
		$vrPctQty_GT:=0
		$vrPctQty_LT:=0
		For ($isc; ($TargetState+1); 5)
			If ($arCState{$isc}>=0)
				$vrPctQty_GT:=$vrPctQty_GT+($arCState{$isc}/$vrTotQ)
			End if 
		End for 
		For ($isc; 1; ($TargetState-1))
			If ($arCState{$isc}>=0)
				$vrPctQty_LT:=$vrPctQty_GT+($arCState{$isc}/$vrTotQ)
			End if 
		End for 
		$vrPctQty_St:=Round:C94((100*$vrPctQty_St); 1)
		$vrPctQty_GT:=Round:C94((100*$vrPctQty_GT); 1)
		$vrPctQty_LT:=Round:C94((100*$vrPctQty_LT); 1)
		
		//Comparison of Condition State
		Case of 
			: (vElmtStateOp="INST")
				If ($vrPctQty_St>0)
					$vrPctQty_comp:=$vrPctQty_St
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
			: (vElmtStateOp="ATST")  //at state but not over
				If (($vrPctQty_St>0) & ($vrPctQty_GT<=0))
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
			: (vElmtStateOp="ATAFTST")  //at state and over
				If (($vrPctQty_St>0) | ($vrPctQty_GT>0))
					$vrPctQty_comp:=$vrPctQty_St+$vrPctQty_GT
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
			: (vElmtStateOp="AFTST")  //has exceeded state
				If ($vrPctQty_GT>0)
					$vrPctQty_comp:=$vrPctQty_GT
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
			: (vElmtStateOp="BEFST")  //not reached state
				If (($vrPctQty_St<=0) & ($vrPctQty_GT<=0))
					$vrPctQty_comp:=$vrPctQty_LT
				Else 
					$alRecNums{$i}:=-1  //remove from list
				End if 
				
		End case 
		
		//Comparison of Quantity
		If ((cbElmtQty#0) & ($alRecNums{$i}#-1))
			Case of 
				: (vElmtQtyOp="=")
					If ($vrPctQty_comp#vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
				: (vElmtQtyOp=">")
					If ($vrPctQty_comp<=vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
				: (vElmtQtyOp="<")
					If ($vrPctQty_comp>=vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
				: (vElmtQtyOp=">=")
					If ($vrPctQty_comp<vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
				: (vElmtQtyOp="<=")
					If ($vrPctQty_comp>vrSearchElmtQty)
						$alRecNums{$i}:=-1  //remove from list
					End if 
					
			End case 
			
		End if 
		If ($alRecNums{$i}<0)
			DELETE FROM ARRAY:C228($alRecNums; $i)
		End if 
		
	End for 
	CREATE SET FROM ARRAY:C641([Cond Units:45]; $alRecNums; "CondUnitsElmtSrch")
	USE SET:C118("CondUnitsElmtSrch")
	$iCount:=Records in selection:C76([Cond Units:45])
	CLEAR SET:C117("CondUnitsElmtSrch")
End if 