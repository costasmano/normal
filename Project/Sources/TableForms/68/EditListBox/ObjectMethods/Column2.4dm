Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($Row_L)
		$Row_L:=EditListbox
		Case of 
			: ((PVartypes_atxt{$Row_L}="text") | (PVartypes_atxt{$Row_L}="string"))
				//PVarResults_atxt{$Row_L}:=Self->{$Row_L}
			: (PVartypes_atxt{$Row_L}="real")
				C_REAL:C285($res_r)
				$res_r:=Num:C11(Self:C308->{$Row_L})
				Self:C308->{$Row_L}:=String:C10($res_r)
			: (PVartypes_atxt{$Row_L}="date")
				C_DATE:C307($res_d)
				$res_d:=Date:C102(Self:C308->{$Row_L})
				$res_d:=$res_d+0
				Self:C308->{$Row_L}:=String:C10($res_d; Internal date short:K1:7)
			: ((PVartypes_atxt{$Row_L}="Int@") | (PVartypes_atxt{$Row_L}="long@"))
				C_LONGINT:C283($res_L)
				$res_L:=Num:C11(Self:C308->{$Row_L})
				Self:C308->{$Row_L}:=String:C10($res_L)
				
		End case 
		
	: (Form event code:C388=On Before Data Entry:K2:39)
		C_LONGINT:C283($Row_L)
		$Row_L:=EditListbox
		//ALERT("just got in row "+String($Row_L)+"! can we change the filter to match "+PVartypes_atxt{$row_L}+"?")
		
		Case of 
			: ((PVartypes_atxt{$Row_L}="text") | (PVartypes_atxt{$Row_L}="string"))
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"A-Z;a-z;0-9; ;.;,;(;);*;%;$;#;@;!;?;<;>;:;';-;+;_;=;^;[;];/;\\;|;{;};~;`"+Char:C90(Double quote:K15:41))
			: (PVartypes_atxt{$Row_L}="real")
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"+;-;.;0-9"+Char:C90(Double quote:K15:41))
			: (PVartypes_atxt{$Row_L}="date")
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"/;0-9"+Char:C90(Double quote:K15:41))
			: ((PVartypes_atxt{$Row_L}="Int@") | (PVartypes_atxt{$Row_L}="long@"))
				OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+"+;-;0-9"+Char:C90(Double quote:K15:41))
				
		End case 
		
End case 
