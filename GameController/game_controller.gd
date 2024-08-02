extends Node

var highscore = 0


func test_highscore(new_score:int)->bool:
	if new_score > highscore:
		highscore = new_score
		return true
	else:
		return false
