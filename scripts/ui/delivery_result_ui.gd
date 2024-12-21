extends Control

@export var delivery_counter: BaseCounter

@export var background_image: TextureRect
@export var icon_image: TextureRect
@export var message_text: Label
@export var success_color: Color
@export var failed_color: Color
@export var success_sprite: Texture2D
@export var failed_sprite: Texture2D
@export var animation_player: AnimationPlayer

func _ready():
	delivery_counter.delivery_manager.OnRecipeSuccess.connect(_delivery_manager_on_recipe_success)
	delivery_counter.delivery_manager.OnRecipeFailed.connect(_delivery_manager_on_recipe_failed)
	hide()

func _delivery_manager_on_recipe_success():
	show()
	animation_player.play("pop_up")
	background_image.modulate = success_color
	icon_image.texture = success_sprite
	message_text.text = "DELIVERY\nSUCCESS"

func _delivery_manager_on_recipe_failed():
	show()
	animation_player.play("pop_up")
	background_image.modulate = failed_color
	icon_image.texture = failed_sprite
	message_text.text = "DELIVERY\nFAILED"
