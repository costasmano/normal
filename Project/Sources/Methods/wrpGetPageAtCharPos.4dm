//%attributes = {"invisible":true}
// PM: "wrpGetPageAtCharPos"  (neu LV 02.10.2018)
// $1 - OBJECT - $wpDoc - wpDokument (...oder bodyElement)
// $2 - LONGINT - $charPos - Zeichenposition im WP-Dokument
// $0 - LONGINT - $page - SeitenNummer auf der die charPos liegt
// Gibt die Seite zurück auf der die Zeichenposition im WP-Dokument liegt
// Letzte Änderung: LV 02.10.2018, 20:30 Uhr

C_OBJECT:C1216($wpDoc; $1)
C_LONGINT:C283($charPos; $2)
C_LONGINT:C283($page; $0)
C_OBJECT:C1216($wpRange; $objPos)

$charPos:=0
$page:=1

If (Count parameters:C259>0)
	$wpDoc:=OB Copy:C1225($1)
	If (Count parameters:C259>1)
		$charPos:=$2
	End if 
End if 

Case of 
	: (Not:C34(OB Is defined:C1231($wpDoc)))
	: (OB Is empty:C1297($wpDoc))
	: ($charPos=0)
	Else 
		$wpRange:=WP Text range:C1341($wpDoc; $charPos; $charPos+2)
		$objPos:=WP Get position:C1577($wpRange; wk 4D Write Pro layout:K81:176)
		$page:=$objPos.page
End case 

$0:=$page
