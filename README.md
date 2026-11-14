move through different biomes: rainforests, oceans, villages  
starter animal and every biome unlocks a new variation or animal or upgrade  
could a puzzle platformer themed puzzle  
story could be about finding some lost treasure  

List of biomes and animals:  
Rainforest - Ants, Frogs, Jaguars, Toucans  
Desert - Camel, Fox, Snake, Roadrunner, Scorpion  
Temperate Forest - Deer, Bear, Fox, Owl  
Tundra - Polar bear, Arctic fox, Snowy Owl  
Ocean - Dolphin, Turtle, Fish  

<img width="64" height="64" alt="owl1" src="https://github.com/user-attachments/assets/9abf5b85-eff7-434e-8b10-f5cab62b9bcd" />


1. Static Background & Far Ground (Window Size)

Because these never move, you don't need parallax nodes for them.
• Add a CanvasLayer node to your level and set its Layer property to -100 (so it renders behind everything else).
• Add a TextureRect (or Sprite2D) inside the CanvasLayer for your sky and far ground.
• Set its size to match your viewport/window size. Because it's inside a CanvasLayer, it stays locked to the screen even when the player's Camera2D moves.

2. Slightly Moving Midground (Slightly Longer Image)

For an image that is slightly wider than your window and doesn't loop:
• Add a Parallax2D node to your level and place your midground Sprite2D inside it (with Centered unchecked in the Sprite2D Inspector so its top-left aligns at (0, 0)).
• Leave Repeat Size at (0, 0) so it does not tile.
• Lower the Scroll Scale (X) to a small value like 0.1 or 0.2.
How to pick the exact Scroll Scale:
To prevent the edge of your midground image from showing before the player reaches the end of the level, calculate the ratio between your extra midground width and your extra level width:
\(\text{Scroll\ Scale\ X}=\frac{\text{Midground\ Width}-\text{Window\ Width}}{\text{Level\ Width}-\text{Window\ Width}}\)
(Example: If your window is 1280px, your level is 5000px, and your midground image is 1800px, your scale is (1800 - 1280) / (5000 - 1280) ≈ 0.14.)

3. Foreground Moving with the Player (Full Level Length)

Because the foreground matches the exact length of your level and moves 1:1 with the player, it behaves just like normal level terrain:
• You don't even need a Parallax2D node—just place your full-length foreground Sprite2D directly in your level scene at (0, 0) (with Centered unchecked) and set its Z Index higher than the player (e.g., 10) if you want it overlapping in front of them.
• (Alternatively, if you put it inside a Parallax2D node, keep Scroll Scale at 1.0 and Repeat Size at 0.)

Node Tree Summary

Your scene hierarchy should look like this:
• Level (Node2D)
	• StaticBackground (CanvasLayer, Layer = -100)
		• SkyAndFarGround (TextureRect)
	• MidgroundParallax (Parallax2D, Scroll Scale X = 0.15)
		• MidgroundArt (Sprite2D, Centered = Off)
	• TileMapLayer (Your playable platforms/collisions)
	• Player (CharacterBody2D with Camera2D)
	• ForegroundArt (Sprite2D, Centered = Off, Z Index = 10)
(Note: Make sure to set your Camera2D Limit Left to 0 and Limit Right to your exact level width in pixels so the camera stops at the edges of your art!)
