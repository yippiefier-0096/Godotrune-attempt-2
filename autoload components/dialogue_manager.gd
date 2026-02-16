extends Node
class_name dialogue_manager

var dialogue:Array[String]#this is the dialogue itself, appended 
var modifier:Array[Array]
var sc_count="my code"


#i have no idea how to work this system so here
var ui:ui_manager
var list_of_consequences:Array[Array]=[[],[],[],[],[]]
var consequence_breakpoint:int=0

func _ready() -> void:
	pass # Replace with function body.
	
func add_line(input,aug:Array=[]): #the first entry of input must be the line with the text parameters
	var _line:String = str(input)
	dialogue.append(_line.format(aug))

func add_consequence(entry:int,input,aug:Array=[]):
	var _line:String = str (input)
	list_of_consequences[clamp(entry,0,4)].append(_line.format(aug))
	consequence_breakpoint=dialogue.size()
	
func read_dialogue():
	var _current_line:String
	globals.mode=1
	UiManager.normal.visible=true
	UiManager.normal.skip=false
	while dialogue.size()>0:
		var content=dialogue.pop_front()
		if !content.begins_with("[option]"):
			UiManager.basetext(content)
			await UiManager.normal.next_line
			UiManager.normal.visible=false
		else:
			UiManager.normal.can_next=false
			content=content.erase(0,8)
			UiManager.questiontext(content.split("||",true,4))
			await UiManager.question.next_line
			globals.yourchoice=UiManager.question.selection
			while list_of_consequences[globals.yourchoice].size()>0:
				dialogue.push_front(list_of_consequences[globals.yourchoice].pop_back())
			list_of_consequences=[[],[],[],[],[]]
			UiManager.normal.skip=false
	UiManager.normal.visible=false
	globals.mode=0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
