//%attributes = {"invisible":true}
//G_SortInspImages 
//Sort inspection images
If (False:C215)
	ORDER BY FORMULA:C300([Standard Photos:36]; F_ImageSort([Standard Photos:36]PictType:5; [Standard Photos:36]SeqNum:6); >)
Else 
	ORDER BY:C49([Standard Photos:36]; [Standard Photos:36]PictType:5; >; [Standard Photos:36]SeqNum:6; >)
End if 
