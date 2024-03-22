//Method: [Activity Log].ViewExtras
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 11:17:37
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12  //Add ability to view pictures/text/and 4d write areas form activity log input form
	//Modified by: Chuck Miller (12/11/18 13:53:23)
	// Modified by: Costas Manousakis-(Designer)-(2/1/21 18:55:52)
	Mods_2021_02
	//  `Added WP area on page 4 , quick report on page 5, and option to view blob as Text
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-01-06T00:00:00 16:29:59)
	Mods_2022_01
	//  `added Button on pg 0 to change dataview - Can be used on windows when start pop up menu does not display
End if 
//
If (Form event code:C388=On Load:K2:1)
	
	Case of 
		: (v_58_005_txt#"")
			FORM GOTO PAGE:C247(1)
			
		: (Picture size:C356(v_36_003_p)>0)
			FORM GOTO PAGE:C247(2)
			
		: (BLOB size:C605(v_86_003_blb)>0)
			C_LONGINT:C283($Selection_L)
			C_TEXT:C284($QueryBy_txt)
			$QueryBy_txt:="View as Picture;View as 4D write;View as 4D Write PRO;View as QuickReport;View as Text"
			$Selection_L:=Pop up menu:C542($QueryBy_txt)
			
			Case of 
				: ($Selection_L=1)
					BLOB TO PICTURE:C682(v_86_003_blb; v_36_003_p)
					FORM GOTO PAGE:C247(2)
				: ($Selection_L=2)
					ALERT:C41("Cannot view 4D Write data!")
				: ($Selection_L=3)
					C_TEXT:C284($datatag)
					C_LONGINT:C283($offset; $compressed)
					C_BLOB:C604($WPBlob)
					BLOB PROPERTIES:C536(v_86_003_blb; $compressed)
					
					If ($compressed#0)
						EXPAND BLOB:C535(v_86_003_blb)
					End if 
					$offset:=0
					BLOB TO VARIABLE:C533(v_86_003_blb; $datatag; $offset)
					If ($datatag="WPAREA")
						BLOB TO VARIABLE:C533(v_86_003_blb; $WPBlob; $offset)
					Else 
						//Assume it is all a WP blob
						$WPBlob:=v_86_003_blb
					End if 
					C_POINTER:C301($WPArea_ptr)
					$WPArea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")
					$WPArea_ptr->:=WP New:C1317($WPBlob)
					
					FORM GOTO PAGE:C247(4)
					
				: ($Selection_L=4)
					C_POINTER:C301($QRTArea_ptr)
					$QRTArea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "QuickReport")
					QR BLOB TO REPORT:C771($QRTArea_ptr->; v_86_003_blb)
					FORM GOTO PAGE:C247(5)
					
				: ($Selection_L=5)
					BLOB TO VARIABLE:C533(v_86_003_blb; v_58_005_txt)
					FORM GOTO PAGE:C247(1)
					
			End case 
			
	End case 
End if 
//End [Activity Log].ViewExtras