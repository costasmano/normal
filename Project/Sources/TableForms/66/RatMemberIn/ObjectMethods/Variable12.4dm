C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
ARRAY TEXT:C222($a; 0)  //Command Replaced was o_ARRAY string length was 255

Case of 
	: (Form event code:C388=On Load:K2:1)
		vMemberType:=""
		LIST TO ARRAY:C288("Member Type"; $a)
		For ($i; 1; Size of array:C274($a))
			If (Position:C15([RatingMember:66]MemberType:3; $a{$i})=1)
				vMemberType:=$a{$i}
			End if 
		End for 
	: (Form event code:C388=On Data Change:K2:15)
		[RatingMember:66]MemberType:3:=Substring:C12(vMemberType; 1; 1)
End case 