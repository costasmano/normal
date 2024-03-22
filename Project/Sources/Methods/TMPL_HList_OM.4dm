//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/16/07, 22:50:43
	// ----------------------------------------------------
	// Method: TMPL_HList_OM
	// Description
	// Object method for the HList object in dialog
	// 
	// Parameters
	//  $1 : $LineSelected ( Long)
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(5/21/2007 10:41:53)
	Mods_2007_CM10
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($1; $LineSelected)
$LineSelected:=$1
vSelectionDescription:=atQRT_ReportDescr{$LineSelected}
C_LONGINT:C283($OKBtnL; $OKBtnT; $OKBtnR; $OKBtnB; $RptGrpL; $RptGrpT; $RptGrpR; $RptGrpB; $RptHt)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($WinL; $WinT; $WinR; $winB; $winMargin)  //Command Replaced was o_C_INTEGER
$WinMargin:=20
OBJECT GET COORDINATES:C663(*; "OKButton"; $OKBtnL; $OKBtnT; $OKBtnR; $OKBtnB)
OBJECT GET COORDINATES:C663(*; "RptOptionsGrp"; $RptGrpL; $RptGrpT; $RptGrpR; $RptGrpB)
$RptHt:=$RptGrpB-$RptGrpT
GET WINDOW RECT:C443($WinL; $WinT; $WinR; $winB)
C_BOOLEAN:C305($vValidQRT_b)
$vValidQRT_b:=False:C215
OBJECT SET ENABLED:C1123(*; "OKButton"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
If (atQRT_MethodNames{$LineSelected}="QRT@")
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=atQRT_MethodNames{$LineSelected})
	If (Records in selection:C76([Templates:86])=1)
		$vValidQRT_b:=True:C214
	Else 
		vSelectionDescription:="Error! Template Not Found in DB"
		OBJECT SET ENABLED:C1123(*; "OKButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	End if 
End if 
If ($vValidQRT_b)
	
	C_LONGINT:C283($QuickRptArea_L; $vlRptDest)
	$QuickRptArea_L:=QR New offscreen area:C735
	QR BLOB TO REPORT:C771($QuickRptArea_L; [Templates:86]Template_:3)
	C_TEXT:C284($vSpecifics_txt)
	QR GET DESTINATION:C756($QuickRptArea_L; $vlRptDest; $vSpecifics_txt)
	RptDestination:=$vlRptDest
	QR DELETE OFFSCREEN AREA:C754($QuickRptArea_L)
	OBJECT SET ENABLED:C1123(*; "OKButton"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	If ($RptGrpT<$OKBtnB)
		//resize window
		$move:=($WinT+$OKBtnB+5+$RptHt+$WinMargin)-$WinB
		SET WINDOW RECT:C444($WinL; $WinT; $WinR; ($WinB+$move))
		//Move /resize objects
		OBJECT MOVE:C664(*; "OKButton@"; 0; -$move)
		OBJECT MOVE:C664(*; "CancelButton@"; 0; -$move)
		OBJECT MOVE:C664(*; "vSelectionDescr@"; 0; -$move)
		OBJECT MOVE:C664(*; "SelectionList"; 0; 0; 0; -$move)
		OBJECT GET COORDINATES:C663(*; "OKButton"; $OKBtnL; $OKBtnT; $OKBtnR; $OKBtnB)
		OBJECT GET COORDINATES:C663(*; "RptOptionsGrp"; $RptGrpL; $RptGrpT; $RptGrpR; $RptGrpB)
		OBJECT MOVE:C664(*; "Rpt@"; 0; ($OKBtnB+5-$RptGrpT))
		
	End if 
	OBJECT SET VISIBLE:C603(*; "Rpt@"; True:C214)
	
Else 
	OBJECT SET VISIBLE:C603(*; "Rpt@"; False:C215)
	If (($WinB-$WinT)>($OKBtnB+5))
		//resize window
		SET WINDOW RECT:C444($WinL; $WinT; $WinR; ($WinT+$OKBtnB+$WinMargin))
		C_LONGINT:C283($move)
		$move:=($WinB-$WinT)-($OKBtnB+$WinMargin)
		//Move objects
		OBJECT MOVE:C664(*; "OKButton@"; 0; $move)
		OBJECT MOVE:C664(*; "CancelButton@"; 0; $move)
		OBJECT MOVE:C664(*; "vSelectionDescr@"; 0; $move)
		OBJECT MOVE:C664(*; "SelectionList"; 0; 0; 0; $move)
		OBJECT GET COORDINATES:C663(*; "RptOptionsGrp"; $RptGrpL; $RptGrpT; $RptGrpR; $RptGrpB)
		
	End if 
End if 