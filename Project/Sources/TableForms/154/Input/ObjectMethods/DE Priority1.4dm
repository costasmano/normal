RtgReq_ComboMenu_OM(Self:C308; ->[RatingRequests:154]ActionByAreaEng_s:6; ->[RatingRequests:154]ActionByAreaEngDate_d:7)
If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	
	If ([RatingRequests:154]ActionByAreaEng_s:6#Old:C35([RatingRequests:154]ActionByAreaEng_s:6))
		
		If ([RatingRequests:154]ActionByAreaEng_s:6="Rejected@")
			[RatingRequests:154]Status_s:15:=[RatingRequests:154]ActionByAreaEng_s:6
			[RatingRequests:154]StatusDate_d:16:=[RatingRequests:154]ActionByAreaEngDate_d:7
		End if 
		
	End if 
	
End if 
