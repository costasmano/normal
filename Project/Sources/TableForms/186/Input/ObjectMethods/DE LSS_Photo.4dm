//Object Method: [TIN_Insp_Images];"Input".Photo_pct 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(8/10/16 12:24:03)
	Mods_2016_08_bug
	//  `Removed  converting to Jpeg, added check for PDF - if PDF clear picture.
End if 
//
C_LONGINT:C283($0)
$0:=0

C_BLOB:C604($NewPicture_blb)
C_POINTER:C301($src_ptr; $mypic_ptr; $null_ptr)
C_LONGINT:C283($srcline; $srcproc; $tbl_L; $fld_L)
C_TEXT:C284($varname_txt)
C_BOOLEAN:C305(LSS_ThisPictureDrag_b)

Case of 
	: (Form event code:C388=On Begin Drag Over:K2:44)
		LSS_ThisPictureDrag_b:=True:C214
		
	: (Form event code:C388=On Drag Over:K2:13)
		
		//_O_DRAG AND DROP PROPERTIES($src_ptr; $srcline; $srcproc)
		//RESOLVE POINTER($src_ptr; $varname_txt; $tbl_L; $fld_L)
		
		//$mypic_ptr:=->Photo_pct
		//Case of 
		//: ($src_ptr=$null_ptr)
		
		//$0:=-1
		//: ($src_ptr=$mypic_ptr) & ($srcproc=Current process)
		
		//$0:=-1
		//End case 
		
	: (Form event code:C388=On Drop:K2:12)
		
		
	: (Form event code:C388=On After Edit:K2:43)
		If (ut_ReturnPictureType(Photo_pct)=13)  //PDF not allowed
			ALERT:C41("PDF files not allowed!")
			Photo_pct:=Photo_pct*0
		Else 
			
		End if 
		[TIN_Insp_Images:186]ImagePic:3:=Photo_pct
		PushChange(2; ->[TIN_Insp_Images:186]ImagePic:3)
		C_TEXT:C284(vPictStats)
		C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		PICTURE PROPERTIES:C457([TIN_Insp_Images:186]ImagePic:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356([TIN_Insp_Images:186]ImagePic:3); "##,###,### Bytes")+")"
		vbPictureChanged:=True:C214
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End Object Method: [LSS_Photos].Input.Photo_pct