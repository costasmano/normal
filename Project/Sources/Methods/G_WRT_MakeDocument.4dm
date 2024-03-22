//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): root
	// User name (4D): Designer
	// Date and time: 04/29/05, 15:51:23
	// ----------------------------------------------------
	// Method: G_WRT_MakeDocument
	// Description
	// Create, Save and open a document from 4D Write.
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(11/19/05 09:53:13) 
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(1/17/2007 15:16:04)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 14:41:06)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 12:12:30)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(3/7/11 08:58:52)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	// Modified by: costasmanousakis-(Designer)-(3/11/11 16:40:32)
	Mods_2011_03
	//  `use ut_CreateMSOfficeDoc to create the word document
	// Modified by: costasmanousakis-(Designer)-(3/14/11 14:49:18)
	Mods_2011_03
	//  `had to adjust the case when Win platform. 4D Write still creates a file with .RTF extension
	// Modified by: costasmanousakis-(Designer)-(6/27/11 13:23:12)
	Mods_2011_06
	//  `Load LetterHead picture from the templaces "IMG_BMSLetterHead"
	// Modified by: costasmanousakis-(Designer)-(8/24/11 09:28:17)
	Mods_2011_08
	//  `Changed logic to copy the letterhead logo from a 4DWrtie doc in WRT_BMSLetterhead
	//  `Has more consitant behavior across Mac and Window Platoforms.
	//  `Re-Setting the margins does not seem to work though.
	// Modified by: costasmanousakis-(Designer)-(9/12/11 16:04:39)
	Mods_2011_09
	//  `Restore the Templates record loaded at the start of this method - was causing problems in making multiple letters in a row
	// Modified by: Costas Manousakis-(Designer)-(5/29/15 12:46:45)
	Mods_2015_05
	//  `added code to resize the inserted  picture in the body of the document so that it fits in the original picture area.
	Mods_2021_Delete
End if 
//C_LONGINT($1;$DocPropertySet)  //Command Replaced was o_C_INTEGER
//If (Count parameters=1)
//$DocPropertySet:=$1
//Else 
//$DocPropertySet:=1
//End if 
//  //````4D WR commands
//C_LONGINT($newArea)
//$newArea:=WR New offscreen area 
//WR BLOB TO AREA ($newArea;[Templates]Template_)
//Case of 
//: ($DocPropertySet=1)
//WR SET DOC PROPERTY ($newArea;wr view references;0)
//WR SET DOC PROPERTY ($newArea;wr different on first page;1)
//WR SET DOC PROPERTY ($newArea;wr unit;1)  //set unit to inches
//WR SET DOC PROPERTY ($newArea;wr text left margin;1)
//WR SET DOC PROPERTY ($newArea;wr text right margin;0.5)
//WR SET DOC PROPERTY ($newArea;wr first page top margin;1)
//WR SET DOC PROPERTY ($newArea;wr first page bottom margin;1)
//WR SET DOC PROPERTY ($newArea;wr language;1033)
//: ($DocPropertySet=2)
//WR SET DOC PROPERTY ($newArea;wr view references;0)
//WR SET DOC PROPERTY ($newArea;wr different on first page;1)
//WR SET DOC PROPERTY ($newArea;wr unit;1)  //set unit to inches
//WR SET DOC PROPERTY ($newArea;wr text left margin;1)
//WR SET DOC PROPERTY ($newArea;wr text right margin;1)
//WR SET DOC PROPERTY ($newArea;wr first page bottom margin;1)
//WR SET DOC PROPERTY ($newArea;wr text bottom margin;1)
//WR SET DOC PROPERTY ($newArea;wr language;1033)

//: ($DocPropertySet=3)
//WR SET DOC PROPERTY ($newArea;wr view references;0)
//WR SET DOC PROPERTY ($newArea;wr different on first page;1)
//WR SET DOC PROPERTY ($newArea;wr unit;1)  //set unit to inches
//WR SET DOC PROPERTY ($newArea;wr first page bottom margin;1)
//WR SET DOC PROPERTY ($newArea;wr text left margin;0.8)
//WR SET DOC PROPERTY ($newArea;wr text right margin;0.8)
//WR SET DOC PROPERTY ($newArea;wr language;1033)

//: ($DocPropertySet=4)
//WR SET DOC PROPERTY ($newArea;wr view references;0)
//WR SET DOC PROPERTY ($newArea;wr unit;1)  //inches
//WR SET DOC PROPERTY ($newArea;wr language;1033)

//: ($DocPropertySet=5)
//WR SET DOC PROPERTY ($newArea;wr view references;0)
//WR SET DOC PROPERTY ($newArea;wr different on first page;1)
//WR SET DOC PROPERTY ($newArea;wr unit;1)  //set unit to inches
//WR SET DOC PROPERTY ($newArea;wr language;1033)

//End case 
//C_LONGINT($NumPics_L)
//C_BOOLEAN($TemplRO_b)
//$TemplRO_b:=Read only state([Templates])
//READ ONLY([Templates])
//C_LONGINT($CurrTemplateRec_L)
//$CurrTemplateRec_L:=Record number([Templates])
//C_TEXT($LetterTemplName_txt)

//$LetterTemplName_txt:="WRT_BMSLetterHead"
//QUERY([Templates];[Templates]TemplateName=$LetterTemplName_txt)
//If (Records in selection([Templates])=1)
//C_LONGINT($diff1stPage_L)
//$diff1stPage_L:=WR Get doc property ($newArea;wr different on first page)
//If ($diff1stPage_L=1)
//WR SET FRAME ($newArea;wr first header)
//Else 
//WR SET FRAME ($newArea;wr right header)
//End if 

//$NumPics_L:=WR Count ($newArea;wr nb pictures in text flow)
//If ($NumPics_L=1)
//WR SELECT ($newArea;4;1;MAXLONG)  // select the first pic in the header frame???
//C_REAL($PictWidth;$PictHeight;$OrigWidth;$OrigHeight;$HeadTopMargin;$NewPicHt_L)
//WR SET DOC PROPERTY ($newArea;wr unit;1)  //set unit to inches
//WR GET PICTURE SIZE ($newArea;$PictWidth;$PictHeight;$OrigWidth;$OrigHeight)
//LOAD RECORD([Templates])
//C_PICTURE($BMSLetterHead_pic)
//If (BLOB size([Templates]Template_)>0)
//C_LONGINT($TempArea_L)
//$TempArea_L:=WR New offscreen area 
//WR BLOB TO AREA ($TempArea_L;[Templates]Template_)
//WR SELECT ($TempArea_L;4;1)
//WR GET PICTURE SIZE ($newArea;$PictWidth;$PictHeight;$OrigWidth;$OrigHeight)
//  //If (Picture size($BMSLetterHead_pic)>0)
//If ($PictWidth>0)
//WR EXECUTE COMMAND ($TempArea_L;wr cmd copy)
//WR EXECUTE COMMAND ($newArea;wr cmd paste)
//  //WR INSERT PICTURE ($newArea;$BMSLetterHead_pic;0;1;1;1;1)
//  //WR INSERT PICTURE ($newArea;$BMSLetterHead_pic)
//  //WR SELECT ($newArea;4;1)  ` select the first pic ???
//WR GET PICTURE SIZE ($newArea;$PictWidth;$PictHeight;$OrigWidth;$OrigHeight)
//  //$PictWidth:=$PictWidth*($PictHeight/$NewPicHt_L)
//  //WR SET PICTURE SIZE ($newArea;$PictWidth;$PictHeight)

//  //The height of the header must fit the picture 
//If ($diff1stPage_L=1)
//$HeadTopMargin:=WR Get doc property ($newArea;wr header 1st page top margin)
//WR SET DOC PROPERTY ($newArea;wr first page top margin;$HeadTopMargin+$PictHeight)
//WR SET DOC PROPERTY ($newArea;wr header 1st page bottom mg;$PictHeight)
//Else 
//$HeadTopMargin:=WR Get doc property ($newArea;wr header top margin)
//WR SET DOC PROPERTY ($newArea;wr text top margin;$HeadTopMargin+$PictHeight)
//WR SET DOC PROPERTY ($newArea;wr header bottom margin;$PictHeight)
//End if 
//Else 

//End if 
//WR DELETE OFFSCREEN AREA ($TempArea_L)
//Else 

//End if 

//$BMSLetterHead_pic:=$BMSLetterHead_pic*0
//WR SET DOC PROPERTY ($newArea;wr unit;1)  //set unit to inches
//End if 
//WR SET FRAME ($newArea;wr text frame)
//End if 
//UNLOAD RECORD([Templates])

//GOTO RECORD([Templates];$CurrTemplateRec_L)
//LOAD RECORD([Templates])

//If (Not($TemplRO_b))
//READ WRITE([Templates])
//End if 

//C_PICTURE(LTR_PictureInsert_pict)  //declare just in case
//If (Picture size(LTR_PictureInsert_pict)>0)
//  //we need to add the picture
//C_LONGINT($NumPics_L)
//$NumPics_L:=WR Count ($newArea;wr nb pictures in text flow)
//WR SELECT ($newArea;4;1;MAXLONG)  // select the first pic ???

//  //get the current picture size
//WR GET PICTURE SIZE ($newArea;$PictWidth;$PictHeight;$OrigWidth;$OrigHeight)

//WR INSERT PICTURE ($newArea;LTR_PictureInsert_pict;0;1;1;1;1)
//WR SELECT ($newArea;4;1;MAXLONG)  //still the frist pic - select it again
//C_LONGINT($newPictWidth;$newPictHeight)
//WR GET PICTURE SIZE ($newArea;$newPictWidth;$newPictHeight;$OrigWidth;$OrigHeight)
//  //adjust the new picture size so that it is the same ht as the one in the template
//If ($newPictHeight>$PictHeight)
//WR SET PICTURE SIZE ($newArea;($PictHeight/$newPictHeight)*$newPictWidth;$PictHeight)
//End if 

//End if 
//C_BOOLEAN(LoadRatgInfoReq_b)
//If (LoadRatgInfoReq_b)
//C_LONGINT($numRefs_L;$i)
//$numRefs_L:=WR Count ($newArea;wr nb objects)
//For ($i;1;$numRefs_L)
//WR SELECT ($newArea;1;$i;0)  //Select the ref
//C_LONGINT($info1;$info2;$RefType;$DateFormat;$TimeFormat)
//C_TEXT($RefName;$NumFormat)
//WR GET REFERENCE ($newArea;$info1;$info2;$RefName;$RefType;$NumFormat;$DateFormat;$TimeFormat)
//If ($RefName="vAssignmentList")
//C_TEXT($AssignLine_txt)
//While (vAssignmentList#"")
//$AssignLine_txt:=Substring(vAssignmentList;1;Position(Char(13);vAssignmentList))
//If (Position("*";$AssignLine_txt)>0)
//WR SET TEXT PROPERTY ($newarea;wr bold;1)
//Else 
//WR SET TEXT PROPERTY ($newarea;wr bold;0)
//End if 
//WR INSERT TEXT ($newarea;$AssignLine_txt)
//vAssignmentList:=Substring(vAssignmentList;Length($AssignLine_txt)+1)
//End while 
//WR SET TEXT PROPERTY ($newarea;wr bold;0)
//WR INSERT TEXT ($newarea;Char(13))
//WR SET TEXT PROPERTY ($newarea;wr bold;1)
//WR INSERT TEXT ($newarea;vLoadRtgInfoNote_txt)
//WR SET TEXT PROPERTY ($newarea;wr bold;0)
//WR INSERT TEXT ($newarea;Char(13))

//$i:=$numRefs_L+1
//End if 

//End for 
//End if 
//  //TRACE
//C_TEXT($docSpec;$fileExtension)
//$docSpec:=ut_CreateMSOfficeDoc (".doc";"RTF ")
//If ($docSpec#"")
//If (User in group(Current user;"Design Access Group"))
//CONFIRM("Design user do you want to save the file also as a 4D Write file?")
//If (OK=1)
//WR SAVE DOCUMENT ($newArea;"")
//End if 
//End if 

//DELETE DOCUMENT($docSpec)
//WR SAVE DOCUMENT ($newArea;$docSpec;"RTF ")
//If (<>PL_LPlatfrm>2)
//  //Windows platform
//If (Test path name(Replace string($docSpec;".DOC";".RTF"))=Is a document)
//  //4D Write adds the .RTF in Win enviroment
//MOVE DOCUMENT(Replace string($docSpec;".DOC";".RTF");$docSpec)
//End if 
//End if 
//ut_OpenDocument ($docSpec)

//End if 

//If (False)
//_ O_MAP FILE TYPES("RTF ";"DOC";"Word Document")
//C_TIME($doc)
//$doc:=Create document("";"RTF ")
//If (OK=1)
//CLOSE DOCUMENT($doc)
//C_TEXT($docSpec;$fileExtension)
//$docSpec:=Document
//DELETE DOCUMENT($docSpec)
//WR SAVE DOCUMENT ($newArea;$docSpec;"RTF ")
//_ O_SET DOCUMENT CREATOR($docSpec;"MSWD")
//If (<>PL_LPlatfrm>2)
//  //Windows platform
//If (Test path name(Replace string($docSpec;".DOC";".RTF"))=Is a document)
//  //4D Write adds the .RTF in Win enviroment
//MOVE DOCUMENT(Replace string($docSpec;".DOC";".RTF");$docSpec)
//End if 
//Else 
//  //in MacOS
//$fileExtension:=GetFileExtension ($docSpec)
//If ($fileExtension#".doc")
//If (Test path name($docSpec+".doc")=Is a document)
//  //same name with .doc exists already - delete it first
//DELETE DOCUMENT($docSpec+".doc")
//Else 
//End if 
//MOVE DOCUMENT($docSpec;($docSpec+".doc"))  //add the extension- don't replace it
//$docSpec:=$docSpec+".doc"
//End if 

//End if 
//ut_OpenDocument ($docSpec)

//End if 

//End if 
//WR DELETE OFFSCREEN AREA ($newArea)