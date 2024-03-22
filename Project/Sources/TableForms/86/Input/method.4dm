If (False:C215)
	//Form Method: [Templates];"Input"
	
	// Modified by: costasmanousakis-(Designer)-(2/28/2006 15:54:23)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(4/13/2006 11:09:23)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 14:26:56)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/27/2007 08:55:39)
	Mods_2007_CM12_5301  //...
	Mods_2011_06  // CJ Miller`06/20/11, 11:24:13      ` Type all local variables for v11
	//Replace $MyArea with WRT_Template
	// Modified by: costasmanousakis-(Designer)-(8/31/11 16:11:34)
	Mods_2011_08
	//  `Move declaration of Template_Qrt_TableNo_L at top of on load event
	// Modified by: costasmanousakis-(Designer)-(10/5/11 11:43:43)
	Mods_2011_10
	//  `Added pages 5 and 6 Document and hierarchical List
	// Modified by: Costas Manousakis-(Designer)-(2/25/21 18:36:19)
	Mods_2021_02
	//  `added page 7 for Write Pro areas
	// Modified by: Costas Manousakis-(Designer)-(2022-03-16T00:00:00 19:21:50)
	Mods_2022_03
	//  `added NotSupported text objects on pages 1 , 4 for 4D write and 4D Chart templates
	//  `replaced quick report area with a subform with same variable (longint)
	//  `Added Tools button on quick report page to load/save quickreport
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		InitChangeStack(1)
		C_PICTURE:C286(IMG_Template)
		C_LONGINT:C283(Template_Qrt_TableNo_L; $NumTables; $i)
		C_LONGINT:C283(QRT_Template)  //initialize quick report var here
		OBJECT SET VISIBLE:C603(*; "WRT_Template"; False:C215)
		OBJECT SET VISIBLE:C603(*; "QRT_Template"; False:C215)
		OBJECT SET VISIBLE:C603(*; "IMG_Template"; False:C215)
		OBJECT SET VISIBLE:C603(*; "CHART_Template"; False:C215)
		OBJECT SET VISIBLE:C603(*; "NotSupported@"; False:C215)
		C_TEXT:C284(TMPL_TEMPLTYPE)
		TMPL_TEMPLTYPE:=""
		If (Is new record:C668([Templates:86]))
			Inc_Sequence("TemplateInc"; ->[Templates:86]TemplateID:1)
		Else 
			Case of 
				: ([Templates:86]TemplateName:2="CRT@")
					//C_PICTURE($tempPict)
					//BLOB TO VARIABLE([Templates]Template_;$tempPict)
					//Ô14500;7Ô (CHART_Template;$tempPict)
					//$tempPict:=$tempPict*0
					//Ô14500;105Ô (CHART_Template;-1;-1;-1;0)  //No Save Alert
					OBJECT SET VISIBLE:C603(*; "NotSupported@"; True:C214)
					FORM GOTO PAGE:C247(4)
					//TMPL_TEMPLTYPE:="4D Chart"
				: ([Templates:86]TemplateName:2="WRT@")
					//WR EXECUTE COMMAND (WRT_Template;wr cmd new)
					//WR BLOB TO AREA (WRT_Template;[Templates]Template_)
					//WR SET AREA PROPERTY (WRT_Template;wr modified;0;"")
					//  //Replace $MyArea with WRT_Template
					//C_LONGINT($viAreaMod)
					//C_TEXT($vsStrValue)
					//WR GET AREA PROPERTY (WRT_Template;wr modified;$viAreaMod;$vsStrValue)
					OBJECT SET VISIBLE:C603(*; "NotSupported@"; True:C214)
					FORM GOTO PAGE:C247(1)
					//OBJECT SET VISIBLE(*;"WRT_Template";True)
					//TMPL_TEMPLTYPE:="4D Write"
				: ([Templates:86]TemplateName:2="QRT_@")
					C_POINTER:C301($qrarea_ptr)
					$qrarea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "qrt_template")
					$NumTables:=Get last table number:C254
					ARRAY TEXT:C222(Template_Qrt_TableNm_ar; $NumTables)  //Command Replaced was o_ARRAY string length was 32
					ARRAY LONGINT:C221(Template_Qrt_TableNo_ar; $NumTables)
					For ($i; 1; $NumTables)
						Template_Qrt_TableNm_ar{$i}:=Table name:C256($i)
						Template_Qrt_TableNo_ar{$i}:=$i
					End for 
					SORT ARRAY:C229(Template_Qrt_TableNm_ar; Template_Qrt_TableNo_ar)
					Template_Qrt_TableNm_ar:=0
					Template_Qrt_TableNo_L:=0
					//SET TIMER(1)
					If (Length:C16(String:C10($qrarea_ptr->))=10)
						//is a quick report area clear and make a new one
						C_TEXT:C284($MethodCalledOnErr)
						$MethodCalledOnErr:=Method called on error:C704
						ON ERR CALL:C155("4D_Errors")
						QR DELETE OFFSCREEN AREA:C754($qrarea_ptr->)
						ON ERR CALL:C155($MethodCalledOnErr)
						QR NEW AREA:C1320($qrarea_ptr)
					End if 
					OBJECT SET VISIBLE:C603(*; "QRT_Template"; True:C214)
					FORM GOTO PAGE:C247(2)
					TMPL_TEMPLTYPE:="4D Quick Report"
					
				: ([Templates:86]TemplateName:2="IMG_@")
					C_LONGINT:C283($w; $h)
					BLOB TO VARIABLE:C533([Templates:86]Template_:3; IMG_Template)
					PICTURE PROPERTIES:C457(IMG_Template; $w; $h)
					PicDims:=String:C10($w)+"x"+String:C10($h)
					OBJECT SET VISIBLE:C603(*; "IMG_Template"; True:C214)
					FORM GOTO PAGE:C247(3)
					TMPL_TEMPLTYPE:="Images"
					
				: ([Templates:86]TemplateName:2="DOC_@")
					C_LONGINT:C283($Offset_L)
					BLOB TO VARIABLE:C533([Templates:86]Template_:3; TMPL_FileName_txt)
					FORM GOTO PAGE:C247(5)
					TMPL_TEMPLTYPE:="Document"
					
				: ([Templates:86]TemplateName:2="LST_@")
					C_LONGINT:C283($Offset_L)
					C_LONGINT:C283(TMPL_HList_L)
					If (Is a list:C621(TMPL_HList_L))
						CLEAR LIST:C377(TMPL_HList_L; *)
					Else 
						TMPL_HList_L:=New list:C375
					End if 
					
					TMPL_HList_L:=BLOB to list:C557([Templates:86]Template_:3)
					FORM GOTO PAGE:C247(6)
					TMPL_TEMPLTYPE:="List"
					
				: (([Templates:86]TemplateName:2="WRP@") | ([Templates:86]TemplateName:2="WPT@"))
					C_POINTER:C301($WpArea_ptr)
					$WpArea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")
					$WpArea_ptr->:=WP New:C1317([Templates:86]Template_:3)
					FORM GOTO PAGE:C247(7)
					
			End case 
			C_LONGINT:C283(Template_Size_L)
			Template_Size_L:=BLOB size:C605([Templates:86]Template_:3)
		End if 
		TMPL_TEMPLTYPE:=TMPL_TEMPLTYPE+" Templates"
		OBJECT SET VISIBLE:C603(bzPage1; False:C215)
		OBJECT SET VISIBLE:C603(bzPage2; False:C215)
		
		GOTO OBJECT:C206([Templates:86]TemplateDesc:4)
	: (Form event code:C388=On Validate:K2:3)
		
		FlushGrpChgs(1; ->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; 0)
	: (Form event code:C388=On Timer:K2:25)
		SET TIMER:C645(0)
		C_POINTER:C301($qrarea_ptr)
		$qrarea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "qrt_template")
		
		QR BLOB TO REPORT:C771($qrarea_ptr->; [Templates:86]Template_:3)
		OBJECT SET VISIBLE:C603(*; "QRT_Template"; True:C214)
		FORM GOTO PAGE:C247(2)
		REDRAW:C174($qrarea_ptr->)
		
		Template_Qrt_TableNo_L:=QR Get report table:C758($qrarea_ptr->)
		POPUPMENUC(->Template_Qrt_TableNm_ar; ->Template_Qrt_TableNo_ar; ->Template_Qrt_TableNo_L)
		TMPL_TEMPLTYPE:="4D Quick Report"
	: (Form event code:C388=On Timer:K2:25)
		
		If (QRT_Template>0)
			QR DELETE OFFSCREEN AREA:C754(QRT_Template)
			
		End if 
		
End case 