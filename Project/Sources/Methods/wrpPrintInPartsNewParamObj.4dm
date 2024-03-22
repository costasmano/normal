//%attributes = {"invisible":true}
//Method: wrpPrintInPartsNewParamObj
//Description
// $1 - TEXT - $id - Optional, falls eigene ID zur Widerkennung gewünscht ist
// $0 - OBJECT - $pipParamObj - JSON-Objekt mit PiP-Einstellungen so wie von "wrpPrintInParts" und "wrpPrintInPartsSplitPages" genutzt
// Erstellt und gibt zurück ein JSON-Objekt-Template vom Typ "_WP-PIP-Param" um PiP-Modul mit eigenen individuellne Parameter aufzurufen
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	// PM: wrpPrintInPartsNewParamObj (neu LV 02.10.2018) 
	// $1 - TEXT - $id - Optional, falls eigene ID zur Widerkennung gewünscht ist
	// $0 - OBJECT - $pipParamObj - JSON-Objekt mit PiP-Einstellungen so wie von "wrpPrintInParts" und "wrpPrintInPartsSplitPages" genutzt
	// Erstellt und gibt zurück ein JSON-Objekt-Template vom Typ "_WP-PIP-Param" um PiP-Modul mit eigenen individuellne Parameter aufzurufen
	// Die Attribute im Objekt sind mit Default-Werten vorbelegt und können vor Aufruf+Übergabe an das PiP-Modul nach eigenen Bedürfnissen geändert werden
	// Letzte Änderung: LV 02.10.2018, 20:30 Uhr
	
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/13/21, 16:38:58
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_TEXT:C284(wrpPrintInPartsNewParamObj; $1)  // Optional, any ID if you want to have your own id
	C_OBJECT:C1216(wrpPrintInPartsNewParamObj; $0)
End if 
//

C_TEXT:C284($id; $1)  // Optional, any ID if you want to have your own id
C_OBJECT:C1216($wrpParamObj; $0)

If (Count parameters:C259>0)
	$id:=$1
Else 
	$id:=Replace string:C233(String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178); "Z"; ".000Z")+"#"+String:C10(Milliseconds:C459)  //"2018-08-24T07:34:14.000Z"+"#"+String(Milliseconds)
End if 

$wrpParamObj:=New object:C1471
OB SET:C1220($wrpParamObj; "type"; "_WP-PIP-Param")  // Only too re-ident this is a correct WP-PIP-ParamObj (if you want to use WP-PIP-Routines do not change this!)
OB SET:C1220($wrpParamObj; "id"; $id)  // This parameter is optional for your own, not needed to use the WP-PIP-Modul 

OB SET:C1220($wrpParamObj; "isOpenPrintingJob"; False:C215)  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven
OB SET:C1220($wrpParamObj; "orientation"; 1)  // 1=Portrait(default), 2=Landscape

// Beispiel-WP-Default: Paper: A4 (1=Portrait)
// div.section0 { -d4-page-width:595pt;-d4-page-height:842pt;-d4-page-margin:2.5cm }
// Alle Angaben in px auf Basis 72dpi also 1px=1pt, weil da ein Inch(immer 72pt) 72px hat
// ...Also KEINE 96dpi wo 1px=(72/96)pt=0,75pt sind, weil da ein Inch(immer 72pt) 96px hat

OB SET:C1220($wrpParamObj; "currPageLeftoverHeight"; 0)  // Angabe in px (72dpi) ...ist der Wert Null beginnt der WP-Druck mit einer neuen frischen Seite, ansonsten wird die angegebene Resthöhe der schon angefangenen aktuellen Seite genutzt
OB SET:C1220($wrpParamObj; "ignorePageLeftoverHeight"; 19)  // Angabe in px (72dpi)

OB SET:C1220($wrpParamObj; "totalPrintPaperWidth"; 595)  // Angabe in px (72dpi) ...total, also inclusive der wahlweise linken+rechten Seitenränder/pageMargin
OB SET:C1220($wrpParamObj; "totalPrintPaperHeight"; 842)  // Angabe in px (72dpi) ...total, also inclusive der wahlweise oben+unten Seitenränder/pageMargin

OB SET:C1220($wrpParamObj; "pageMarginTop"; 70.85)  // Angabe in px (72dpi)
OB SET:C1220($wrpParamObj; "pageMarginRight"; 70.85)  // Angabe in px (72dpi)
OB SET:C1220($wrpParamObj; "pageMarginBottom"; 70.85)  // Angabe in px (72dpi)
OB SET:C1220($wrpParamObj; "pageMarginLeft"; 70.85)  // Angabe in px (72dpi)

// Mit $pageMarginsInsideWParea wird vorgegeben mit welcher von zwei möglichen Varianten die pageMargins umgesetzt werden
// Nur wenn True(Variante innerhalb WParea) gewählt kann auf Wunsch z.B. ein wpDokumentHintergrundFarbe/Bild randlos das ganze Papier bedecken
// Wenn False(Variante ausserhalb WParea gewählt, dann wird der Rand immer ausgespart und eventuelle wpDokumentHintergrundFarbe/Bild beschränken sich auf Innenteil
// Bei der False Variante könnte man den Randbereich noch über die 4DDruckForm ausgestalten (Farbe/Bild/Schmuckrand durch weitere FormObjecte in der Form neben den wpAreaFormObj)
// False bedeutet also: Ränder gestalten sich über 4DForm und wpDocumentCss bekommt ".section0{-d4-page-margin:0cm} body{margin:0cm} zugewiesen
// True bedeutet: Ränder gestalten innerhalb wpFormObject(wpDokument)
// Der verbleibende wpDokument-Innenraum bei True/False ist immer der selbe, nur worüber die Aussenränder umgesetzt werden sollen wird mit dem Parameter vorgegeben
// True = Seitenrand im wpFormObject als wpDocumentCss ".section0{-d4-page-margin:##cm}" (pagedMode) und "body{margin:##cm}" (EmbeddMode)
// False = Seitenrand ausserhalb wpFormObjects, also mit wpFormObjectTopPos/LeftPos einrücken in 4DForm und wpFormObjectHöhe/Breite um Rand reduzieren
OB SET:C1220($wrpParamObj; "pageMarginsInsideWParea"; False:C215)  // True=RandImWParea | False=RandAusserhalbWParea

OB SET:C1220($wrpParamObj; "useDocBG"; True:C214)
OB SET:C1220($wrpParamObj; "useDocBorder"; False:C215)
OB SET:C1220($wrpParamObj; "useDocPadding"; False:C215)
OB SET:C1220($wrpParamObj; "useDocMargin"; False:C215)
OB SET:C1220($wrpParamObj; "useImageAnchored"; False:C215)

OB SET:C1220($wrpParamObj; "headerUse"; False:C215)
OB SET:C1220($wrpParamObj; "headerHeight"; 0)
OB SET:C1220($wrpParamObj; "headerFormTable"; 0)
OB SET:C1220($wrpParamObj; "headerFormName"; "")
OB SET:C1220($wrpParamObj; "headerDynFormUse"; False:C215)
OB SET:C1220($wrpParamObj; "headerDynFormObj"; Null:C1517)

OB SET:C1220($wrpParamObj; "footerUse"; False:C215)
OB SET:C1220($wrpParamObj; "footerHeight"; 0)
OB SET:C1220($wrpParamObj; "footerFormTable"; 0)
OB SET:C1220($wrpParamObj; "footerFormName"; "")
OB SET:C1220($wrpParamObj; "footerDynFormUse"; False:C215)
OB SET:C1220($wrpParamObj; "footerDynFormObj"; Null:C1517)

OB SET:C1220($wrpParamObj; "pageCounterVarName"; "")
OB SET:C1220($wrpParamObj; "leftoverHeightCounterVarName"; "")
OB SET:C1220($wrpParamObj; "lastPageAfterWpPrintLeftoverHeight"; 0)

//added attributes by Costas
// if the first page is different than the rest
OB SET:C1220($wrpParamObj; "firstPageFormName"; "")
OB SET:C1220($wrpParamObj; "firstPageFormTable"; 0)
OB SET:C1220($wrpParamObj; "firstPageWPAreaType"; "")
// typical pages
OB SET:C1220($wrpParamObj; "PagesFormName"; "")
OB SET:C1220($wrpParamObj; "PagesFormTable"; 0)
OB SET:C1220($wrpParamObj; "PagesWPAreaType"; "")
//could add something for the last page 
// not easy to implement - last page wp area has to be same size as the 'middle' pages - othewise
// if the body after the second to last page exceeds the allowed area in the last page , then
// there will be a small part that has to be printed in a middle page form
OB SET:C1220($wrpParamObj; "lastPageFormName"; "")
OB SET:C1220($wrpParamObj; "lastPageFormTable"; 0)
OB SET:C1220($wrpParamObj; "lastPagePAreaType"; "")

$0:=$wrpParamObj

//End wrpPrintInPartsNewParamObj