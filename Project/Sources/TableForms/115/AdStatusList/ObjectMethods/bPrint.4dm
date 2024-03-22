If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 15:04:14)
	Mods_2007_CM12_5301
End if 
C_LONGINT:C283($Scale; $PapW; $W; $cols; $i; $LMar; $RMar)
C_TEXT:C284($dummy_txt)
//$PapW:=PV Get print property (AdStatusVArea;pv print paper width;$dummy_txt)
//$LMar:=PV Get print property (AdStatusVArea;pv print left margin;$dummy_txt)
//$RMar:=PV Get print property (AdStatusVArea;pv print right margin;$dummy_txt)
//$PapW:=$PapW-($LMar+$RMar)
//$cols:=PV Get document property (AdStatusVArea;pv column count)
//$W:=1  //width of the Row headers...
//For ($i;1;$cols)
//$W:=$W+PV Get column width (AdStatusVArea;$i)
//End for 
//$Scale:=((100*$PapW)\$W)-1  //reduce scale by one for safety

//PV EXECUTE COMMAND (AdStatusVArea;pv cmd file page setup)
//If (OK=1)
//PV EXECUTE COMMAND (AdStatusVArea;pv cmd file print document)
//End if 
