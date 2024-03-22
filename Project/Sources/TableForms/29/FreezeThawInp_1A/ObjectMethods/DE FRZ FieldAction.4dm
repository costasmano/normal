If (False:C215)
	//Object Method: [ElementsSafety].FreezeThawInp_1A.Comments 
	// Modified by: Costas Manousakis-(Designer)-(3/13/14 09:28:26)
	Mods_2014_03_Bug
	//  `fixed wrong stack number on data change
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+" -~;|"+Char:C90(13)+Char:C90(Double quote:K15:41))
		
	: (Form event code:C388=On Data Change:K2:15)
		PushChange(2; Self:C308)
End case 