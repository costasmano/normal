//%attributes = {"invisible":true}
// PM: "wrpNewTempStandards" (neu LV 26.09.2018) 
// Erzeugt (und gibt zurück) ein Object(json) mit den Einstell-Parametern zu einem 4DWritePro-Dokument um mit "wrpNewTemplate" ein wpDocument zu erstellen
// Nur Alternative zu "wrpNewTemplateNewProperties", gleiche Funkton nur können hiermit gleich unterschiedliche Standard-Templates erzeugt werden
// $1 - TEXT - $nameStandardTemplate: "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10" 
// $2 - BOOLEAN - $withPageMarginNull (Optional) - True=AussenrandNull oder False=AussenrandWpStandard2.5cm
// $0 - OBJECT - Object(json) mit Einstellungen zu einem 4DWritePro-Dokument(customTemplate)
// Letzte Änderung: LV 26.09.2018, 22:40 Uhr

C_TEXT:C284($nameStandardTemplate; $1)
C_BOOLEAN:C305($withPageMarginNull; $2)
C_OBJECT:C1216($wpPropertiesObj; $0)

$withPageMarginNull:=False:C215

If (Count parameters:C259>0)
	$nameStandardTemplate:=$1
	If (Count parameters:C259>1)
		$withPageMarginNull:=$2
	End if 
End if 

$wpPropertiesObj:=wrpNewTemplateNewProperties

// UserUnit=pt; Sections=1; Section0=True;
$wpPropertiesObj.bodyUserUnit:="pt"
$wpPropertiesObj.section0:=True:C214
If ($withPageMarginNull)  // wenn Null-Aussenrand gewünscht, andernfalls Aussenrand ist wpStandard: 2.5cm=70.85pt=94px(wpInner96dpi)=70.85px(4DForm72dpi)
	$wpPropertiesObj.section0PageMargin:="0cm"
End if 

Case of 
	: ($nameStandardTemplate="Comments")  //custom page size for typical inspection comments
		$wpPropertiesObj.section0PageWidth:="533pt"
		$wpPropertiesObj.section0PageHeight:="661pt"
		
	: ($nameStandardTemplate="Culvertpage1")  //custom page size for page 2 of culvert inspection report
		$wpPropertiesObj.section0PageWidth:="533pt"
		$wpPropertiesObj.section0PageHeight:="298pt"
		
	: ($nameStandardTemplate="A0")  // Section0Size=A0
		// Breite / Höhe in mm: 841 x 1189
		// Pixel bei 72 ppi/dpi: 2384 x 3370
		// Pixel bei 150 ppi/dpi: 4967 x 7022
		// Pixel bei 300 ppi/dpi: 9933 x 14043
		$wpPropertiesObj.section0PageWidth:="2384pt"
		$wpPropertiesObj.section0PageHeight:="3370pt"
		
	: ($nameStandardTemplate="A1")  // Section0Size=A1
		// Breite / Höhe in mm: 594 x 841"
		// Pixel bei 72 ppi/dpi: 1684 x 2384
		// Pixel bei 150 ppi/dpi: 3508 x 4967
		// Pixel bei 300 ppi/dpi: 7016 x 9933
		$wpPropertiesObj.section0PageWidth:="1684pt"
		$wpPropertiesObj.section0PageHeight:="2384pt"
		
	: ($nameStandardTemplate="A2")  // Section0Size=A2
		// Breite / Höhe in mm: 420 x 594
		// Pixel bei 72 ppi/dpi: 1191 x 1684
		// Pixel bei 150 ppi/dpi: 2480 x 3508
		// Pixel bei 300 ppi/dpi: 4961 x 7016
		$wpPropertiesObj.section0PageWidth:="1191pt"
		$wpPropertiesObj.section0PageHeight:="1684pt"
		
	: ($nameStandardTemplate="A3")  // Section0Size=A3
		// Breite / Höhe in mm: 297 x 420
		// Pixel bei 72 ppi/dpi: 842 x 1191
		// Pixel bei 150 ppi/dpi: 1754 x 2480
		// Pixel bei 300 ppi/dpi: 3508 x 4961
		$wpPropertiesObj.section0PageWidth:="842pt"
		$wpPropertiesObj.section0PageHeight:="1191pt"
		
	: ($nameStandardTemplate="A4")  // Section0Size=A4
		// Breite / Höhe in mm: 210 x 297
		// Pixel bei 72 ppi/dpi: 595 x 842
		// Pixel bei 150 ppi/dpi: 1240 x 1754
		// Pixel bei 300 ppi/dpi: 2480 x 3508
		$wpPropertiesObj.section0PageWidth:="595pt"
		$wpPropertiesObj.section0PageHeight:="842pt"
		
	: ($nameStandardTemplate="A5")  // Section0Size=A5
		// Breite / Höhe in mm: 148 x 210
		// Pixel bei 72 ppi/dpi: 420 x 595
		// Pixel bei 150 ppi/dpi: 874 x 1240
		// Pixel bei 300 ppi/dpi: 1748 x 2480
		$wpPropertiesObj.section0PageWidth:="420pt"
		$wpPropertiesObj.section0PageHeight:="595pt"
		
	: ($nameStandardTemplate="A6")  // Section0Size=A6
		// Breite / Höhe in mm: 105 x 148
		// Pixel bei 72 ppi/dpi: 298 x 420
		// Pixel bei 150 ppi/dpi: 620 x 874
		// Pixel bei 300 ppi/dpi: 1240 x 1748
		$wpPropertiesObj.section0PageWidth:="298pt"
		$wpPropertiesObj.section0PageHeight:="420pt"
		
	: ($nameStandardTemplate="A7")  // Section0Size=A7
		// Breite / Höhe in mm: 74 x 105
		// Pixel bei 72 ppi/dpi: 210 x 298
		// Pixel bei 150 ppi/dpi: 437 x 620
		// Pixel bei 300 ppi/dpi: 874 x 1240
		$wpPropertiesObj.section0PageWidth:="210pt"
		$wpPropertiesObj.section0PageHeight:="298pt"
		
	: ($nameStandardTemplate="A8")  // Section0Size=A8
		// Breite / Höhe in mm: 52 x 74
		// Pixel bei 72 ppi/dpi: 147 x 210
		// Pixel bei 150 ppi/dpi: 307 x 437
		// Pixel bei 300 ppi/dpi: 614 x 874
		$wpPropertiesObj.section0PageWidth:="147pt"
		$wpPropertiesObj.section0PageHeight:="210pt"
		
	: ($nameStandardTemplate="A9")  // Section0Size=A9
		// Breite / Höhe in mm: 37 x 52
		// Pixel bei 72 ppi/dpi: 105 x 147
		// Pixel bei 150 ppi/dpi: 219 x 307
		// Pixel bei 300 ppi/dpi: 437 x 614
		$wpPropertiesObj.section0PageWidth:="105pt"
		$wpPropertiesObj.section0PageHeight:="147pt"
		
	: ($nameStandardTemplate="A10")  // Section0Size=A10
		// Breite / Höhe in mm: 26 x 37
		// Pixel bei 72 ppi/dpi: 74 x 105
		// Pixel bei 150 ppi/dpi: 154 x 219
		// Pixel bei 300 ppi/dpi: 307 x 437
		$wpPropertiesObj.section0PageWidth:="74pt"
		$wpPropertiesObj.section0PageHeight:="105pt"
		
End case 

$0:=$wpPropertiesObj
