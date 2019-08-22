      Main panic area:
      
      - Specular_roughness is flipped
      - update the bitmap rule to port more settings
      - update the cc rule to port more settings
      
      
                          
                                                  Scene converter scripts for
                                                           
                                                         Arnold & OSL

                                             Tested in 3DS MAX 2020 before upload.
                                  Conversion rules are continously added and improved over time.



Bugs & requests gkmotu@gmail.com

Contributions by:
卢家洛,Mads Dørschler.


Correctly installed Preset file with 7 entries automatically load.
![](VrayStatus.jpg)



Vray and Corona material conversion guide.

Use the VrayToArnold PRESET file, to automatically load all available materials, shaders and light conversion rules.

The PRESET file will automatically add:

- Vray Material to Arnold Material
- Corona Material to Arnold Material
- Vray 2 sided material to Arnold two sided material
- Vray Normal map to Arnold Normal map
- Vray Dirt map to Arnold Ambient Occlusion map
- Convert Legacy 3dsmax CC node to Arnold Color Correct node
- Convert Legacy ( and slow ) 3DS MAX bitmap to Arnold Image ( mip mapping, .tx )


Remember to download and install the script files at the right location.

HERE is an archive with the location, sitting in your Documents folder.
https://github.com/gkmotu/ArnoldSceneConverterScripts3DSMAX/blob/master/VrayCoronaLegacyToArnoldConverterScripts.zip

NOTE: You can use any version of 3DS MAX as long as it has the Scene converter in it.


![](overview.gif)


Supported slots and features from Vray:

Date updated - 22.08.2019

VrayDirt:

- Invert normal
- Black
- Black on/off
- Black texture
- White
- White on/off
- White texture
- Falloff float
- Inclusive on/off


VrayNormalMap:

- Normal texture
- Normal map on/off
- Strength 

Vray2SidedMtl:

- Front
- Back

VrayMtl:

- Diffuse RGB Color
- Diffuse texture
- Diffuse map on/off
- Diffuse roughness float
- Roughness texture
- Diffuse roughness map on/off
- Emission color
- Emission float
- Emission texture
- Emission map on/off
- Specular RGB Color
- Specular roughness float 
- Specular texture
- Specular map on/off
- Specular roughness texture
- Specular rouhness map on/off
- Specular IOR
- Metalness float
- Metalness texture
- Metalness map on/off
- Opacity texture
- Opacity map on/off
- Normal texture
- Normal map on/off
- Transmission RGB color
- Transmission texture
- Transmission map on/off



Supported slots and features on Corona material:

Date updated - 20.08.2019

- Diffuse RGB color
- Specular RGB color
- Transmission RGB color
- Opacity RGB color
- Base float
- Reflect float
- Transmission float
- Diffuse texture
- Specular texture
- Roughness texture
- Transmission texture
- Transmission extra roughness texture
- Opacity texture
- IOR texture
- Emission texture	
- Diffuse map on/off
- Specular map on/off
- Transmission on/off
- Specular map on/off
- Opacity map on/off
- Extra roughness map on/off
- Opacity map on/off
- Emission map on/off
- Anisotropy map on/off
- rotation map on/off
- Anisotropy float
- Anisotropy rotation float
- Normal texture
- Normal map on/off


LEGACY MAX Items:

Legacy Color Correct map to Arnold Color Correct map.

- Input texture


Legacy Bitmap to Arnold Image.

- update shader and update this.









