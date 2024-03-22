//%attributes = {"invisible":true}
//Method: INSP_ElemCommentsList_WP
//Description
// update a variable on a spec member form with the element comments
// Parameters
// $1 : $ParamObj_o
//   ` .elemblob  .charlimit (if <0 get all text).varpointer
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/10/21, 09:55:37
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	C_OBJECT:C1216(INSP_ElemCommentsList_WP; $1)
	
End if 
//
C_OBJECT:C1216($1)

C_BLOB:C604($elemComments)
C_LONGINT:C283($charlimit_L)
C_POINTER:C301($varpointer; $elemBlobPtr)
C_TEXT:C284($NotFittext)
$elemBlobPtr:=$1.elemblob
$charlimit_L:=$1.charlimit
$varpointer:=$1.varpointer
$NotFittext:=$1.notfit
$elemComments:=$elemBlobPtr->

C_TEXT:C284($wptag; $ElemText)
C_LONGINT:C283($offset; $compressed; $charcount)
C_BLOB:C604($WpData)
If (BLOB size:C605($elemComments)>0)
	BLOB PROPERTIES:C536($elemComments; $compressed)
	$offset:=0
	If ($compressed>0)
		EXPAND BLOB:C535($elemComments)
	End if 
	BLOB TO VARIABLE:C533($elemComments; $wptag; $offset)
	
	If ($WPtag="WPAREA")
		BLOB TO VARIABLE:C533($elemComments; $WpData; $offset)
		C_OBJECT:C1216($wpArea; $range)
		$wpArea:=WP New:C1317($WpData)
		$range:=WP Text range:C1341($wpArea; wk start text:K81:165; wk end text:K81:164)
		$charcount:=$range.end-$range.start
		
		If (($charcount<$charlimit_L) | ($charlimit_L<0))
			$varpointer->:=WP Get text:C1575($range; wk expressions as value:K81:255)
		Else 
			$varpointer->:="See remarks in comments section."
		End if 
		
	End if 
	
End if 

//End INSP_ElemCommentsList_WP