# Iannix/Csound Möbius Strip Audiovisual Composition

An interactive audiovisual composition exploring the integration of IanniX and Csound. The system generates a 3D Möbius strip from parametric equations, with each contour line tracked by a cursor that transmits spatial data via OSC to control synthesis parameters in real-time.

## Overview

This project bridges IanniX's visual graphing capabilities with Csound's synthesis engine to create a parametric music system. A Möbius strip is generated from 50 contour lines in 3D space, with cursors traversing each line and mapping their x, y, and z coordinates to synthesis parameters including pitch, filter frequency, resonance, and amplitude. Real-time OSC communication enables interactive performance control, while trigger objects add discrete events for compositional variation.

## Features

- **Parametric 3D Geometry**: Generates a Möbius strip using parametric equations with customizable parameters
- **Real-time OSC Communication**: Bidirectional data flow between IanniX and Csound
- **Interactive Performance**: Transport controls allow speed adjustment and reverse playback
- **Multiple Synthesis Parameters**: Maps spatial coordinates to pitch (quantized to scale), detune, filter frequency, and resonance
- **Trigger Events**: Binary triggers for discrete musical events (transposition effects)
- **Scalable Design**: Easily adjust number of contour lines and visual parameters

## Requirements

### Software
- **IanniX** - [Download here](https://www.iannix.org/)
- **Csound** - [Download here](https://csound.com/download.html)
  - Version 6.x or higher recommended

## Running the Project

1. **Clone the repository**  
   With IanniX and Csound installed, clone this repository:
```bash
   git clone https://github.com/Bohr33/IanniX-Csound-Mobius.git
   cd IanniX-Csound-Mobius
```

2. **Open the project files**  
   Open both the IanniX project file and `mobius.csd` in their respective applications.

3. **Configure the number of curves**  
   When prompted in IanniX, enter the number of curves to generate. The Csound file is currently configured for 50 curves, though this can be modified in the `mobius.csd` file if needed.

4. **Start playback**  
   - Start Csound first by pressing the Run/Play button
   - Then press Play in IanniX's transport controls
   - If properly configured, you should hear the composition evolving as the cursors move through the Möbius strip

**Troubleshooting:** If you don't hear any audio, verify the OSC connection settings. In IanniX, check the `CONFIG` tab and ensure the OSC output port matches Csound's listening port (default: `57120`). If issues persist, try changing the host address or port number in both applications.


## More Information

For an in-depth exploration of the parametric equations, OSC implementation, and Csound instrument design, see the [complete project write-up](FUTURE WEBSITE LINK).