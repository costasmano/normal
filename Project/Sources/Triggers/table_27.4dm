If (<>DatabaseStructureName_txt="MHD BMS")
	
	Case of 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			Case of 
				: ([Inspections:27]InspAreaEngApprDate:207#Old:C35([Inspections:27]InspAreaEngApprDate:207))
					[Inspections:27]CreateApprovedPDF_d:218:=Current date:C33
				: ([Inspections:27]InspDBIEApprDate:206#Old:C35([Inspections:27]InspDBIEApprDate:206))
					[Inspections:27]CreateApprovedPDF_d:218:=Current date:C33
			End case 
	End case 
	
End if 