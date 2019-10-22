
      
      
                          
                                                  Scene converter scripts for
                                                           
                                                         Arnold & OSL

                                             Tested in 3DS MAX 2020 before upload.
                                  Conversion rules are continously added and improved over time.





Bugs & requests gkmotu@gmail.com

Contributions by:
卢家洛,Mads Drøschler.

<h1><b>Latest update: 22 October 2019.</b></h1>

- Added Corona Color ***** This map has been rewritten in OSL and can be found in the MDShaders category
- Added Vray Color ***** This map has been rewritten in OSL and can be found in the MDShaders category 
- Fixed base color on Corona material
- Added Corona AO to Arnold Ambient Occlusion
- Added Corona Normal map to Arnold Normal map
- Added Corona Triplanar map ( single map mode ) to Arnold Triplanar
- Added Corona Bitmap to Arnold Image



Added 20.10.2019
- Added Vray Blend Material to Arnold Layer
- Fixed flipped Roughness value on Vray Material

This effort eases the pain when you need to convert Vray & Corona scenes to Arnold.
The effort also aims at optimizing very old and very very bad shader code, so that the viewport and Arnold can fetch changes and in general just work better and faster.
Especially the composit map and the old legacy bitmap loaders are 2 very bad constructs! DON’T use them!



INSTALLATION GUIDE!

Download the self extracting .exe file to the default location and load the VrayToArnold.ms PRESET file.

Watch this video: https://www.youtube.com/watch?v=dhV5yaSzjc8




Supported features:

Vray Materials:

- Vray material
- Vray 2 sided material
- Vray light material
- Vray Blend Material

Vray Shaders:

- Vray Color ** Map has been rewritten in OSL
- Vray dirt map
- Vray HDRI map
- Vray normal map
- Vray Sky

Vray Lights:

- Vray Area light
- Vray portal light
- Vray disc light
- Vray mesh light
- Vray point light

Corona Materials:

- Corona material

Corona Shaders:

- Corona AO
- Corona Normal map
- Corona Triplanar
- Corona Color ** Map has been rewritten in OSL
- Corona Bitmap


Legacy Shaders:

- Legacy bitmap
- Legacy color correct
- Legacy composit map
- Legacy mix map
- Legacy vertex color
