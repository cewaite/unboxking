class_name Boss extends Node2D

@export var left_hand: Hand
@export var right_hand: Hand
#@export var head: Head

# Should only be of type Hand or null 
var controlled_hand

func _ready():
	left_hand.controlled_hand.connect(track_controlled_hand)
	right_hand.controlled_hand.connect(track_controlled_hand)

func track_controlled_hand(hand):
	controlled_hand = hand
