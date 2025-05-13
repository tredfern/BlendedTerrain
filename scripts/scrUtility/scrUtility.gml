function layerGetTilemaps() {
	var _layers = layer_get_all();
	var _tmLayers = [];
	
	for(var _i = 0; _i < array_length(_layers); _i++) {
			// If layer is marked hidden in the editor, we should ignore it
			if(layer_get_visible(_layers[_i])) {
				if(layer_tilemap_get_id(_layers[_i]) != -1) {
					array_push(_tmLayers, _layers[_i]);	
				}
			}
	}
	
    // We get the array front to back, we want to draw back to front
	return array_reverse(_tmLayers);
}


function getBlendTexture(_tileset) {

    switch(_tileset) {
        case tsGrass:
            return sprGrassTexture;
    }    
    
    return undefined;
}