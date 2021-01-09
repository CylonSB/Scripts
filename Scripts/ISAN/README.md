# Integrated System for Autonomous Navigation

ISAN is a navigation system within [Starbase](https://store.steampowered.com/app/454120/Starbase/), developed by [Collective](https://wiki.starbasegame.com/index.php/Collective). When installed on a ship, it calculates your X, Y, and Z coordinates in space, relative to Origin station.

# Modularity
ISAN is designed to be extendable using addons. To accomplish this, ISAN is split into one core module, and any number of optional addons. These communicate to each other using a standardised API, allowing you to use any core with any number of addons, you can even create your own! The core module you should use depends on how much space you have on your ship, and how much you care about maintaining coordinate accuracy while moving.

# Cores

ISAN has two core modules; ISAN Mono and ISAN Quad. Mono is smaller, but inaccurate while moving, while Quad is larger, but more accurate.

| ISAN Core                  | Mono          | Quad  |
| -------------------------- | ------------- | ----- |
| Yolol Chips                | 1             | 1     |
| Radio Receivers            | **1**         | 4     |
| Refresh Rate               | ~1.4 seconds  | **0.8 seconds** |
| Accuracy while moving*     | ~±20%         | **~±1%** |
| Accuracy while stationary* | ~±1%          |    ~±1% |
| Max range from Origin      | ~1,000,000 meters | ~1,000,000 meters |

_*Accuracy decreases with distance from Origin. Within 100,000 meters, accuracy is around ±0.1%._

## Setting Up ISAN Mono

[Tutorial Video](https://youtu.be/UPMoVrCzoGc)

You need a receiver (either size is fine), placed anywhere on your ship, an advanced quality or better YOLOL chip, a memory chip, and a text panel. Make sure they are all connected to the same cable network.

Rename these fields in the receiver:
 - `Message` to N1
 - `SignalStrength` to R1
 - `TargetMessage` to M1

Set the value of:
 - `ListenAngle` to 180

Include these fields in the memory chip:
 - XX
 - YY
 - ZZ
 - CL
 - SD
 - Pos

Open the device fields of the text panel and rename:
 - `PanelValue` to Pos

Open the YOLOL chip and copy in the code from [Mono.yolol](/Scripts/ISAN/?id=monoyolol).

## Setting Up ISAN Quad

You need four receivers (either size is fine), placed as close together as possible anywhere on your ship (see the [announcement video](https://youtu.be/ASuTG5dBYpo?t=60) for an example), an advanced quality or better YOLOL chip, a memory chip, and a text panel. Make sure they are all connected to the same cable network.

Rename these fields in each of your receivers (1 through 4, replacing # with the receiver number):
 - `Message` to N#
 - `SignalStrength` to R#
 - `TargetMessage` to M#

Set the value of:
 - `ListenAngle` to 180

Include these fields in the memory chip:
 - XX
 - YY
 - ZZ
 - CL
 - SD
 - Pos

Open the device fields of the text panel and rename:
 - `PanelValue` to Pos

Open the YOLOL chip and copy in the code from [Quad.yolol](/Scripts/ISAN/?id=quadyolol).

# Addons

## Velocity Addon

The velocity addon calculates the speed of your ship when moving in a straight line.

You need to add a new professional YOLOL chip and a new text panel. Make sure they are both connected to the same cable network as the core module.

Include these fields in a memory chip:
 - VV
 - Vel

Open the device fields of the text panel and rename:
 - `PanelValue` to Vel

Next open the YOLOL chip and paste in the code from [Velocity.yolol](/Scripts/ISAN/?id=velocityyolol).

## UOC-Momentum Addon

Universal Orientation Calculation-Momentum (UOC-M) calculates your heading and pitch while moving in a straight line.

Heading is your angle through the X-Y plane, from 0 to 360, increasing as you yaw to the right. 0 is away from Eos, 180 is toward Eos.

Pitch is your angle off from the X-Y plane, from -90 to 90. 0 is perpendicular to the X-Y plane, 90 is perpendicular and up towards positive z, -90 is perpendicular and down towards negative z.

<img src="https://i.imgur.com/YmH6UB6.png" alt="Orientation" style="display:block;margin-left:auto;margin-right:auto;width:50%;"/>

You need to add a new professional YOLOL chip, and a new text panel. Make sure they are both connected to the same cable network as the core module.

Include these fields in a memory chip:
 - HH
 - PP
 - Orn

Open the device fields of the text panel and rename:
 - `PanelValue` to Orn

Next open the YOLOL chip and paste in the code from [Orientation.yolol](/Scripts/ISAN/?id=orientationyolol).

## WNS Addon

Waypoint Navigation System (WNS) is an add-on that makes going to ISAN coordinates fast and easy. Using this system in conjunction with the UOC makes it easy to point toward a destination. To enter a destination, simply change the value of the DX, DY and DZ fields in the memory chip to the X, Y and Z of your destination. It is recommended that you put the memory chip with DX, DY and DZ fields somewhere accessible.

You need to add a new professional YOLOL chip, and a new text panel. Make sure they are both connected to the same cable network as the core module.

Include these fields in a memory chip:
 - DX
 - DY
 - DZ
 - DH
 - DP
 - DD
 - Dst

Open the device fields of the text panel and rename:
 - `PanelValue` to Dst

Next open the YOLOL chip and paste in the code from [WNS.yolol](/Scripts/ISAN/?id=wnsyolol).

# API Specifications

If you plan on making your own addons, these are all the specs you need to know to create a fully compatible addon.

External variables created by a core module are:
 - `:XX` - X Coordinate
 - `:YY` - Y Coordinate
 - `:ZZ` - Z Coordinate
 - `:CL` - Clock pulse, which tells addons when to output their data and loop back to their beginnings. Set to 1 on the last line in core modules, and is set to 0 on the first line in core modules.
 - `:SD` - Signal detection, a number from 0 to 4, representing the number of receiver signals that are being received.
 - `:Pos` - Pre-formatted output for text displays.
 - `:R#` - Signal strength of the #th receiver.
 - `:M#` - Target message of the #th receiver.
 - `:N#` - Received message of the #th receiver.

Requirements:
 - Addons can be **at most** four lines long. Additional lines are allowed that do not loop, such as lines dedicated to setting up local variables. 
 - Use **at least** two characters per external variable.
   - (Correct) `:FO`
   - (Incorrect) `:B`
 - (Optional) Include a pre-formatted text display external variable, with a three character variable.
   - (Examples) `:Pos`, `:Vel`
 - The last line of your addon should include a way to loop continuously on that line until `:CL = 1`, where it should then output the pre-formatted output, and return to the start of your addon. See the velocity addon for an example.
 - `:XX`, `:YY`, and `:ZZ`, must be read on or before the third line of your addon.

# Credits

 - `Solonerus` - Project management
 - `Lumi Virtual` - Development of the current version of ISAN ‘ISAN alchemist’
 - `Strikeeaglechase` - Development of offsets and ISAN code
 - `MuNk` - Code consultation
 - `Nordwolf` - Design of previous iteration of ISAN, coordinate system calculation and measurements
 - `Battle_Wrath` - Various design ideas and general help
 - `Archduke` - Invaluable support and document writeup
 - `Zaff` - Security and usability consultation, documentation
 - `Meboy100` - Le rubber duck
 
## Files
 
### Mono.yolol
[Mono.yolol](Mono.yolol ':include')
 
### Orientation.yolol
[Orientation.yolol](Orientation.yolol ':include')
 
### Quad.yolol
[Quad.yolol](Quad.yolol ':include')
 
### Velocity.yolol
[Velocity.yolol](Velocity.yolol ':include')
 
### WNS.yolol
[WNS.yolol](WNS.yolol ':include')
