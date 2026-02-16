extends objects


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collision:CollisionShape2D=CollisionShape2D.new()
	self.add_child(collision)
	collision.shape=RectangleShape2D.new()

	pass # Replace with function body.
func _interact():
	if self.interact_count>=0:
		#DialogueManager.add_line("hi this is your first time here right")
		#DialogueManager.add_line("woohoo this rocks so much")
	#elif self.interact_count==1:
		#DialogueManager.add_line("Arent you bored? you've pressed that button {0} times...",[self.interact_count+1])
	#else:
		DialogueManager.add_line("Hey, quick question,| are you ok?|")
		DialogueManager.add_line("[option]no, not really||sure, yeah||AHHHHHHHH||meh.")
		DialogueManager.add_consequence(0,"damn that sounds bad.")
		DialogueManager.add_consequence(1,"oh ok.")
		DialogueManager.add_consequence(1,"that's nice i think.")
		DialogueManager.add_consequence(2,"AHHHHHHHHHHHHH")
		DialogueManager.add_consequence(2,"why are we yelling actually")
		DialogueManager.add_consequence(3,"You're boring...")
		DialogueManager.add_consequence(4,"HAH TOO LATE LMAO")
		await DialogueManager.read_dialogue()
		DialogueManager.add_line("ok whatevs")
		if globals.yourchoice==2:
			DialogueManager.add_line("So how's choosing the third option feel?")
			DialogueManager.add_line("[option]bad?||good?")
			DialogueManager.add_consequence(0,"but why though!!!!!!!!")
			DialogueManager.add_consequence(1,"YEAH!!! IT FEELS NICE SCREAMING LOUD AS FUCK DOESN'T IT!")
		elif globals.yourchoice==3:
			DialogueManager.add_line("Really, what got you into such a funk?!")
			DialogueManager.add_line("[option]my life is driven not by myself but by the cruel hands of fate||this life is of less meaning than the matters that sustain it")
			DialogueManager.add_line("nope. not unpacking that. nuh uh.")
			DialogueManager.add_consequence(0,"...go get a therapist.")
			DialogueManager.add_consequence(1,"Stop being so dramatic.")
	self.interact_count+=1
	await DialogueManager.read_dialogue()
	

func _input(event: InputEvent) -> void:
	pass#this is supposed to be on the player character but i put it here for testing purposes

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
