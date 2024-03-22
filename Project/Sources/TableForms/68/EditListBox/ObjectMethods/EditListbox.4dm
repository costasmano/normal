C_LONGINT:C283(EDLISTBOXROW_L; EDLISTBOXCHARSTROKE_L; EDLISTFORMEVENT_L; $Col)
C_TEXT:C284(EDLISTFORMEVENT_TXT; EDLISTFILTER_TXT)
EDLISTFORMEVENT_L:=Form event code:C388
EDLISTFORMEVENT_TXT:=fGetFormEvent
C_LONGINT:C283($Col)
Case of 
	: (EDLISTFORMEVENT_L=On Load:K2:1)
		LISTBOX SELECT ROW:C912(EditListBox; 0; 2)  //deselect all
		
	: ((EDLISTFORMEVENT_L=On Getting Focus:K2:7) | (EDLISTFORMEVENT_L=On Selection Change:K2:29))
		LISTBOX GET CELL POSITION:C971(EDITLISTBOX; $Col; EDLISTBOXROW_L)
		Case of 
			: ((PVartypes_atxt{EDLISTBOXROW_L}="text") | (PVartypes_atxt{EDLISTBOXROW_L}="string"))
				EDLISTFILTER_TXT:="&"+Char:C90(Double quote:K15:41)+"A-Z;a-z;0-9; ;.;,;(;);*;%;$;#;@;!;?;<;>;:;';-;+;_;=;^;[;];/;\\;|;{;};~;`"+Char:C90(Double quote:K15:41)
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"A-Z;a-z;0-9; ;.;,;(;);*;%;$;#;@;!;?;<;>;:;';-;+;_;=;^;[;];/;\\;|;{;};~;`"+Char:C90(Double quote:K15:41))
			: (PVartypes_atxt{EDLISTBOXROW_L}="real")
				EDLISTFILTER_TXT:="&"+Char:C90(Double quote:K15:41)+"+;-;.;0-9"+Char:C90(Double quote:K15:41)
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"+;-;.;0-9"+Char:C90(Double quote:K15:41))
			: (PVartypes_atxt{EDLISTBOXROW_L}="date")
				EDLISTFILTER_TXT:="&"+Char:C90(Double quote:K15:41)+"/;0-9"+Char:C90(Double quote:K15:41)
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"/;0-9"+Char:C90(Double quote:K15:41))
			: ((PVartypes_atxt{EDLISTBOXROW_L}="Int@") | (PVartypes_atxt{EDLISTBOXROW_L}="long@"))
				EDLISTFILTER_TXT:="&"+Char:C90(Double quote:K15:41)+"+;-;0-9"+Char:C90(Double quote:K15:41)
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"+;-;0-9"+Char:C90(Double quote:K15:41))
				
		End case 
		
	: (EDLISTFORMEVENT_L=On After Edit:K2:43)
		LISTBOX GET CELL POSITION:C971(EDITLISTBOX; $Col; EDLISTBOXROW_L)
	: (EDLISTFORMEVENT_L=On Before Data Entry:K2:39)
		LISTBOX GET CELL POSITION:C971(EDITLISTBOX; $Col; EDLISTBOXROW_L)
	: (EDLISTFORMEVENT_L=On Selection Change:K2:29)
		LISTBOX GET CELL POSITION:C971(EDITLISTBOX; $Col; EDLISTBOXROW_L)
	: (EDLISTFORMEVENT_L=On Before Keystroke:K2:6)
		LISTBOX GET CELL POSITION:C971(EDITLISTBOX; $Col; EDLISTBOXROW_L)
	: (EDLISTFORMEVENT_L=On After Keystroke:K2:26)
		LISTBOX GET CELL POSITION:C971(EDITLISTBOX; $Col; EDLISTBOXROW_L)
	: (EDLISTFORMEVENT_L=On Column Resize:K2:31)
		C_LONGINT:C283($OL; $OT; $OR; $OB; $BL; $BT; $BR; $BB; $Vw; $Iw; $BW)
		OBJECT GET COORDINATES:C663(EDITLISTBOX; $OL; $OT; $OR; $OB)
		$Iw:=LISTBOX Get column width:C834(PVarInputs_atxt)
		$Vw:=LISTBOX Get column width:C834(PVarNamesTypes_atxt)
		OBJECT GET COORDINATES:C663(PEDITBUTTON; $BL; $BT; $BR; $BB)
		$BW:=$BR-$BL
		OBJECT MOVE:C664(PEDITBUTTON; ($OL+$Vw-$BL); 0)
		OBJECT GET COORDINATES:C663(PVarResults_atxt; $OL; $OT; $OR; $OB)
		OBJECT GET COORDINATES:C663(PRESETBUTTON; $BL; $BT; $BR; $BB)
		If (($BR-$BL)>$BW)
			//changed size 
			$BW:=$BW-($BR-$BL)
		Else 
			$BW:=0
		End if 
		
		OBJECT MOVE:C664(PRESETBUTTON; ($OL+$Vw+$Iw-$BL); 0; 0; $BW)
		
End case 
