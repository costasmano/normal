If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/29/07, 09:03:04
	// ----------------------------------------------------
	// Method: Form Method: ut_Request
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(10/25/10 12:07:48)
	Mods_2010_10
	//  `Added option to go to a second page for a method using the Combo box and
	//  `to allow to delete entries in the dropdown.
	// Modified by: costasmanousakis-(Designer)-(10/17/11 16:42:35)
	Mods_2011_10
	//  `modified object properties to handle vertical sizing better.
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(ut_Request_Page_L)
		If (Size of array:C274(ut_Request_Choises)>1)
			OBJECT SET VISIBLE:C603(ut_Request_Choises; True:C214)
			ut_Request_Choises:=0
			If (Find in array:C230(ut_Request_Choises; ut_Request_Value_txt)>0)
				ut_Request_Choises:=Find in array:C230(ut_Request_Choises; ut_Request_Value_txt)
				ut_Request_Choises{0}:=ut_Request_Value_txt
			End if 
			
		Else 
			If (ut_Request_Page_L=1)
				OBJECT SET VISIBLE:C603(ut_Request_Choises; False:C215)
			End if 
		End if 
		OBJECT SET TITLE:C194(ut_request_Cancel_btn; ut_Request_CancBtn_txt)
		OBJECT SET TITLE:C194(ut_request_Accept_btn; ut_Request_OKBtn_txt)
		C_LONGINT:C283($CurrBtnT; $CurrBtnL; $CurrBtnB; $CurrBtnR; BestW; CurrHt; $NewL; $NewR)
		OBJECT GET COORDINATES:C663(*; "ut_request_Cancel_btn"; $CurrBtnL; $CurrBtnT; $CurrBtnR; $CurrBtnB)
		OBJECT GET BEST SIZE:C717(*; "ut_request_Cancel_btn"; BestW; CurrHt)
		If (BestW>($CurrBtnR-$CurrBtnL))
			$NewL:=$CurrBtnL-((BestW-($CurrBtnR-$CurrBtnL))/2)
			$NewR:=$NewL+BestW
			OBJECT MOVE:C664(ut_request_Cancel_btn; (-((BestW-($CurrBtnR-$CurrBtnL))/2)); 0; BestW; ($CurrBtnB-$CurrBtnT))
		End if 
		FORM GOTO PAGE:C247(ut_Request_Page_L)
		
End case 