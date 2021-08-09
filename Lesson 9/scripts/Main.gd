extends Node

export (PackedScene) var Bubble
export var max_bubble_cnt = 10

var screen_rect
var bubble_cnt = 0


func _ready():
	#Initialize random number generator and get screen rect
	randomize()
	screen_rect = get_viewport().get_rect()
	
	#Start the game
	start_game()


func _on_SpawnTimer_timeout():
	#Spawn a new bubble if there are less than 10 bubbles in
	#play
	if bubble_cnt >= max_bubble_cnt:
		return
		
	var bubble = Bubble.instance()
	var pos = Vector2(
	    rand_range(screen_rect.pos.x, screen_rect.end.x),
	    rand_range(screen_rect.pos.y, screen_rect.end.y)
	)
	bubble.set_pos(pos)
	add_child(bubble)
	bubble_cnt += 1
	
	#Connect "popped" signal
	bubble.connect("popped", self, "_on_Bubble_popped")
	
	
func _on_Bubble_popped():
	#Decrease the bubble count by 1
	bubble_cnt -= 1
	
	
func start_game():
	#Reset the bubble count and start the spawn timer
	bubble_cnt = 0
	get_node("SpawnTimer").start()
