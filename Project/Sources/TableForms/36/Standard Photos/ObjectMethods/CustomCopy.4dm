//Method: Object Method: [Standard Photos];"Standard Photos".Button1
//Description
//  ` pick elements of pasteboard to copy in the picture field and what format
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/28/14, 12:17:26
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
	//checkthisone
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_PICTURE:C286($vTempPic_p)
		C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode; $res; $tbl_L; $fld_L)
		C_TEXT:C284($varname; $fldname)
		RESOLVE POINTER:C394(Focus object:C278; $varname; $tbl_L; $fld_L)
		$fldname:=""
		If ($tbl_L=Table:C252(->[Standard Photos:36]))
			$fldname:=Field name:C257($tbl_L; $fld_L)
		End if 
		
		ALERT:C41($varname+" - ["+String:C10($tbl_L)+"] - "+String:C10($fld_L)+" : "+$fldname)
		
		If ($fldname=Field name:C257(->[Standard Photos:36]Std Photo:3))
			
			GET PICTURE FROM PASTEBOARD:C522($vTempPic_p)
			If (Picture size:C356($vTempPic_p)>0)
				$vTempPic_p:=ut_ImageFromPasteboard
				C_BLOB:C604($temp_blb)
				ARRAY TEXT:C222($codecs_atxt; 0)
				ARRAY TEXT:C222($codecnames_atxt; 0)
				
				PICTURE CODEC LIST:C992($codecs_atxt; $codecnames_atxt)
				
				C_LONGINT:C283($codec_L)
				
				$codec_L:=G_PickFromList(->$codecs_atxt; "pick a codec")
				If ($codec_L>0)
					PICTURE TO BLOB:C692($vTempPic_p; $temp_blb; $codecs_atxt{$codec_L})
					BLOB TO PICTURE:C682($temp_blb; $vTempPic_p)
					
					If (Picture size:C356($vTempPic_p)>1500000)
						ALERT:C41("picture size was "+String:C10(Picture size:C356($vTempPic_p); Blank if null date:K1:9))
						CONVERT PICTURE:C1002($vTempPic_p; ".jpg")
						ALERT:C41("converted to JPEG")
					End if 
					
				End if 
				If (Picture size:C356($vTempPic_p)>0)
					[Standard Photos:36]Std Photo:3:=$vTempPic_p
					vbPictureChanged:=True:C214
					REDRAW:C174([Standard Photos:36]Std Photo:3)
					C_TEXT:C284(vPictStats)
					PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
					vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
					vPictStats:=vPictStats+"("+String:C10(Picture size:C356([Standard Photos:36]Std Photo:3); "##,###,### Bytes")+")"
					
				End if 
			Else 
				ALERT:C41("There is no picture in the clipboard!")
			End if 
			
		Else 
			ALERT:C41("This funstion only applies to the Image field!")
		End if 
		If (False:C215)
			
			C_LONGINT:C283($origSize_L)
			$origSize_L:=Picture size:C356([Standard Photos:36]Std Photo:3)
			//added to test convert picture and scaling
			CONFIRM:C162("Scale image?"; "Scale"; "nope")
			If (OK=1)  //code for sketches/charts
				C_REAL:C285($scale_r)
				$scale_r:=Num:C11(Request:C163("Scale to Gt 1"; "2"))
				CONFIRM:C162("Transform or Multiply?"; "Transform"; "Multiply")
				If (ok=1)
					TRANSFORM PICTURE:C988([Standard Photos:36]Std Photo:3; Scale:K61:2; $scale_r; $scale_r)
				Else 
					[Standard Photos:36]Std Photo:3:=[Standard Photos:36]Std Photo:3*$scale_r
				End if 
				
			End if 
			CONFIRM:C162("make thumbnail?")
			If (OK=1)
				PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
				CREATE THUMBNAIL:C679([Standard Photos:36]Std Photo:3; [Standard Photos:36]Std Photo:3; $vPicW; $vPicH)
			End if 
			//for photos just do this
			C_TEXT:C284($ConvertTo_txt)
			
			If ([Standard Photos:36]PictType:5=BMS Photo)
				$ConvertTo_txt:="image/jpeg"
			Else 
				$ConvertTo_txt:="image/png"
			End if 
			
			$ConvertTo_txt:=Request:C163("Image format "; $ConvertTo_txt)
			If (False:C215)
				CONVERT PICTURE:C1002([Standard Photos:36]Std Photo:3; $ConvertTo_txt)
			Else 
				CONVERT PICTURE:C1002([Standard Photos:36]Std Photo:3; $ConvertTo_txt)
			End if 
			
			PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
			vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
			vPictStats:=vPictStats+"("+String:C10(Picture size:C356([Standard Photos:36]Std Photo:3); "##,###,### Bytes")+")"
			vPictStats:=vPictStats+" orig.="+String:C10($origSize_L; "##,###,###")+")"
			
		End if 
		
End case 

//End Object Method: [Standard Photos].Standard Photos.Button1