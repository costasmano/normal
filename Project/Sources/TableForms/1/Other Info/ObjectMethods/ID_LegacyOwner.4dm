If (False:C215)
	//[Bridge MHD NBIS].Other Info.ID_INP_Variable1
	// Modified by: Costas Manousakis-(Designer)-(9/14/18 17:31:33)
	Mods_2018_09
	//  `added to modify Legacy Owner
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		POPUPMENUC(->aIt8OwnerDes_; ->aIt8OwnerCode_; ->[Bridge MHD NBIS:1]LegacyOwner:226)
		If (GRP_UserInGroup("SIA_LegacyOwnerEdit")=1)
			OBJECT SET ENABLED:C1123(*; "ID_LegacyOwner"; True:C214)
			
		Else 
			OBJECT SET ENABLED:C1123(*; "ID_LegacyOwner"; False:C215)
		End if 
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		POPUPMENUC(->aIt8OwnerDes_; ->aIt8OwnerCode_; ->[Bridge MHD NBIS:1]LegacyOwner:226)
		PushChange(1; ->[Bridge MHD NBIS:1]LegacyOwner:226)
End case 
