extends TextureProgressBar

@export var player: Player

func _ready():
	player.healthChange.connect(update_bar)
	update_bar()

func update_bar():
	value = player.CurrentHealth * 100 / player.maxHealth
	
