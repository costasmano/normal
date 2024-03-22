//%attributes = {"invisible":true}
//Method: wrpCustomPrintParts
//Description
// based on code from Lutz Veith.
// prints pages of 4D Write Pro doc using single page form(s) with a singke 4D write pro area on the page.

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/13/21, 16:12:18
	// ----------------------------------------------------
	//Created : 
	
	C_OBJECT:C1216(wrpCustomPrintParts; $1)
	C_OBJECT:C1216(wrpCustomPrintParts; $2)
End if 
//
C_OBJECT:C1216($wpDoc; $1)
C_OBJECT:C1216($pipParamObj; $2)
C_OBJECT:C1216($form; $obj)
C_LONGINT:C283($currPageLeftoverHeight; $wpAreaTopPos; $wpAreaLeftPos)
C_REAL:C285($totalPrintPaperWidth; $totalPrintPaperHeight)
C_REAL:C285($pageMarginTop; $pageMarginRight; $pageMarginBottom; $pageMarginLeft)
C_POINTER:C301($ptrPrintWpObj)
C_COLLECTION:C1488($colPagedWpDocs)  // One Page is one standalone wpDocItem in the collection
C_BOOLEAN:C305($pageMarginsInsideWParea; $isBeginWithNewPage; $isOpenPrintingJob)
C_LONGINT:C283($ignorePageLeftoverHeight; $minHeight; $defaultOrientation)
C_LONGINT:C283($heightOfPrintedSection; $headerFooterHeight; $headerHeight; $footerHeight)
C_LONGINT:C283($pageCounter; $leftoverHeightCounter; $i)
C_POINTER:C301($ptrPageCounter; $ptrLeftoverHeightCounter)
C_BOOLEAN:C305($headerContainsMargin; $footerContainsMargin)
C_LONGINT:C283($wpAreaWidth; $wpAreaHeight)
C_TEXT:C284($dynFormWinTitle; $dynFormName; $dynFormWpObjName)
C_POINTER:C301($ptrHeaderFormTable; $ptrFooterFormTable)
C_TEXT:C284($headerFormName; $footerFormName)
C_OBJECT:C1216($headerDynFormObj; $footerDynFormObj)
C_OBJECT:C1216(INSP_Comments_WP)

If (Count parameters:C259>0)
	$wpDoc:=OB Copy:C1225($1)
	If (Count parameters:C259>1)
		$pipParamObj:=$2
	Else 
		$pipParamObj:=wrpPrintInPartsNewParamObj
	End if 
Else 
	$wpDoc:=WP New:C1317
	$pipParamObj:=wrpPrintInPartsNewParamObj
End if 

Case of 
	: (Not:C34(OB Is defined:C1231($wpDoc)))
	: (OB Is empty:C1297($wpDoc))
	Else 
		WP SET ATTRIBUTES:C1342($wpDoc; wk layout unit:K81:78; wk unit pt:K81:136)  // Masseinheit auf Punkte umstellen
		$headerContainsMargin:=False:C215
		$footerContainsMargin:=False:C215
		$isOpenPrintingJob:=$pipParamObj.isOpenPrintingJob  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven
		$ignorePageLeftoverHeight:=$pipParamObj.ignorePageLeftoverHeight  // Default 19px ignorieren und lieber mit frischer Seite beginnen
		
		$defaultOrientation:=$pipParamObj.orientation  // 1=Portrait, 2=Landscape
		
		$colPagedWpDocs:=wrpSplitPages($wpDoc)
		
		If (False:C215)
			ARRAY TEXT:C222($Files_a; 0)
			C_TEXT:C284($filenew)
			$filenew:=Select folder:C670("choose folder for split WP files")
			For ($i; 0; ($colPagedWpDocs.length-1))
				INSP_Comments_WP:=OB Copy:C1225($colPagedWpDocs[$i])
				WP EXPORT DOCUMENT:C1337(INSP_Comments_WP; ($filenew+"pageSplit_"+String:C10($i; "000")+".4wp"); wk 4wp:K81:4)
			End for 
			
		End if 
		
		$isBeginWithNewPage:=True:C214
		
		// WP-Print-In-Parts
		C_TEXT:C284($formName)
		For ($i; 0; ($colPagedWpDocs.length-1))
			
			INSP_Comments_WP:=OB Copy:C1225($colPagedWpDocs[$i])
			Case of 
				: ($i=($colPagedWpDocs.length-1))  // Letzte Seite
					If ($i=0)  // Wenn Letzte Seite gleich Erste Seite
						$formName:=$pipParamObj.firstPageFormName
						If (Is table number valid:C999($pipParamObj.firstPageFormTable))
							$heightOfPrintedSection:=Print form:C5(Table:C252($pipParamObj.firstPageFormTable)->; $pipParamObj.firstPageFormName)
						Else 
							$heightOfPrintedSection:=Print form:C5($formName)
						End if 
						
					Else 
						
						If (Length:C16($pipParamObj.lastPageFormName)>0)
							$formName:=$pipParamObj.lastPageFormName
							If (Is table number valid:C999($pipParamObj.lastPageFormTable))
								$heightOfPrintedSection:=Print form:C5(Table:C252($pipParamObj.lasrPageFormTable)->; $pipParamObj.lastPageFormName)
							Else 
								$heightOfPrintedSection:=Print form:C5($formName)
							End if 
							
						Else 
							$formName:=$pipParamObj.PagesFormName
							
							If (Is table number valid:C999($pipParamObj.PagesFormTable))
								$heightOfPrintedSection:=Print form:C5(Table:C252($pipParamObj.PagesFormTable)->; $pipParamObj.PagesFormName)
							Else 
								$heightOfPrintedSection:=Print form:C5($formName)
							End if 
							
						End if 
						
					End if 
					
				: ($i=0)  // Erste Seite
					
					If (Length:C16($pipParamObj.firstPageFormName)>0)
						$formName:=$pipParamObj.firstPageFormName
						If (Is table number valid:C999($pipParamObj.firstPageFormTable))
							$heightOfPrintedSection:=Print form:C5(Table:C252($pipParamObj.firstPageFormTable)->; $pipParamObj.firstPageFormName)
						Else 
							$heightOfPrintedSection:=Print form:C5($formName)
						End if 
					Else 
						$formName:=$pipParamObj.PagesFormName
						
						If (Is table number valid:C999($pipParamObj.PagesFormTable))
							$heightOfPrintedSection:=Print form:C5(Table:C252($pipParamObj.PagesFormTable)->; $pipParamObj.PagesFormName)
						Else 
							$heightOfPrintedSection:=Print form:C5($formName)
						End if 
					End if 
					
				Else 
					//subsequent pages
					$formName:=$pipParamObj.PagesFormName
					
					If (Is table number valid:C999($pipParamObj.PagesFormTable))
						$heightOfPrintedSection:=Print form:C5(Table:C252($pipParamObj.PagesFormTable)->; $pipParamObj.PagesFormName)
					Else 
						$heightOfPrintedSection:=Print form:C5($formName)
					End if 
					
			End case 
			
			//check only if not last page for our case
			If ($i<($colPagedWpDocs.length-1))  //| (($ptrLeftoverHeightCounter->)<($footerHeight+$pageMarginBottom+9)))  // PageBreak und FooterPrint, nur wenn nicht "Letzte Seite" oder wenn nur noch Footer Platz hat
				
				PAGE BREAK:C6(>)  // > hält Druckauftrag offen
			End if 
		End for 
		
End case 

//End wrpCustomPrintParts