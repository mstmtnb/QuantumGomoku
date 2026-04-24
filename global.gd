extends Node

#ターンを管理
var turn
enum  turn_enum{
	None,
	Black,
	White
}

#黒=0、白=100で石を表す。空白は-1
var grid: Array = []
var selectedGrid = Vector2(-1,-1)

#所持ポイントを管理
var blackPoint = 70
var whitePoint = 70

#使用ポイントを管理
var blackUsePoint = 70
var whiteUsePoint = 70
