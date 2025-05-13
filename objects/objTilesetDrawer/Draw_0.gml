/// @description Insert description here
// You can write your code in this editor
/// DRAW EVENT
// Get parameters for our shader
var _sampler = shader_get_sampler_index(shdBlendTerrain, "uTerrainTexture");
var _texCoord = shader_get_uniform(shdBlendTerrain, "uTerrainTexcoord");
var _texSize = shader_get_uniform(shdBlendTerrain, "uTexSize");
var _uBlendRate = shader_get_uniform(shdBlendTerrain, "uBlendRate");

// Tile Map Drawing
for(var _tileLayer = array_length(tilemapLayers) - 1; _tileLayer >= 0 ; _tileLayer--) {
	var _tileId = layer_tilemap_get_id(tilemapLayers[_tileLayer]);
	
	// Figure out what texture sprite to use for blending or undefined to bypass blending
	var _blendTexture = getBlendTexture(_tileId);
	
	if(_blendTexture != undefined) {
		shader_set(shdBlendTerrain);
		
		// Pass in the texture to the shader
		texture_set_stage(_sampler, sprite_get_texture(_blendTexture, 0));

		// Need to get the specific texture coordinates for the texture from the page
		var _uvs = sprite_get_uvs(_blendTexture, 0);
		shader_set_uniform_f(_texCoord, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);

	  // Assumes a square texture
		shader_set_uniform_f(_texSize, sprite_get_width(_blendTexture)); 

		// Blending between tilelayer and texture, 1 for most cases
		shader_set_uniform_f(_uBlendRate, 1); 
	}
	
	gpu_set_ztestenable(false);
	draw_tilemap(_tileId, 0, 0);
	shader_reset();
}