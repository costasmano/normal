//%attributes = {"invisible":true}
//Method: G_WP_MakeDocument
//Description
//  // Create, Save and open a document from Write Pro.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/29/21, 19:35:20
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	// Modified by: Costas Manousakis-(Designer)-(2022-04-20 17:59:21)
	Mods_2022_04
	//  `make [templates] read only
	// Modified by: Costas Manousakis-(Designer)-(2023-01-09 18:12:03)
	Mods_2023_01_bug
	//  `when header of first page is not found, try the default doc header to see if there is a picture in there.
End if 
//
//STILLWORKINGONTHIS:=True
C_OBJECT:C1216($WpArea; $letterhdArea)

$WpArea:=WP New:C1317([Templates:86]Template_:3)
C_LONGINT:C283($currTemplID_L)
$currTemplID_L:=[Templates:86]TemplateID:1
C_BLOB:C604($letterhead_blb)
C_COLLECTION:C1488($pics_co)
C_OBJECT:C1216($pic_o; $Body_o; $picrange; $picPos_o; $localHeaderpic_o; $header_o; $footer_o)
C_LONGINT:C283($PictHeight; $PictWidth; $picstart; $picend; $pictype)
C_PICTURE:C286($letterhead_pic; $picimage)
READ ONLY:C145([Templates:86])
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_BMSLetterHead")

If (Records in selection:C76([Templates:86])=1)
	$letterhead_blb:=[Templates:86]Template_:3
	//find if we have a picture in current template in header of 1st page
	WP SET ATTRIBUTES:C1342($WpArea; wk layout unit:K81:78; wk unit pt:K81:136)
	$header_o:=WP Get header:C1503($WpArea; 1; wk first page:K81:203)
	If ($header_o=Null:C1517)
		//there is no first page header - get the overall doc header
		$header_o:=WP Get header:C1503($WpArea; 1)
	End if 
	If (Not:C34($header_o=Null:C1517))
		//current template has a first page header section
		$pics_co:=WP Get elements:C1550($header_o; wk type image:K81:192)
		C_LONGINT:C283($count_L)
		$count_L:=0
		C_BOOLEAN:C305($haveheaderPic)
		If ($pics_co.length=1)
			$haveheaderPic:=True:C214
			$localHeaderpic_o:=$pics_co[0]
		End if 
		
		If ($haveheaderPic)
			//now get it from the letterhead blob
			$letterhdArea:=WP New:C1317($letterhead_blb)
			WP SET ATTRIBUTES:C1342($letterhdArea; wk layout unit:K81:78; wk unit pt:K81:136)
			//$header_o:=WP Get header($letterhdArea;1)  // the letterhead template does not have a diff 1st page
			//$pics_co:=WP Get elements($header_o;wk type image)
			$pics_co:=WP Get elements:C1550($letterhdArea; wk type image:K81:192)  // there is only one image in the letterhead template
			//$pics_co:=WP Get elements($letterhdArea;wk type image)
			$pic_o:=$pics_co[0]
			C_REAL:C285($localHt; $localW; $logoH; $logoW)
			WP GET ATTRIBUTES:C1345($pic_o; wk image:K81:169; $letterhead_pic; wk height:K81:46; $logoH; wk width:K81:45; $logow)  //
			WP GET ATTRIBUTES:C1345($localHeaderpic_o; wk height:K81:46; $localHt; wk width:K81:45; $localW)
			WP SET ATTRIBUTES:C1342($localHeaderpic_o; wk image:K81:169; $letterhead_pic)
			WP SET ATTRIBUTES:C1342($localHeaderpic_o; wk height:K81:46; ($logoH*($localW/$logoW)))
		End if 
		
	End if 
	
End if 

//load back the original template
QUERY:C277([Templates:86]; [Templates:86]TemplateID:1=$currTemplID_L)

C_PICTURE:C286(LTR_PictureInsert_pict)  //declare just in case
If (Picture size:C356(LTR_PictureInsert_pict)>0)
	//we need to add the picture
	$Body_o:=WP Text range:C1341($WpArea; wk start text:K81:165; wk end text:K81:164)
	$pics_co:=WP Get elements:C1550($WpArea; wk type image inline:K81:247)
	WP SET ATTRIBUTES:C1342($Body_o; wk layout unit:K81:78; wk unit pt:K81:136)
	C_BOOLEAN:C305($picinmiddle)
	For each ($pic_o; $pics_co)
		//WP GET ATTRIBUTES($pic_o;wk height;$PictHeight;wk width;$PictWidth;\
			 wk image;$picimage;wk type;$pictype)
		$picrange:=WP Text range:C1341($pic_o; wk start text:K81:165; wk end text:K81:164)
		$picinmiddle:=($picrange.start>($Body_o.start+(0.02*$Body_o.end))) & \
			($picrange.end<($Body_o.end-(0.02*$Body_o.end)))
		If ($picinmiddle)
			//WP INSERT PICTURE($picrange;LTR_PictureInsert_pict;wk replace;wk include in range)
			WP SET ATTRIBUTES:C1342($pic_o; wk image:K81:169; LTR_PictureInsert_pict)
		End if 
	End for each 
	
End if 

C_BOOLEAN:C305(LoadRatgInfoReq_b)
If (LoadRatgInfoReq_b)
	// need to bold only assignment lines that have a * in them
	ARRAY LONGINT:C221($exprPos_aL; 0)
	ARRAY TEXT:C222($exprname_atxt; 0)
	
	C_LONGINT:C283($numRefs_L; $i; $listPos_L)
	$numRefs_L:=WP_GetExpressions(->$WpArea; ->$exprPos_aL; ->$exprname_atxt)
	
	$listPos_L:=Find in array:C230($exprname_atxt; "vAssignmentList")
	If ($listPos_L>0)
		C_OBJECT:C1216($range_o; $Line_o)
		ARRAY TEXT:C222($assignLines_atxt; 0)
		ut_NewTextToArray(vAssignmentList; ->$assignLines_atxt; Char:C90(13))
		$range_o:=WP Text range:C1341($WpArea; $exprPos_aL{$listPos_L}; $exprPos_aL{$listPos_L}+1)
		//clear the expression first
		WP SET TEXT:C1574($range_o; ""; wk replace:K81:177; wk include in range:K81:180)
		C_LONGINT:C283($loop_L; $lineStart; $LineEnd)
		For ($loop_L; 1; Size of array:C274($assignLines_atxt))
			$lineStart:=$range_o.end
			//$Line_o:=WP New($assignLines_atxt{$loop_L})
			WP SET TEXT:C1574($range_o; $assignLines_atxt{$loop_L}; wk append:K81:179; wk include in range:K81:180)
			$LineEnd:=$range_o.end
			$Line_o:=WP Text range:C1341($WpArea; $lineStart; $LineEnd)
			If (Position:C15("*"; $assignLines_atxt{$loop_L})>0)
				WP SET ATTRIBUTES:C1342($Line_o; wk font bold:K81:68; wk true:K81:174)
			Else 
				WP SET ATTRIBUTES:C1342($Line_o; wk font bold:K81:68; wk false:K81:173)
			End if 
			WP SET TEXT:C1574($range_o; Char:C90(Carriage return:K15:38); wk append:K81:179; wk include in range:K81:180)
			$Line_o:=WP Text range:C1341($WpArea; $range_o.end; $range_o.end)
			WP SET ATTRIBUTES:C1342($Line_o; wk font bold:K81:68; wk false:K81:173)
			
			//WP INSERT DOCUMENT($range_o;$Line_o;wk append;wk include in range)
		End for 
		
		WP SET TEXT:C1574($range_o; Char:C90(Carriage return:K15:38); wk append:K81:179; wk include in range:K81:180)
		$lineStart:=$range_o.end
		WP SET TEXT:C1574($range_o; vLoadRtgInfoNote_txt; wk append:K81:179; wk include in range:K81:180)
		$LineEnd:=$range_o.end
		$Line_o:=WP Text range:C1341($WpArea; $lineStart; $LineEnd)
		WP SET ATTRIBUTES:C1342($Line_o; wk font bold:K81:68; wk true:K81:174)
		WP SET TEXT:C1574($range_o; Char:C90(Carriage return:K15:38); wk append:K81:179; wk include in range:K81:180)
		$Line_o:=WP Text range:C1341($WpArea; $range_o.end; $range_o.end)
		WP SET ATTRIBUTES:C1342($Line_o; wk font bold:K81:68; wk false:K81:173)
		
	End if 
	
End if 

C_TEXT:C284($docSpec; $fileExtension)
ARRAY TEXT:C222($files_atxt; 0)
$docSpec:=Select document:C905(""; ".docx"; "Select file to save letter"; File name entry:K24:17; $files_atxt)
If (OK=1)
	ST COMPUTE EXPRESSIONS:C1285($WpArea; ST Start text:K78:15; ST End text:K78:16)
	ST FREEZE EXPRESSIONS:C1282($WpArea; ST Start text:K78:15; ST End text:K78:16; *)
	$footer_o:=WP Get footer:C1504($WpArea; 1; wk first page:K81:203)
	ST COMPUTE EXPRESSIONS:C1285($footer_o; ST Start text:K78:15; ST End text:K78:16)
	ST FREEZE EXPRESSIONS:C1282($footer_o; ST Start text:K78:15; ST End text:K78:16; *)
	$footer_o:=WP Get footer:C1504($WpArea; 1)
	ST COMPUTE EXPRESSIONS:C1285($footer_o; ST Start text:K78:15; ST End text:K78:16)
	ST FREEZE EXPRESSIONS:C1282($footer_o; ST Start text:K78:15; ST End text:K78:16; *)
	$footer_o:=WP Get header:C1503($WpArea; 1)
	ST COMPUTE EXPRESSIONS:C1285($footer_o; ST Start text:K78:15; ST End text:K78:16)
	ST FREEZE EXPRESSIONS:C1282($footer_o; ST Start text:K78:15; ST End text:K78:16; *)
	
	//Count pages
	C_LONGINT:C283($fontsize; $newfontsize)
	If (WP Get page count:C1412($WpArea)>1)
		C_OBJECT:C1216($Body_o)
		$Body_o:=WP Get body:C1516($WpArea)
		WP GET ATTRIBUTES:C1345($Body_o; wk font size:K81:66; $fontsize)
		If ($fontsize>0)
			
		Else 
			$fontsize:=12
		End if 
		
		$newfontsize:=$fontsize
		Repeat 
			$newfontsize:=$newfontsize-1
			WP SET ATTRIBUTES:C1342($Body_o; wk font size:K81:66; $newfontsize)
		Until (WP Get page count:C1412($WpArea)=1) | ($newfontsize=3)
		
	Else 
		$fontsize:=0
	End if 
	
	WP EXPORT DOCUMENT:C1337($WpArea; $files_atxt{1}; wk docx:K81:277; wk normal:K81:7)
	//WP EXPORT DOCUMENT($WpArea;$files_atxt{1}+".4WP";wk 4wp;wk normal)
	//SHOW ON DISK($files_atxt{1})
	//ut_OpenDocument ($files_atxt{1})
	OpenWordDoc(New object:C1471("filename"; $files_atxt{1}; "fontsize"; $fontsize))
End if 

//End G_WP_MakeDocument