//bAddTeam

If ((aTeamMbr>0) & (Find in array:C230(aTempTmID; aTeamMbrID{aTeamMbr})<0))
	INSERT IN ARRAY:C227(aTempTeam; 1; 1)
	aTempTeam:=1
	aTempTeam{aTempTeam}:=aTeamMbr{aTeamMbr}
	INSERT IN ARRAY:C227(aTempTmID; 1; 1)
	aTempTmID:=1
	aTempTmID{aTempTmID}:=aTeamMbrID{aTeamMbr}
End if 