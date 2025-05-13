//
// Terrain Blending Fragment Shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform sampler2D uTerrainTexture;
uniform vec4 uTerrainTexcoord;
uniform float uTexSize;
uniform float uBlendRate;

void main()
{
  // Intensity is usually == vec4(1.). 
	vec4 intensity = vec4(uBlendRate, uBlendRate, uBlendRate, 1.);
	
	// Figure out the correct texture coordinates in our texture
	// This calculates a texture coordinate based on world position
	// eg. If our texture is 1024x1024. And we are at world position 2052, 100
	//       We are looking around for the pixel at 4/1024, 100/1024
	vec2 terrainCoord = mod(v_vPosition.xy, uTexSize) / uTexSize;
	
	// Get the specific texture coordinate from the texture page for the terrain
	vec2 c = uTerrainTexcoord.xy + (uTerrainTexcoord.zw - uTerrainTexcoord.xy) * terrainCoord;
	
	// Base color is the color from the tile. Usually a grayscale value. 
	// The base color also defines how much alpha channel will be used so transparent areas
	// of the tile are not drawn
	vec4 baseColor = texture2D( gm_BaseTexture, v_vTexcoord );

	// Get the texture color from the coordinates we calculated
	vec4 textureColor = texture2D( uTerrainTexture, c );
	
	// Figure out the combination of all those colors together
	vec4 blendColor = baseColor * textureColor * intensity; 
	
	// Set the color, blending with anything provided from the vertex (hopefully white)
	gl_FragData[0] = v_vColour * vec4(blendColor.rgb, baseColor.a);

}
