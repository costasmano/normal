//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/16, 15:22:19
//----------------------------------------------------
//Method: CNV_PrintToPDF
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/16/16 15:22:21)
	C_TEXT:C284(CNV_PrintToPDF; $1)
End if 
C_TEXT:C284($1; $PDFFolderPath_txt)
$PDFFolderPath_txt:=$1
C_PICTURE:C286($Converted_pic)

If (True:C214)
	
	C_TEXT:C284($FormName_txt)
	C_PICTURE:C286(vPicture1)
	vPicture1:=[Standard Photos:36]Std Photo:3
	
	If ([Standard Photos:36]Portrait:4)
		$FormName_txt:="singlephotoportrait"
	Else 
		$FormName_txt:="SinglePrintPhotoLand"
	End if 
	//_O_PAGE SETUP([Standard Photos]; $FormName_txt)
	FORM SET OUTPUT:C54([Standard Photos:36]; $FormName_txt)
	C_LONGINT:C283($prinHt_L)
	
	
	
	
	
	SET PRINT OPTION:C733(Destination option:K47:7; 3; $PDFFolderPath_txt+String:C10([Standard Photos:36]InspID:1)+"_"+String:C10([Standard Photos:36]StdPhotoID:7)+".pdf")
	$prinHt_L:=Print form:C5([Standard Photos:36]; $FormName_txt)
	PAGE BREAK:C6
Else 
	C_LONGINT:C283($TargetW_L; $TargetH_L; $Width_L; $Height_L)
	PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $Width_L; $Height_L)
	
	If ([Standard Photos:36]Portrait:4)
		$TargetW_L:=1472
		$TargetH_L:=1967
	Else 
		$TargetW_L:=1992
		$TargetH_L:=1242
	End if 
	C_REAL:C285($ScW_r; $ScH_r; $Scale_r)
	$ScW_r:=Round:C94($TargetW_L/$Width_L; 4)
	$ScH_r:=Round:C94($TargetH_L/$Height_L; 4)
	$Scale_r:=MinNum($ScW_r; $ScH_r)
	//If ($Scale_r>2)
	//$Scale_r:=2
	//End if 
	$Converted_pic:=[Standard Photos:36]Std Photo:3
	TRANSFORM PICTURE:C988($Converted_pic; Scale:K61:2; $Scale_r; $Scale_r)
	
	//CREATE THUMBNAIL($Converted_pic;$ThumbConverted_pic;$Width_L;$Height_L)
	
	CONVERT PICTURE:C1002($Converted_pic; "image/png")
	
	WRITE PICTURE FILE:C680($PDFFolderPath_txt+String:C10([Standard Photos:36]InspID:1)+"_"+String:C10([Standard Photos:36]StdPhotoID:7)+".png"; $Converted_pic; "image/png")
	$Converted_pic:=[Standard Photos:36]Std Photo:3
	//CREATE THUMBNAIL($Converted_pic;$ThumbConverted_pic;$Width_L;$Height_L)
	
	TRANSFORM PICTURE:C988($Converted_pic; Scale:K61:2; $Scale_r; $Scale_r)
	CONVERT PICTURE:C1002($Converted_pic; "image/jpg")
	
	WRITE PICTURE FILE:C680($PDFFolderPath_txt+String:C10([Standard Photos:36]InspID:1)+"_"+String:C10([Standard Photos:36]StdPhotoID:7)+".jpg"; $Converted_pic; "image/jpg")
	
	
	$Converted_pic:=$Converted_pic*0
	
	
End if 





//End CNV_PrintToPDF

