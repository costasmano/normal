//%attributes = {"invisible":true}
//Method: LSS_CountandPrintDamagePages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 08/08/18, 14:22:35
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
	// Modified by: Costas Manousakis-(Designer)-(1/30/19 14:56:58)
	Mods_2019_01_bug
	//  `fix handling of letter labels for the printed elements
	Mods_2019_02_bug  //Fix bug where elements not printing correctly CallReference #607
	//Changed way we calculate the number of element pages
	//Reset $k to 0 before loop
	//changed to test (Size of array($v_163_002_aL)=0) 
	//Modified by: Chuck Miller (2/13/19 12:20:06)
	// Modified by: Costas Manousakis-(Designer)-(2/19/20 17:28:13)
	Mods_2020_02_bug
	//  `adjustments made to compensate for windows display scaling when generating a WR preview picture CallReference #695
	// Modified by: Costas Manousakis-(Designer)-(2/22/21 18:22:43)
	Mods_2021_02
	//  `don't check for preview error - no need any more 
	//  `added ignore on widow orphan for the two WR areas.
	Mods_2021_Delete
End if 
//
//C_POINTER($Variable_ptr)

//C_LONGINT($1;$Page1ElementCount_L;$Loop_L)
//$Page1ElementCount_L:=$1

//C_TEXT($Page1Form_txt;$Page2Form_txt)

//Case of 
//: ([LSS_Inventory]LSS_Category_s="Sign") | ([LSS_Inventory]LSS_InventoryType_s="HS")
//TemplateMIN_Sin_txt:="HIN"
//$Page1Form_txt:="StructureDamage_HS_P1"
//$Page2Form_txt:="SignStructurePg2"
//: ([LSS_Inventory]LSS_Category_s="Light") | ([LSS_Inventory]LSS_InventoryType_s="LI")
//TemplateMIN_Sin_txt:="LIN"
//$Page2Form_txt:="LightStructurePg2"
//$Page1Form_txt:="StructureDamage_Light_P1"
//: ([LSS_Inventory]LSS_Category_s="Signal") | ([LSS_Inventory]LSS_InventoryType_s="SI")
//TemplateMIN_Sin_txt:="SIN"
//$Page1Form_txt:="StructureDamage_TS_P1"
//$Page2Form_txt:="TrafficSignalStructurePg2"
//: ([LSS_Inventory]LSS_Category_s="ITS") | ([LSS_Inventory]LSS_InventoryType_s="IT")
//TemplateMIN_Sin_txt:="IIN"
//$Page1Form_txt:="StructureDamage_ITS_P1"
//$Page2Form_txt:="ITSStructurePg2"
//End case 
//C_REAL($NTEPages_r)
//C_LONGINT($ElementPages_L)

//If (Size of array(v_163_002_aL)<=$Page1ElementCount_L)
//$ElementPages_L:=0
//Else 
//C_LONGINT($pos_L;$Start_L;$RecordCountToUse_L)
//  //$Start_L:=0
//  //$RecordCountToUse_L:=0
//  //Repeat 
//  //$pos_L:=Find in array(LSS_ElementHeader_ab;True;$Start_L)
//  //If ($pos_L>0)
//  //$Start_L:=$pos_L+1
//  //$RecordCountToUse_L:=$RecordCountToUse_L+1
//  //End if 
//  //Until ($pos_L<0)
//  //$RecordCountToUse_L:=$RecordCountToUse_L-$Page1ElementCount_L
//$RecordCountToUse_L:=Size of array(v_163_002_aL)-$Page1ElementCount_L
//$NTEPages_r:=($RecordCountToUse_L/22)
//If ($RecordCountToUse_L%22=0)
//$ElementPages_L:=Trunc($NTEPages_r;0)
//Else 
//$ElementPages_L:=Trunc($NTEPages_r;0)+1
//End if 
//End if 
//vTotalPages:=$ElementPages_L+2  //Add in first page
//C_LONGINT($SketchCount_L;$ChartCount_L;$PhotoCount_L)
//  //Get number of image pages

//SET QUERY DESTINATION(Into set;"LSS_SketchSet")
//QUERY([LSS_Photos];[LSS_Photos]LSS_InspectionId_s=[LSS_Inspection]LSS_InspectionId_s;*)
//QUERY([LSS_Photos]; & ;[LSS_Photos]LSS_PhotoType_s="Sketch")
//$SketchCount_L:=Records in set("LSS_SketchSet")

//SET QUERY DESTINATION(Into set;"LSS_ChartSet")
//QUERY([LSS_Photos];[LSS_Photos]LSS_InspectionId_s=[LSS_Inspection]LSS_InspectionId_s;*)
//QUERY([LSS_Photos]; & ;[LSS_Photos]LSS_PhotoType_s="Chart")
//$ChartCount_L:=Records in set("LSS_ChartSet")


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
//DIFFERENCE("LSS_InspectionPhotoSet";"LSS_ChartSet";"LSS_InspectionPhotoSet")
//DIFFERENCE("LSS_InspectionPhotoSet";"LSS_SketchSet";"LSS_InspectionPhotoSet")

//$PhotoCount_L:=Records in set("LSS_InspectionPhotoSet")

//C_BOOLEAN($SkipPhotoLog_B)
//$SkipPhotoLog_B:=(Records in set("LSS_InspectionPhotoSet")=0)

//SET QUERY DESTINATION(Into current selection)
//vTotalPages:=vTotalPages+Round(($PhotoCount_L/2);0)

//vTotalPages:=vTotalPages+$SketchCount_L

//vTotalPages:=vTotalPages+$ChartCount_L

//C_LONGINT($DMeterCount_L;$UTCount_L;$UTRodCount_L;$numExtraRods_L;$numExtraPgs_L)

//SET QUERY DESTINATION(Into variable;$DMeterCount_L)
//QUERY([LSS_DMeter];[LSS_DMeter]LSS_InspectionId_s=[LSS_Inspection]LSS_InspectionId_s)
//SET QUERY DESTINATION(Into current selection)  //missing

//If ($DMeterCount_L>0)  //Add dmeter count assume all fits on one page for now
//vTotalPages:=vTotalPages+1
//End if 

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
//LSS_CountingPage_B:=True
//vTotalPages:=vTotalPages+$UTCount_L
//$CommentArea_L:=-9
//  //CLEAR VARIABLE(LSS_ElementHeaderNo_atxt)
//Print form([LSS_Inspection];$Page1Form_txt)

//C_TEXT($DHeader_txt;$RHeader_txt;$Header_txt)
//$DHeader_txt:=""
//$RHeader_txt:=""
//$DHeader_txt:=ST Get plain text(v_164_056_txt)
//$DSeeCommentsPos_L:=Position("See REMARKS";$DHeader_txt)
//$RHeader_txt:=ST Get plain text(v_164_059_txt)
//$RSeeCommentsPos_L:=Position("See REMARKS";$RHeader_txt)

//C_LONGINT($DSeeCommentsPos_L;$RSeeCommentsPos_L)
//If (([LSS_Inspection]LSS_GeneralComments_txt="")\
 & ([LSS_Inspection]LSS_AdditionalComments_txt="")\
 & (Size of array(LSS_ElementRemarks_atxt)=0)\
 & ($DSeeCommentsPos_L=0)\
 & ($RSeeCommentsPos_L=0))
//Else 
//C_LONGINT($CommentArea_L)
//vInspFontName:="Arial"
//vInspFontSize:=11
//$CommentArea_L:=WR New offscreen area 
//  //WR UPDATE MODE ($mainarea;0)  `turn off updating
//Set Doc Margins ($CommentArea_L)
//WR SET DOC PROPERTY ($CommentArea_L;wr widow orphan;wr ignored)
//  //default paper width height values
//C_LONGINT($pw;$Ph)
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
//C_LONGINT($Start_L;$HeaderPos_L)
//$Start_L:=0

//If (Position("See REMARKS";$DHeader_txt)>0)  //cause of damage
//LSS_AddNotes ($CommentArea_L;"CAUSE OF DAMAGE : ";[LSS_Inspection]LSS_DamageCause_txt)
//End if 

//If (Position("See REMARKS";$RHeader_txt)>0)  //recommendions
//LSS_AddNotes ($CommentArea_L;"RECOMMENDATIONS : ";[LSS_Inspection]LSS_Recommendations_txt)
//End if 
//$Header_txt:=""
//Repeat 
//$Loop_L:=Find in array(LSS_AddtoCommentsPAGE_AB;True;$Start_L)
//If ($Loop_L>0)
//If ($Header_txt#v_163_007_atxt{LSS_HeaderPosition_aL{$loop_L}})
//$Header_txt:=v_163_007_atxt{LSS_HeaderPosition_aL{$loop_L}}
//LSS_AddHeader ($CommentArea_L;$Header_txt;LSS_ElementHeader_ab{$Loop_L};$Loop_L;->v_163_008_atxt)
//Else 
//LSS_AddHeader ($CommentArea_L;v_163_007_atxt{$loop_L};LSS_ElementHeader_ab{$loop_L};$Loop_L;->v_163_008_atxt)
//End if 
//$Start_L:=$Loop_L+1
//End if 

//Until ($Loop_l<0)
//If ([LSS_Inspection]LSS_AdditionalComments_txt#"")

//LSS_AddAddtlCmnts ($CommentArea_L)
//End if 

//vTotalPages:=vTotalPages+WR Count ($CommentArea_L;wr nb pages)
//End if 
//  //Add print [LSS_DMeter]
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
//$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+": "+String($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}+<>sCR
//Else 
//$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+": "+String($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}
//End if 
//End for 
//C_LONGINT($Uniform;$viAlignment;$viFindRes)  // **Replaced old C_INTEGER()
//C_LONGINT($Uniform;$viAlignment;$viFindRes)  // **Replaced old C_INTEGER()
//$PhotoLogArea_L:=WR New offscreen area 
//C_REAL($Indent_r;$vrOrigPos;$vrParIndent)
//C_LONGINT($vlLineSt;$vlStartSel;$vlEndSel;$viNumtabs;$vlStartInsert;$vlEndInsert;$vlLine2)
//C_TEXT($vsFillChar)  // **Replaced old C_STRING length 80
//C_TEXT($vtWordst)

//$Indent_r:=1
//Set Doc Margins ($PhotoLogArea_L)
//WR SET DOC PROPERTY ($CommentArea_L;wr widow orphan;wr ignored)
//G_ApplySheet ($PhotoLogArea_L;1)

//  //default paper width height values
//C_LONGINT($pw;$Ph)
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

//WR SET DOC PROPERTY ($PhotoLogArea_L;wr unit;wr inches)  // set units to inches

//WR GET SELECTION ($PhotoLogArea_L;$vlStartSel;$vlEndSel)
//WR EXECUTE COMMAND ($PhotoLogArea_L;wr cmd plain)
//WR SET TEXT PROPERTY ($PhotoLogArea_L;wr left margin;$Indent_r)
//WR SET TEXT PROPERTY ($PhotoLogArea_L;wr first indent;(-$Indent_r))

//$viNumtabs:=WR Get text property ($PhotoLogArea_L;wr tab;$Uniform)
//If ($viNumtabs>0)

//WR GET TAB ($PhotoLogArea_L;1;$vrOrigPos;$viAlignment;$vsFillChar)
//WR SET TAB ($PhotoLogArea_L;1;$vrParIndent;$viAlignment;$vsFillChar)
//Else 
//WR ADD TAB ($PhotoLogArea_L;1;$vrParIndent;"")
//End if 
//WR INSERT TEXT ($PhotoLogArea_L;$PhotoList_txt)
//WR GET SELECTION ($PhotoLogArea_L;$vlStartInsert;$vlEndInsert)
//  //now adjust the paragraphs for all except the 1st one.
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
//  //Now reset the selection
//WR SET SELECTION ($PhotoLogArea_L;$vlStartInsert;$vlEndInsert)

//G_Insp_ApplyLineSpacing ($PhotoLogArea_L)
//C_LONGINT($PhotoPages_L)
//$PhotoPages_L:=WR Count ($PhotoLogArea_L;wr nb pages)
//  //If ($numnewpages>1)
//  //G_InspParagProt ($PhotoLogArea_L;1;0;$vlStartSel;0;" ")
//  //End if 
//  //$PhotoPages_L:=WR Count ($PhotoLogArea_L;wr nb pages )
//vTotalPages:=vTotalPages+$PhotoPages_L

//End if 
//LSS_CountingPage_B:=False
//Print form([LSS_Inspection];$Page1Form_txt)
//Print form([LSS_Inspection];$Page2Form_txt)

//ARRAY LONGINT($v_163_002_aL;0)
//For ($loop_l;$Page1ElementCount_L+1;Size of array(v_163_002_aL))

//APPEND TO ARRAY($v_163_002_aL;v_163_002_aL{$Loop_L})
//End for 

//If (Size of array($v_163_002_aL)>0)  //Print special Member page or pages
//C_LONGINT(vSpecMemStartLetter)
//vSpecMemStartLetter:=$Page1ElementCount_L
//C_LONGINT($NumberOfRecords_L;$GroupCount_L)
//$NumberOfRecords_L:=Size of array(LSS_AddtoCommentsPAGE_AB)-$Page1ElementCount_L
//Case of 
//: ($NumberOfRecords_L=0)
//$GroupCount_L:=0
//: ($NumberOfRecords_L<=22)
//$GroupCount_L:=1
//Else 
//$GroupCount_L:=-(Trunc(-(($NumberOfRecords_L-22)/22);0))
//$GroupCount_L:=$GroupCount_L+1
//End case 
//C_LONGINT($j;$k)
//$k:=0
//C_LONGINT($GroupLoop_L)

//If ($GroupCount_L>=1)

//C_LONGINT(vSpecMemStartLetter;$viStart)
//$viStart:=Character code("A")+vSpecMemStartLetter
//$i:=1

//For ($GroupLoop_L;1;$GroupCount_L)
//LSS_ClearSpecialMemberVariables (22)
//If ($GroupLoop_L>2)
//vSpecMemStartLetter:=vSpecMemStartLetter+22
//End if 
//$k:=0
//ARRAY LONGINT($ElementGroup_aL;0)
//For ($j;1;22)
//$k:=$k+1
//Case of 
//: (Size of array($v_163_002_aL)=0)
//$j:=23
//: ($k<=$NumberOfRecords_L)
//APPEND TO ARRAY($ElementGroup_aL;$v_163_002_aL{1})
//DELETE FROM ARRAY($v_163_002_aL;1;1)
//Else 
//$j:=23  //get out

//End case 
//End for 
//C_BOOLEAN($Complete_B)
//$Complete_B:=False
//ARRAY BOOLEAN($PrintOnextras_aB;0)
//CLEAR VARIABLE($PrintOnextras_aB)
//ARRAY BOOLEAN($PrintOnExtras_aB;Size of array(v_163_002_aL))
//C_LONGINT($Position_L)
//For ($j;1;Size of array($ElementGroup_aL))
//$Position_L:=Find in array(v_163_002_aL;$ElementGroup_aL{$j})
//If ($Position_L>0)

//$PrintOnExtras_aB{$Position_L}:=True
//End if 

//End for 

//vPageNo:=vPageNo+1
//C_LONGINT($REMARKS_NUMBER;$i;$recnum)
//$REMARKS_NUMBER:=22

//$k:=0
//$j:=1
//C_POINTER($pLetter)
//Repeat 
//$Position_L:=Find in array($PrintOnExtras_aB;True;$k)
//If ($Position_L>0)
//$k:=$Position_L+1
//$pLetter:=Get pointer("vLetter"+String($j))
//C_LONGINT($vlLetterCode;$vlLetterCycle)
//$vlLetterCode:=$viStart+$i-1
//$vlLetterCycle:=($vlLetterCode-Character code("A"))\26
//$vlLetterCode:=$vlLetterCode-(26*$vlLetterCycle)
//$pLetter->:=Char($vlLetterCode)
//If ($vlLetterCycle>0)
//$pLetter->:=Char($vlLetterCode)+String($vlLetterCycle)
//End if 

//LSS_FillElementMemberLines ($Position_L;$j)
//$i:=$i+1
//$j:=$j+1
//End if 

//Until ($Position_L<0)

//Print form([LSS_Inspection];"StructureDamageMoreMembers")
//PAGE BREAK(>)
//End for 
//End if 

//End if 
//C_LONGINT($CommentPages_L;$PhotoPages_L)
//  //Print comments pages
//If ($CommentArea_L<0)
//Else 
//$CommentPages_L:=WR Count ($CommentArea_L;wr nb pages)

//C_PICTURE(Lss_CommentsPrint_pct)
//C_LONGINT($printht;$picW;$picH)

//For ($Loop_L;1;$CommentPages_L)

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

//End for 
//Lss_CommentsPrint_pct:=Lss_CommentsPrint_pct*0

//WR DELETE OFFSCREEN AREA ($CommentArea_L)
//End if 
//If ($DMeterCount_L>0)
//  //Add print [LSS_DMeter]
//LSS_PrintDMeter (($UTCount_L=0) & ($PhotoLogArea_L<0))
//End if 
//If ($UTCount_L>0)
//  //Add print [LSS_UT]
//LSS_PrintUT ($PhotoLogArea_L>0)
//End if 
//If ($PhotoLogArea_L>0)

//  //get the right size of the Lss_CommentsPrint_pct picture object on the form
//  //get the right size of the Lss_CommentsPrint_pct picture object on the form
//C_PICTURE(Lss_CommentsPrint_pct)
//C_LONGINT($printht;$picW;$picH)

//For ($Loop_L;1;$PhotoPages_L)

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

//End for 

//WR DELETE OFFSCREEN AREA ($PhotoLogArea_L)
//End if 

//Lss_CommentsPrint_pct:=Lss_CommentsPrint_pct*0
//C_LONGINT($PhotoCount_L;$ChartCount_L;$SketchCount_L)
//C_BOOLEAN($HaveMorePages_B)

//$HaveMorePages_B:=($PhotoCount_L>0) | ($ChartCount_L>0) | ($SketchCount_L>0)
//If ($HaveMorePages_B)
//DIFFERENCE("LSS_InspectionPhotoSet";"LSS_ChartSet";"LSS_InspectionPhotoSet")
//DIFFERENCE("LSS_InspectionPhotoSet";"LSS_SketchSet";"LSS_InspectionPhotoSet")
//LSS_PrintPhoto (True)
//Else 
//PAGE BREAK
//End if 
//CLEAR SET("LSS_InspectionPhotoSet")
//CLEAR SET("LSS_ChartSet")
//CLEAR SET("LSS_SketchSet")

//UNLOAD RECORD([LSS_Inspection])

//REDRAW WINDOW

//  //End LSS_CountandPrintDamagePages