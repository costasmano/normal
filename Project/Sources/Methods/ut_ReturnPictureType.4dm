//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/07/16, 13:07:40
//----------------------------------------------------
//Method: ut_ReturnPictureType
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/7/16 13:09:03)
	C_PICTURE:C286(ut_ReturnPictureType; $1)
	C_LONGINT:C283(ut_ReturnPictureType; $0)
	
	
End if 
C_PICTURE:C286($1; $pic)
C_LONGINT:C283($0)
C_BLOB:C604($blob; $blob2)

If (Count parameters:C259=1)
	
	$pic:=$1
	
	PICTURE TO BLOB:C692($pic; $blob2; "")
	COPY BLOB:C558($blob2; $blob; 0; 0; 10)
	SET BLOB SIZE:C606($blob2; 0)
	
	Case of 
		: (($blob{0}=255) & ($blob{1}=216))  // JPEG
			$0:=1
			
		: (($blob{0}=66) & ($blob{1}=77))  // BMP
			$0:=2
		: (($blob{0}=71) & ($blob{1}=73) & ($blob{2}=70))  // GIF
			$0:=3
		: (($blob{0}=137) & ($blob{1}=80) & ($blob{2}=78))  // PNG
			$0:=4
		: (($blob{0}=73) & ($blob{1}=73) & ($blob{2}=42))  // TIFF
			$0:=5
		: (($blob{0}=77) & ($blob{1}=77) & ($blob{2}=0))  // TIFF
			$0:=5
		: (($blob{0}=60) & ($blob{1}=63) & ($blob{2}=120))  // SVG
			$0:=6
		: (($blob{0}=54) & ($blob{1}=0))  // PICT
			$0:=7
		: (($blob{0}=15) & ($blob{1}=154) & ($blob{2}=0))  // 4PCT
			$0:=8
		: (($blob{0}=1) & ($blob{1}=0) & ($blob{2}=0))  // EMF
			$0:=9
		: (($blob{0}=73) & ($blob{1}=73) & ($blob{2}=188))  // WDP
			$0:=10
		: (($blob{0}=0) & ($blob{1}=0) & ($blob{2}=1))  // ICON
			$0:=11
		: (($blob{0}=133) & ($blob{1}=56))  // PICT
			$0:=12
		: (($blob{0}=37) & ($blob{1}=80) & ($blob{2}=68) & ($blob{3}=70))  //PDF
			$0:=13
		Else 
			
			$0:=14  // Not determined
	End case 
	
End if 

//End ut_ReturnPictureType