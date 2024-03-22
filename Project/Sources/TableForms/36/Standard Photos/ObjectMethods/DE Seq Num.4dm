//Object Method
C_BOOLEAN:C305(vbPhotoSeqChg)
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		PushChange(2; Self:C308)
		vbPhotoSeqChg:=True:C214
End case 