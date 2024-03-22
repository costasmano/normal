//%attributes = {"invisible":true}
// Method: LSS_PrintInspection
// Description
// Print Inspection report
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 11/13/14, 11:12:23
	// ----------------------------------------------------
	
	C_LONGINT:C283(LSS_PrintInspection; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(1/7/16 14:43:44)
	Mods_2016_01_bug
	//  `added code to count UT print pages accounting for more than 11 rods per UT- 2nd pages take up to 18
	// Modified by: Costas Manousakis-(Designer)-(1/25/16 )
	Mods_2016_01_bug
	//  `added missing call to set query destination into curr sel after the DMeter count
	// Modified by: Costas Manousakis-(Designer)-(2/19/16 10:29:09)
	Mods_2016_02_bug
	//  `added call to LSS_AddAddtlCmnts when needed; consider [LSS_Inspection]LSS_AdditionalComments_txt when  printing comments
	// Modified by: Costas Manousakis-(Designer)-(5/12/16 16:44:38)
	Mods_2016_05
	//  `use ◊ShowPrint to print settings
	// Modified by: Costas Manousakis-(Designer)-(10/21/16 11:40:58)
	Mods_2016_10
	//  `set print preview to false at startup
	// Modified by: CJMiller-(Designer)-(10/17/18 10:31:16)
	Mods_2018_10
	//  `use LSS_NonDamageAddHeader
	// Modified by: Costas Manousakis-(Designer)-(11/5/18 16:00:38)
	Mods_2018_11
	//  `removed extra ":" from photo/sketch log text
	// Modified by: Costas Manousakis-(Designer)-(2/14/20 17:39:40)
	Mods_2020_02_bug
	//  `before generating the preview pic in comments and photolog set the exact page size of the WR document
	// Modified by: Costas Manousakis-(Designer)-(2/19/20 17:28:13)
	Mods_2020_02_bug
	//  `adjustments made to compensate for windows display scaling when generating a WR preview picture CallReference #695
	// Modified by: Costas Manousakis-(Designer)-(12/21/20 16:08:06)
	Mods_2020_12_bug
	//  `moved code to adjust page width and ht of 4D WR area at the start of collecting comments and creation of sketch/photo log
	//  ` CallReference #760
	// Modified by: Costas Manousakis-(Designer)-(2/19/21 17:23:40)
	Mods_2021_02
	//  `set units of photo log to inches before settingt the par indents. set paragraph indent to 1 inch 
	//  `clean up some code. added call to WR SET DOC PROPERTY ($CommentArea_L;wr widow orphan;wr ignored)
	//  `we handle the widow paragraphs.
	// Modified by: Costas Manousakis-(Designer)-(2/23/21 11:04:56)
	Mods_2021_02
	//  `added G_PrintOptions to correctly pick the Letter paper
	Mods_2021_Delete
	
End if 

//vPageNo:=2
//C_TEXT($oldWinTitle;$newWinTitle;$prevSpoolDocName)  // **Replaced old C_STRING length 255
//C_LONGINT($LBCol_L;$LBRow_L;viInspPreviewErr;$DMeterCount_L;$UTCount_L)
//C_TEXT($Header_txt)
//C_BOOLEAN($CreatePDF_B)
//  //Guarantee this.
//If (Count parameters>0)
//C_LONGINT($1)
//$LBRow_L:=$1
//Else 
//LISTBOX GET CELL POSITION(*;"Inspection_LB";$LBCol_L;$LBRow_L)
//End if 

//If ($LBRow_L>0)
//GOTO SELECTED RECORD([LSS_Inspection];$LBRow_L)

//SET PRINT OPTION(Orientation option;1)
//SET PRINT OPTION(Paper option;"Letter")
//SET PRINT OPTION(Scale option;100)
//G_PrintOptions 
//SET PRINT PREVIEW(False)

//If (<>ShowPrint)  //| (Not(Is compiled mode))
//PRINT SETTINGS
//End if 

//End if 
//  //get the prview choise here and set it for later
//If (OK=1)  //user can cancel from the print settings  

//BRING TO FRONT(Current process)
//G_PrintOptions 

//VSINSPDEPARTMENT:="MASSACHUSETTS DEPARTMENT OF TRANSPORTATION"
//LOAD RECORD([LSS_Inspection])
//LSS_FillPage1_FM ([LSS_Inspection]LSS_InspectionTypeId_s)

//vTotalPages:=2
//  //Get number of photos

//SET QUERY DESTINATION(Into set;"LSS_InspectionPhotoSet")
//QUERY([LSS_Photos];[LSS_Photos]LSS_InspectionId_s=[LSS_Inspection]LSS_InspectionId_s)
//SET QUERY DESTINATION(Into set;"DMeterPhotoSet")
//USE SET("LSS_InspectionPhotoSet")
//QUERY SELECTION([LSS_Photos];[LSS_Photos]LSS_PhotoType_s="Sketch D Meter")
//SET QUERY DESTINATION(Into set;"UMeterPhotoSet")
//USE SET("LSS_InspectionPhotoSet")
//QUERY SELECTION([LSS_Photos];[LSS_Photos]LSS_PhotoType_s="Sketch UT")
//DIFFERENCE("LSS_InspectionPhotoSet";"DMeterPhotoSet";"LSS_InspectionPhotoSet")
//DIFFERENCE("LSS_InspectionPhotoSet";"UMeterPhotoSet";"LSS_InspectionPhotoSet")
//SET QUERY DESTINATION(Into set;"LSS_SketchSet")
//USE SET("LSS_InspectionPhotoSet")
//QUERY SELECTION([LSS_Photos];[LSS_Photos]LSS_PhotoType_s="Sketch@")
//SET QUERY DESTINATION(Into set;"LSS_ChartSet")
//USE SET("LSS_InspectionPhotoSet")
//QUERY SELECTION([LSS_Photos];[LSS_Photos]LSS_PhotoType_s="Chart@")
//SET QUERY DESTINATION(Into current selection)
//DIFFERENCE("LSS_InspectionPhotoSet";"LSS_SketchSet";"LSS_InspectionPhotoSet")
//DIFFERENCE("LSS_InspectionPhotoSet";"LSS_ChartSet";"LSS_InspectionPhotoSet")


//  //vTotalPages:=vTotalPages+Records in set("DMeterPhotoSet")

//  //vTotalPages:=vTotalPages+Records in set("UMeterPhotoSet")

//vTotalPages:=vTotalPages+Records in set("LSS_SketchSet")

//vTotalPages:=vTotalPages+Records in set("LSS_ChartSet")

//vTotalPages:=vTotalPages+Round((Records in set("LSS_InspectionPhotoSet")/2);0)
//C_BOOLEAN($SkipPhotoLog_B)
//$SkipPhotoLog_B:=False
//If (vTotalPages=2)
//$SkipPhotoLog_B:=True
//End if 

//SET QUERY DESTINATION(Into variable;$DMeterCount_L)
//QUERY([LSS_DMeter];[LSS_DMeter]LSS_InspectionId_s=[LSS_Inspection]LSS_InspectionId_s)
//SET QUERY DESTINATION(Into current selection)  //missing

//If ($DMeterCount_L>0)  //Add demeter count assume all fits on one page for now
//vTotalPages:=vTotalPages+1
//End if 
//  //SET QUERY DESTINATION(Into variable ;$UTCount_L)
//  //Assume 1 page for each [LSS_UT] record and that all results for that UT fit on one page
//READ ONLY([LSS_UT])
//QUERY([LSS_UT];[LSS_UT]LSS_InspectionId_s=[LSS_Inspection]LSS_InspectionId_s)
//$UTCount_L:=0
//If (Records in selection([LSS_UT])>0)
//C_LONGINT($UTRodCount_L;$numExtraPgs_L;$numExtraRods_L)
//FIRST RECORD([LSS_UT])
//While (Not(End selection([LSS_UT])))
//SET QUERY DESTINATION(Into variable;$UTRodCount_L)
//QUERY([LSS_UtResult];[LSS_UtResult]LSS_UTId_s=[LSS_UT]LSS_UTId_s)
//SET QUERY DESTINATION(Into current selection)
//If ($UTRodCount_L>11)
//$numExtraRods_L:=$UTRodCount_L-11
//$numExtraPgs_L:=($numExtraRods_L\18)
//If (($numExtraPgs_L*18)<$numExtraRods_L)
//$numExtraPgs_L:=$numExtraPgs_L+1
//End if 
//$UTCount_L:=$UTCount_L+1+$numExtraPgs_L
//Else 
//$UTCount_L:=$UTCount_L+1
//End if 

//NEXT RECORD([LSS_UT])
//End while 

//End if 

//vTotalPages:=vTotalPages+$UTCount_L

//vbTopOfPage:=True  //say we start from top of page

//C_LONGINT($NumPages;$NumNewPages;$vLLine2;$vlLineSt;$Loop_L;$Position_L;$vlStartSel;$vlEndSel;$vrOrigPos;$viAlignmen;$vlStartInsert;$vlEndInsert;$i;$PhotoPages_L;$CommentPages_L)
//C_REAL($viNumtabs)
//C_LONGINT($Uniform;$viAlignment;$viFindRes)  // **replaced _ o _C_INTEGER()
//C_REAL($Indent_r;$vrParIndent)
//C_TEXT($vtWordst)

//C_TEXT($vsFillChar)  // **Replaced old C_STRING length 80
//ARRAY LONGINT($DeletePositions_aL;0)
//  //Do we only have headers if so delete all
//C_BOOLEAN($OnlyHeaders_B)
//$OnlyHeaders_B:=True
//$Loop_L:=1
//Repeat 
//If (Not(LSS_ElementHeader_ab{$Loop_L}))
//$OnlyHeaders_B:=False
//End if 
//$Loop_L:=$Loop_L+1

//Until (Not($OnlyHeaders_B)) | ($Loop_L>Size of array(LSS_ElementHeader_ab))


//If ($OnlyHeaders_B)
//$Loop_L:=Size of array(LSS_ElementLabel_atxt)
//DELETE FROM ARRAY(LSS_ElementLabel_atxt;1;$Loop_L)
//DELETE FROM ARRAY(LSS_ElementRemarks_atxt;1;$Loop_L)
//DELETE FROM ARRAY(LSS_ElementHeader_ab;1;$Loop_L)
//End if 

//For ($Loop_L;Size of array(LSS_ElementHeader_ab);1;-1)
//If (LSS_ElementHeader_ab{$Loop_L})
//$Position_L:=Find in array(LSS_ElementHeaderNo_atxt;LSS_ElementLabel_atxt{$Loop_L};$Loop_L+1)
//If ($Position_L<1)
//APPEND TO ARRAY($DeletePositions_aL;$Loop_L)
//End if 
//End if 
//End for 

//  //For ($Loop_L;1;Size of array($DeletePositions_aL);1;-1)
//For ($Loop_L;1;Size of array($DeletePositions_aL))
//DELETE FROM ARRAY(LSS_ElementLabel_atxt;$DeletePositions_aL{$Loop_L};1)
//DELETE FROM ARRAY(LSS_ElementRemarks_atxt;$DeletePositions_aL{$Loop_L};1)
//DELETE FROM ARRAY(LSS_ElementHeader_ab;$DeletePositions_aL{$Loop_L};1)
//End for 
//$CommentArea_L:=-9
//  //CLEAR VARIABLE(LSS_ElementHeaderNo_atxt)
//If (([LSS_Inspection]LSS_GeneralComments_txt="") & ([LSS_Inspection]LSS_AdditionalComments_txt="") & (Size of array(LSS_ElementRemarks_atxt)=0))
//Else 
//C_LONGINT($CommentArea_L)
//vInspFontName:="Arial"
//vInspFontSize:=11
//$CommentArea_L:=WR New offscreen area 
//  //WR UPDATE MODE ($mainarea;0)  `turn off updating
//Set Doc Margins ($CommentArea_L)
//WR SET DOC PROPERTY ($CommentArea_L;wr widow orphan;wr ignored)

//  //get the right size of the Lss_CommentsPrint_pct picture object on the form
//C_LONGINT($pw;$Ph)
//C_PICTURE(Lss_CommentsPrint_pct)
//C_LONGINT($printht;$picW;$picH)
//  //default paper width height values
//$pw:=530
//$Ph:=650

//C_OBJECT($picDims_o)
//OB SET($picDims_o;"TablePointer";->[LSS_Inspection];"FormName";"LSS_Comments";"VarPointer";->Lss_CommentsPrint_pct)
//Form_GetObjDims ($picDims_o)

//If (OB Get($picDims_o;"Width";Is longint)>0)
//$pw:=OB Get($picDims_o;"Width";Is longint)
//$Ph:=OB Get($picDims_o;"Height";Is longint)
//End if 

//If (Folder separator=":")

//Else 
//  //adjust for windows
//$pw:=(($pw*96)/72)
//$Ph:=(($Ph*96)/72)
//End if 

//  //set the paper ht and width to match the object on form for building the preview picture
//WR SET DOC PROPERTY ($CommentArea_L;wr unit;wr pixels)
//WR SET DOC PROPERTY ($CommentArea_L;wr paper width;$pw)
//WR SET DOC PROPERTY ($CommentArea_L;wr paper height;$Ph)

//vbTopOfPage:=True
//If ([LSS_Inspection]LSS_GeneralComments_txt#"")
//LSS_AddGeneralComments ($CommentArea_L)
//vbTopOfPage:=False
//End if 

//For ($Loop_L;1;Size of array(LSS_ElementHeader_ab))
//If (LSS_ElementHeader_ab{$loop_L})

//$Header_txt:=LSS_GetHeader (LSS_ElementLabel_atxt{$loop_L})
//LSS_NonDamageAddHeader ($CommentArea_L;$Header_txt;LSS_ElementHeader_ab{$Loop_L};$Loop_L)
//vbTopOfPage:=False
//Else 
//LSS_NonDamageAddHeader ($CommentArea_L;LSS_ElementLabel_atxt{$Loop_L};LSS_ElementHeader_ab{$Loop_L};$Loop_L)
//$Header_txt:=""
//End if 
//End for 
//If ([LSS_Inspection]LSS_AdditionalComments_txt#"")
//LSS_AddAddtlCmnts ($CommentArea_L)
//End if 

//vTotalPages:=vTotalPages+WR Count ($CommentArea_L;wr nb pages)
//End if 

//C_LONGINT($PhotoLogArea_L)
//$PhotoLogArea_L:=-9
//If (Not($SkipPhotoLog_B))

//ARRAY TEXT($PhotoDescription_atxt;0)
//ARRAY TEXT($PhotoType_atxt;0)
//ARRAY LONGINT($PhotoSeq_aL;0)
//C_TEXT($ID_txt;$PhotoType_txt)

//LSS_ReturnPhotoComments (->$PhotoSeq_aL;->$PhotoDescription_atxt;->$PhotoType_atxt;[LSS_Inspection]LSS_InspectionId_s)
//ARRAY LONGINT($SortPosition_aL;0)
//ARRAY LONGINT($SortPosition_aL;Size of array($PhotoDescription_atxt))
//ARRAY TEXT($PhototTitle_atxt;0)
//ARRAY TEXT($PhototTitle_atxt;Size of array($PhotoDescription_atxt))

//For ($Loop_L;Size of array($PhotoType_atxt);1;-1)
//Case of 
//: ($PhotoType_atxt{$Loop_L}="Sketch")
//$SortPosition_aL{$Loop_L}:=1

//: ($PhotoType_atxt{$Loop_L}="Chart")
//$SortPosition_aL{$Loop_L}:=2

//: ($PhotoType_atxt{$Loop_L}="Sketch D Meter")
//DELETE FROM ARRAY($PhotoSeq_aL;$Loop_L;1)
//DELETE FROM ARRAY($PhotoDescription_atxt;$Loop_L;1)
//DELETE FROM ARRAY($PhotoType_atxt;$Loop_L;1)
//DELETE FROM ARRAY($SortPosition_aL;$Loop_L;1)

//: ($PhotoType_atxt{$Loop_L}="Sketch UT")
//DELETE FROM ARRAY($PhotoSeq_aL;$Loop_L;1)
//DELETE FROM ARRAY($PhotoDescription_atxt;$Loop_L;1)
//DELETE FROM ARRAY($PhotoType_atxt;$Loop_L;1)
//DELETE FROM ARRAY($SortPosition_aL;$Loop_L;1)
//Else 
//$SortPosition_aL{$Loop_L}:=3

//End case 

//End for 
//MULTI SORT ARRAY($SortPosition_aL;>;$PhotoSeq_aL;>;$PhotoDescription_atxt;$PhotoType_atxt)
//C_TEXT($PhotoList_txt;$PhotoTitle_txt)
//$PhotoList_txt:=""
//For ($Loop_L;1;Size of array($PhotoDescription_atxt))

//If ($Loop_L<Size of array($PhotoDescription_atxt))
//$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+" "+String($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}+<>sCR
//Else 
//$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+" "+String($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}
//End if 
//End for 

//$PhotoLogArea_L:=WR New offscreen area 

//$Indent_r:=1  //inches
//Set Doc Margins ($PhotoLogArea_L)
//WR SET DOC PROPERTY ($PhotoLogArea_L;wr widow orphan;wr ignored)
//G_ApplySheet ($PhotoLogArea_L;1)


//  //get the right size of the Lss_CommentsPrint_pct picture object on the form
//  //get the right size of the Lss_CommentsPrint_pct picture object on the form
//C_LONGINT($pw;$Ph)
//C_PICTURE(Lss_CommentsPrint_pct)
//C_LONGINT($printht;$picW;$picH)
//  //default paper width height values
//$pw:=530
//$Ph:=650

//C_OBJECT($picDims_o)
//OB SET($picDims_o;"TablePointer";->[LSS_Inspection];"FormName";"LSS_PhotoLog";"VarPointer";->Lss_CommentsPrint_pct)
//Form_GetObjDims ($picDims_o)
//If (OB Get($picDims_o;"Width";Is longint)>0)
//$pw:=OB Get($picDims_o;"Width";Is longint)
//$Ph:=OB Get($picDims_o;"Height";Is longint)
//End if 

//If (Folder separator=":")

//Else 
//  //adjust for windows
//$pw:=(($pw*96)/72)
//$Ph:=(($Ph*96)/72)
//End if 

//  //set the paper ht and width to match the object on form for building the preview picture
//WR SET DOC PROPERTY ($PhotoLogArea_L;wr unit;wr pixels)
//WR SET DOC PROPERTY ($PhotoLogArea_L;wr paper width;$pw)
//WR SET DOC PROPERTY ($PhotoLogArea_L;wr paper height;$Ph)

//WR SET DOC PROPERTY ($PhotoLogArea_L;wr unit;wr inches)
//  //WR GET SELECTION ($PhotoLogArea_L;$vlStartSel;$vlEndSel)
//  //WR EXECUTE COMMAND ($PhotoLogArea_L;wr cmd select all)
//  //WR EXECUTE COMMAND ($PhotoLogArea_L;wr cmd plain)
//WR SET TEXT PROPERTY ($PhotoLogArea_L;wr left margin;$Indent_r)
//WR SET TEXT PROPERTY ($PhotoLogArea_L;wr first indent;(-$Indent_r))

//$viNumtabs:=WR Get text property ($PhotoLogArea_L;wr tab;$Uniform)
//If ($viNumtabs>0)

//WR GET TAB ($PhotoLogArea_L;1;$vrOrigPos;$viAlignment;$vsFillChar)
//WR SET TAB ($PhotoLogArea_L;1;$Indent_r;$viAlignment;$vsFillChar)
//Else 
//WR ADD TAB ($PhotoLogArea_L;1;$Indent_r;"")
//End if 

//WR INSERT TEXT ($PhotoLogArea_L;$PhotoList_txt)
//WR GET SELECTION ($PhotoLogArea_L;$vlStartInsert;$vlEndInsert)
//  //now adjust the paragraphs for all except the 1st one. This is in case there are carriage returns in the descriptions.
//WR SET SELECTION ($PhotoLogArea_L;$vlLine2;$vlLine2)  //move to the start of the insert
//$viFindRes:=WR Find ($PhotoLogArea_L;<>sCR;0;0;0)  //Find the next line feed
//While ($viFindRes=1)
//WR GET SELECTION ($PhotoLogArea_L;$vlLineSt;$vlLine2)
//WR SET SELECTION ($PhotoLogArea_L;$vlLine2;$vlLine2)
//$vtWordst:=WR Get text ($PhotoLogArea_L;$vlLine2;($vlLine2+4))
//If (($vtWordst#"PHOT") & ($vtWordst#"SKET") & ($vtWordst#"CHAR"))
//WR SET TEXT PROPERTY ($PhotoLogArea_L;wr first indent;0)
//End if 
//WR GET SELECTION ($PhotoLogArea_L;$vlLineSt;$vlLine2)
//$viFindRes:=WR Find ($PhotoLogArea_L;<>sCR;0;0;0)  //Find the next line feed
//End while 

//G_Insp_ApplyLineSpacing ($PhotoLogArea_L)

//$PhotoPages_L:=WR Count ($PhotoLogArea_L;wr nb pages)
//  //If ($numnewpages>1)
//  //G_InspParagProt ($PhotoLogArea_L;1;0;$vlStartSel;0;" ")
//  //End if 
//  //$PhotoPages_L:=WR Count ($PhotoLogArea_L;wr nb pages )
//vTotalPages:=vTotalPages+$PhotoPages_L
//End if 

//Case of 
//: ([LSS_Inventory]LSS_Category_s="Sign")
//Print form([LSS_Inspection];"SignStructurePg1")
//PAGE BREAK(>)
//Print form([LSS_Inspection];"SignStructurePg2")
//  //PAGE BREAK(>)

//: ([LSS_Inventory]LSS_Category_s="Signal")
//Print form([LSS_Inspection];"TrafficSignalStructurePg1")
//PAGE BREAK(>)
//Print form([LSS_Inspection];"TrafficSignalStructurePg2")
//  //PAGE BREAK(>)

//: ([LSS_Inventory]LSS_Category_s="Light")
//Print form([LSS_Inspection];"LightStructurePg1")
//PAGE BREAK(>)
//Print form([LSS_Inspection];"LightStructurePg2")
//  //PAGE BREAK(>)

//: ([LSS_Inventory]LSS_Category_s="ITS")
//Print form([LSS_Inspection];"ITSStructurePg1")
//PAGE BREAK(>)
//Print form([LSS_Inspection];"ITSStructurePg2")
//  //PAGE BREAK(>)

//End case 

//  //Print comments pages
//If ($CommentArea_L<0)
//Else 
//$CommentPages_L:=WR Count ($CommentArea_L;wr nb pages)

//For ($Loop_L;1;$CommentPages_L)
//If (viInspPreviewErr=0)
//  //do this only  if no preview error
//Lss_CommentsPrint_pct:=WR Build preview ($CommentArea_L;$Loop_L)
//PICTURE PROPERTIES(Lss_CommentsPrint_pct;$picw;$pich)
//C_LONGINT($windscale;$ResFactor)
//$windscale:=($picw*100)/$pw
//If ($windscale>101)
//  //scale up by a factor first
//$ResFactor:=3  //use a factor of 3 to scale the picture - for better resolution
//TRANSFORM PICTURE(Lss_CommentsPrint_pct;Scale;$ResFactor;$ResFactor)
//  //the crop to match the expected width and height - croping rasterizes the image
//  //when on form , picture will be scaled to fit the form page
//TRANSFORM PICTURE(Lss_CommentsPrint_pct;Crop;0;0;($ResFactor*$pw);($ResFactor*$Ph))
//End if 
//$printht:=Print form([LSS_Inspection];"LSS_Comments")
//If ($Loop_L<$CommentPages_L)
//PAGE BREAK(>)

//End if 
//End if 

//End for 
//Lss_CommentsPrint_pct:=Lss_CommentsPrint_pct*0

//WR DELETE OFFSCREEN AREA ($CommentArea_L)
//End if 

//  //Add print [LSS_DMeter]
//If ($DMeterCount_L>0)
//  //Add print [LSS_DMeter]
//LSS_PrintDMeter (($UTCount_L=0) & ($PhotoLogArea_L<0))
//End if 

//  //Add print [LSS_UT]
//If ($UTCount_L>0)
//  //Add print [LSS_UT]
//LSS_PrintUT ($PhotoLogArea_L>0)
//End if 

//If ($PhotoLogArea_L>0)

//For ($Loop_L;1;$PhotoPages_L)
//If (viInspPreviewErr=0)

//  //do this only  if no preview error
//Lss_CommentsPrint_pct:=WR Build preview ($PhotoLogArea_L;$Loop_L)

//PICTURE PROPERTIES(Lss_CommentsPrint_pct;$picw;$pich)
//C_LONGINT($windscale;$ResFactor)
//$windscale:=($picw*100)/$pw
//If ($windscale>101)
//  //scale up by a factor first
//$ResFactor:=3  //use a factor of 3 to scale the picture - for better resolution
//TRANSFORM PICTURE(Lss_CommentsPrint_pct;Scale;$ResFactor;$ResFactor)
//  //the crop to match the expected width and height - croping rasterizes the image
//  //when on form , picture will be scaled to fit the form page
//TRANSFORM PICTURE(Lss_CommentsPrint_pct;Crop;0;0;($ResFactor*$pw);($ResFactor*$Ph))
//End if 

//$printht:=Print form([LSS_Inspection];"LSS_PhotoLog")
//PAGE BREAK(>)

//End if 

//End for 

//WR DELETE OFFSCREEN AREA ($PhotoLogArea_L)

//End if 

//Lss_CommentsPrint_pct:=Lss_CommentsPrint_pct*0
//C_LONGINT($PhotoCount_L;$ChartCount_L;$SketchCount_L)
//C_BOOLEAN($HaveMorePages_B)

//$PhotoCount_L:=Records in set("LSS_InspectionPhotoSet")
//$ChartCount_L:=Records in set("LSS_ChartSet")
//$SketchCount_L:=Records in set("LSS_SketchSet")
//$HaveMorePages_B:=($PhotoCount_L>0) | ($ChartCount_L>0) | ($SketchCount_L>0)
//If ($HaveMorePages_B)
//LSS_PrintPhoto (True)
//Else 
//PAGE BREAK
//End if 

//CLEAR SET("LSS_InspectionPhotoSet")
//CLEAR SET("DMeterPhotoSet")
//CLEAR SET("UMeterPhotoSet")
//CLEAR SET("LSS_SketchSet")
//CLEAR SET("LSS_ChartSet")

//UNLOAD RECORD([LSS_Inspection])

//REDRAW WINDOW
//End if 