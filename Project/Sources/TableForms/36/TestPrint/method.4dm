Case of 
	: (Form event code:C388=On Load:K2:1)
		C_PICTURE:C286(S3_Field1)
		C_TEXT:C284(S3_FieldInfo_txt)
	: (Form event code:C388=On Printing Detail:K2:18)
		S3_Field1:=F_CompressPic([Standard Photos:36]Std Photo:3)
		S3_FieldInfo_txt:=String:C10(Picture size:C356([Standard Photos:36]Std Photo:3); "###,###,###")+" vs "+String:C10(Picture size:C356(S3_Field1); "###,###,###")
End case 
