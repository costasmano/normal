If (False:C215)
	//Object Method: [Bridge MHD NBIS].SI & A Input.Bridge Name 
	// Modified by: Costas Manousakis-(Designer)-(1/27/14 14:07:26)
	Mods_2014_01
	//  `added trim of entry and  added entry filter  on the field with semicolon  pattern " -}" allows chars from space to }, add "-" and "~"
	//  `Created Filter AllASCII32to126 that includes all characters. assigned to bridge name object
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		//SET FILTER(Self->;"&"+Char(Double quote )+"A-Z;a-z;0-9; ;:-@;.;,;(;);*;%;$;&;#;@;!;?;<;>;:;';-;+;_;=;^;[;];/;\\;|;{;};~;`;"+Char(Double quote ))
		//SET FILTER(Self->;"&"+Char(Double quote )+"; -};-;~;"+Char(Double quote ))
		
	: (Form event code:C388=On Data Change:K2:15)
		Self:C308->:=f_TrimStr(Self:C308->; True:C214; True:C214)
		PushChange(1; Self:C308)
		
End case 