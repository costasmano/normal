//%attributes = {"invisible":true}
//If (False)
//  ` ----------------------------------------------------
//  ` User name (OS): costasmanousakis
//  ` User name (4D): Designer
//  ` Date and time: 03/06/07, 12:22:31
//  ` ----------------------------------------------------
//  ` Method: Method: Temp_MovePicstoInsp
//  ` Description
//  ` Copy images from one inspection to another
//  ` 
//  ` Parameters
//  ` ----------------------------------------------------
//Mods_2011_06   ` CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v1
//End if 
//C_LONGINT($SourceInspID_L;$TargetInspID_L;$i;$NoImgs;$j)
//
//$SourceInspID_L:=Num(Request("ID of source inspection"))
//$TargetInspID_L:=Num(Request("ID of target inspection"))
//SET AUTOMATIC RELATIONS(False;False)
//QUERY([Standard Photos];[Standard Photos]InspID=$SourceInspID_L)
//$NoImgs:=Records in selection([Standard Photos])
//QUERY([Inspections];[Inspections]InspID=$TargetInspID_L)
//
//Case of 
//: ($NoImgs=0)
//ALERT("No photos found for insp ID "+String($SourceInspID_L))
//: (Records in selection([Inspections])=0)
//ALERT("No Inspection found for target insp ID "+String($TargetInspID_L))
//Else 
//ORDER BY([Standard Photos];[Standard Photos]PictType;>;[Standard Photos]SeqNum;>;[Standard Photos]StdPhotoID;>)
//MESSAGE(◊sCR+"   Copying "+String($NoImgs)+" Images...")
//COPY NAMED SELECTION([Standard Photos];"OldImages")
//C_TEXT($FieldName)
//For ($i;1;$NoImgs)
//CONFIRM("Copy image type "+[Standard Photos]PictType+" seq:"+String([Standard Photos]SeqNum)+" Descr: <"+[Standard Photos]Description+">")
//If (OK=1)
//MESSAGE("..."+String($i))
//DUPLICATE RECORD([Standard Photos])
//[Standard Photos]StdPhotoID:=0
//Inc_Sequence ("StandardPhotos";->[Standard Photos]StdPhotoID)
//[Standard Photos]InspID:=[Inspections]InspID
//SAVE RECORD([Standard Photos])
//C_LONGINT($Num_Img_Fields)
//$Num_Img_Fields:=Count fields(->[Standard Photos])
//  ` log the change/duplication here
//LogNewRecord (->[Inspections]InspID;->[Standard Photos]InspID;->[Standard Photos]StdPhotoID;2;"StandardPhotos")
//InitChangeStack (1)
//For ($j;1;$Num_Img_Fields)
//$FieldName:=Field name($a_Ptr_ImgFields{$j})
//If (($FieldName#"InspID") & ($FieldName#"StdPhotoID"))  `Skip Ids
//PushChange (1;$a_Ptr_ImgFields{$j})
//End if 
//End for 
//FlushGrpChgs (1;->[Inspections]InspID;->[Standard Photos]InspID;->[Standard Photos]StdPhotoID;2)
//
//End if 
//
//USE NAMED SELECTION("OldImages")
//NEXT RECORD([Standard Photos])
//COPY NAMED SELECTION([Standard Photos];"OldImages")  `Dec-2001 : need to do this to keep track of current record
//End for 
//
//CLEAR NAMED SELECTION("OldImages")
//
//End case 
//
//SET AUTOMATIC RELATIONS(True;True)