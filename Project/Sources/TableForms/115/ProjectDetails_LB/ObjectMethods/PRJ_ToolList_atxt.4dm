Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				m_MassEditProjectDetails
			: (Self:C308->=2)
				M_PRJ_PT_StartTimeSheetEntry  //new process
			: (Self:C308->=3)
				m_ListConsultantNames  //new process
		End case 
		Self:C308->:=0  //reset myself
End case 
