extends Node



const INTERACTIBLE_OBJECT_RES_PATH := preload("res://scenes/environment/interactible_objects/interactible_resources.tscn")

var small_boat : SmallBoat = null
var boat_view : BoatView = null
var sea_view : Node2D = null
var steam_engine : SteamEngine = null
var light_house : LightHouse = null
var world = null
var camera_utils : CameraUtils = null
