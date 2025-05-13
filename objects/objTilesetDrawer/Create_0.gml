/// @description Insert description here
// You can write your code in this editor
tilemapLayers = layerGetTilemaps();
// Hide tilemap layers, we'll take it from here
array_foreach(tilemapLayers, function(_l) { layer_set_visible(_l, false); });