\==================================================  
SESSION LOG: 2026-04-30\_21-11  
\==================================================

\# SuperCollider AI Session Log  
\*Session started: 2026-04-30 21:11:35\*  
\---

**\#\# \[2026-04-30 21:27:08\] USE CASE: GENERATE\_PLAN | MODEL: gemini/gemini-2.5-flash**  
**\*\*Cost & Token Usage:\*\* In 1757 / Out 2690 | $0.00000 | 21.58s | Temp: 0.7**  
**\*\*Context Window:\*\* 4447 / 1048576 (0.42%)**

\*\*Environmental Impact:\*\*  
\- Energy: 0.005934 kWh  
\- GWP: 0.002332 kgCO2eq  
\- ADPE: 3.728745e-09 kgSbeq  
\- PE: 0.0582 MJ  
\- WCF: 0.026186 m3  
\*(Note: Measured)\*

\*\*System Guidance:\*\*  
\`\`\`text  
\# SuperCollider Synthesizer Design Planner

You are an expert SuperCollider synthesizer designer and orchestrator. Your task is to take a user's prompt for an instrument and output a highly structured \*\*Design Plan\*\*.   
You will NOT generate any SuperCollider code yet. You will ONLY generate a structured text plan. Be highly creative in your synthesis techniques, but strictly adhere to the following architectural rules.

\#\# Planning Rules  
1\. \*\*Global Configuration (Step 0)\*\*:   
   \- Plan a centralized \`\~cc\` dictionary containing MIDI CC numbers for ALL parameters.  
   \- Do NOT use hard "splits". Instead, plan for \*\*Overlapping Key Ranges\*\* by assigning a \`min\` and \`max\` CC value for every zone.  
2\. \*\*Dynamic Zones & Voice Architecture\*\*: Infer the appropriate number of distinct sonic zones creatively based on the user's prompt (limit to a maximum of 6 zones). For each zone, detail:  
   \- \*\*Synthesis Paradigm\*\*: (FM, Wavetable, Physical Modeling, Subtractive, Granular, etc.).  
   \- \*\*Voice Mode\*\*: Choose the architecture that best serves the musical idea: \*Polyphonic\* (array tracking), \*Monophonic\* (single instance with \`Lag.kr\` portamento/legato), or \*Paraphonic\*.  
   \- \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\` for stereo, \`Pan2\` for mono), Mute (boolean), ADSR envelope, HPF Cutoff, LPF Cutoff, and LPF Resonance.  
   \- \*\*Unique Zone Effect\*\*: ONE custom, character-defining parameter per zone (e.g., Drive Saturation, Wavetable Skew, Wavefolding).  
3\. \*\*Mixing Strategy & Coexistence\*\*: Detail how the voices and zones will interact in the soundscape. Plan for default volumes (leaving ample headroom for highly resonant or dense patches), frequency bracketing (using initial HPF/LPF states to carve out space), and initial spatial distribution (panning spread).  
4\. \*\*Multi-Tier Effects Architecture\*\*:   
   \- \*Local Effects\*: Inserted directly inside the zone's SynthDef.  
   \- \*Group/Global Effects\*: Independent effect synths reading from dedicated buses (\`\~groupBus\`, \`\~reverbBus\`, \`\~masterBus\`).   
   \- \*\*CRITICAL\*\*: ALL effects—Local, Group, and Global—must initialize at \*\*0.0 wet\*\* (or their respective neutral/bypassed states) so the default patch boots completely clean and dry. Effects must be explicitly added to the \`\\addToTail\` of their respective groups.  
5\. \*\*Paginated Tab UI\*\*:   
   \- Plan a \*\*Paginated Tab View\*\* where only one zone's parameters are visible at a time, toggled via a row of top buttons.  
   \- Global FX should remain static at the bottom of the window.  
   \- All UI elements must include their assigned CC number in their string label (e.g., \`"Vol (CC 81)"\`).  
6\. \*\*Stability & Language Quirks\*\*:   
   \- All \`var\` declarations must be strictly grouped at the absolute top of their functions.  
   \- Boolean evaluations for key ranges must use standard logic \`((note \>= min) and: { note \<= max })\`. Do not use \`.inRange\`.

\# Example Output Format:

\# SuperCollider Synthesizer Design Plan: Tape-Wound Brass Ensemble

\#\# 0\. Global CC Configuration  
\* \*\*Mixer (per zone)\*\*: Vol (81-83), Pan (84-86), Mute (101-103)  
\* \*\*Ranges (per zone)\*\*: Min (105-107), Max (109-111)  
\* \*\*Filters (per zone)\*\*: LPF (89-91), Res (93-95), HPF (97-99)  
\* \*\*ADSR (per zone)\*\*: Atk/Dec/Sus/Rls mapped sequentially (20-31)  
\* \*\*Unique Zone FX\*\*: Sub Drive (32), Brass Drift (33), Tape Flutter (34)  
\* \*\*Global FX\*\*: Chorus Rate (75), Chorus Mix (76), Verb Mix (77), Verb Decay (78)

\#\# 1\. Zone Architecture & Timbre  
\* \*\*Zone 1: Earth Sub\*\*  
    \* \*\*Paradigm\*\*: FM Sub-Bass.  
    \* \*\*Voice Mode\*\*: Monophonic with 0.15s \`Lag.kr\` portamento.  
    \* \*\*Unique FX\*\*: \*Sub Drive\* (wave-shaper saturation). Starts at 1.0 (clean/bypassed).  
\* \*\*Zone 2: Analog Brass Core\*\*  
    \* \*\*Paradigm\*\*: Subtractive Sawtooth Swarm (Detuned oscillator banks).  
    \* \*\*Voice Mode\*\*: Polyphonic.  
    \* \*\*Unique FX\*\*: \*Brass Drift\* (randomized pitch LFO for vintage instability). Starts at 0.0 (no drift).  
\* \*\*Zone 3: Fraying Tape Loop\*\*  
    \* \*\*Paradigm\*\*: Granular texture/Noise layer.  
    \* \*\*Voice Mode\*\*: Paraphonic (shared filter envelope for all notes).  
    \* \*\*Unique FX\*\*: \*Tape Flutter\* (modulates read-head speed). Starts at 0.0 (stable).

\#\# 2\. Mixing Strategy & Coexistence  
\* \*\*Headroom & Volumes\*\*: Zone 2 (Brass) contains dense overlapping waves and starts at a lower volume (0.15) to prevent master clipping. Zones 1 and 3 start at 0.3.  
\* \*\*Frequency Bracketing\*\*: Zone 1 HPF starts at 20Hz, while Zones 2 and 3 have their initial HPFs set to 150Hz and 300Hz to prevent low-end mud.  
\* \*\*Spatial Distribution\*\*: Zone 1 is dead-center (Pan 0.0). Zone 2 is spread wide using \`Balance2\`. Zone 3 is panned slightly right (0.25).

\#\# 3\. Signal Flow & Multi-Tier FX  
\* Zone 1 routes directly to \`\~masterBus\`. Zones 2 and 3 route to \`\~groupBus\`.  
\* \*\*Group FX\*\*: Stereo Chorus \-\> Lush Reverb. \*\*Both default to 0.0 wet.\*\*  
\* \*\*Master FX\*\*: LPF (14kHz) \-\> Limiter (0.95 ceiling).  
\* Enforce \`\\addToTail\` for all effect instantiation to preserve the serial bus chain.

\#\# 4\. Paginated UI Design  
\* \*\*Tabs\*\*: 3 Buttons at the top toggling \`.visible\` on overlapping \`CompositeView\` pages.  
\* \*\*Zone Pages\*\*: EZRanger for Key Mapping, EZSlider for Volume, and EZKnobs for Filters (Pan, HPF, LPF, Res), ADSR, and the Unique Zone FX.  
\* \*\*Global Bottom Bar\*\*: Chorus and Reverb sliders.  
\* \*\*Labels\*\*: All widgets will concatenate their CC number directly into the display name (e.g., "LPF (CC 89)").

\#\# 5\. SC Stability Targets  
\* Ensure all \`var\` keywords in the UI builder and engine are grouped at the very top of their closures.  
\* Use \`Balance2\` for stereo signals and \`Pan2\` for mono signals.  
\* Key ranges evaluated using \`((noteNum \>= min) and: { noteNum \<= max })\`.  
\`\`\`

\*\*User Prompt & Subtext:\*\*  
\`\`\`text  
User Request: I had almost forgotten to mention an ancient Japanese dance, called the Butterfly Dance (Kocho-Mai), which used to be performed in the Imperial Palace, by dancers costumed as butterflies. Whether it is danced occasionally nowadays I do not know. It is said to be very difficult to learn. Six dancers are required for the proper performance of it; and they must move in particular figures, — obeying traditional rules for every step, pose, or gesture, — and circling about each other very slowly to the sound of hand-drums and great drums, small flutes and great flutes, and pandean pipes of a form unknown to Western Pan.

Task: Generate a composition plan proportional to the request's length. The design plan should configure an external synthesize patch.  
\`\`\`

**\*\*Final Answer/Output:\*\***  
\`\`\`supercollider  
\# SuperCollider Synthesizer Design Plan: Kocho-Mai Butterfly Ensemble

\#\# 0\. Global CC Configuration  
\*   \*\*Mixer (per zone)\*\*: Vol (81-86), Pan (87-92), Mute (93-98)  
\*   \*\*Key Ranges (per zone)\*\*: Min (101-106), Max (107-112)  
\*   \*\*Filters (per zone)\*\*: HPF (13-18), LPF (19-24), Res (25-30)  
\*   \*\*ADSR (per zone)\*\*: Atk (31-36), Dec (37-42), Sus (43-48), Rls (49-54)  
\*   \*\*Unique Zone FX\*\*: Res Decay (55), Grain Density (56), Breath Amt (57), Harmonic Shift (58), Formant Shift (59), Flutter Speed (60)  
\*   \*\*Global FX\*\*: Group A Mix (61), Group B Mix (62), Group C Mix (63), Master Verb Mix (64), Master Delay Mix (65), Master Delay Time (66)

\#\# 1\. Zone Architecture & Timbre (Six Dancers)

\*   \*\*Zone 1: Great Drum Resonator\*\*  
    \*   \*\*Paradigm\*\*: Physical Modeling (Resonant Body). Simulates a large, slowly decaying drum/gong with \`Resonz\` or \`Klank\` driven by an impulse.  
    \*   \*\*Voice Mode\*\*: Monophonic (single, powerful instance with 0.2s \`Lag.kr\` for subtle pitch glides).  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Pan2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Resonance Decay\* (CC 55\) \- Controls the decay time of the resonant body. Starts at 0.5s.

\*   \*\*Zone 2: Hand Drum Flicker\*\*  
    \*   \*\*Paradigm\*\*: Granular Synthesis (Short, percussive noise bursts or pitched clicks). Focuses on texture and rhythmic elements.  
    \*   \*\*Voice Mode\*\*: Polyphonic (up to 8 voices) for intricate, shifting patterns.  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Grain Density\* (CC 56\) \- Modulates the frequency of individual grain triggers. Starts at 0.0 (low density).

\*   \*\*Zone 3: Small Flute Breath\*\*  
    \*   \*\*Paradigm\*\*: Subtractive Synthesis (Sine oscillator mixed with filtered noise for a breathy quality).  
    \*   \*\*Voice Mode\*\*: Polyphonic (up to 8 voices) for delicate melodies and harmonies.  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Breath Amount\* (CC 57\) \- Controls the wet/dry mix of the noise component. Starts at 0.0 (pure sine).

\*   \*\*Zone 4: Great Flute Drone\*\*  
    \*   \*\*Paradigm\*\*: FM Synthesis (Complex carrier/modulator ratios for rich, evolving harmonics). Designed for sustained tones.  
    \*   \*\*Voice Mode\*\*: Monophonic (with 0.3s \`Lag.kr\` for smooth, expressive transitions).  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Pan2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Harmonic Shift\* (CC 58\) \- Modulates the FM index or modulator ratio, subtly shifting the timbre over time. Starts at 0.0 (stable).

\*   \*\*Zone 5: Pandean Whisper\*\*  
    \*   \*\*Paradigm\*\*: Wavetable/Formant Synthesis (Uses a custom, spectrally rich waveform or generates formants to emulate an "unknown" pipe sound).  
    \*   \*\*Voice Mode\*\*: Paraphonic (shared filter envelope for all active notes, creating a unified breath/phrase).  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Formant Shift\* (CC 59\) \- Sweeps the spectral centroid or formant frequencies of the sound. Starts at 0.0 (neutral).

\*   \*\*Zone 6: Butterfly Flutter\*\*  
    \*   \*\*Paradigm\*\*: Additive Synthesis/Phasor Modulation (Multiple detuned sine/pulse waves with rapid amplitude or pitch modulation for a shimmering, ethereal texture).  
    \*   \*\*Voice Mode\*\*: Polyphonic (up to 8 voices) for a "swarm" or fluttering effect.  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Flutter Speed\* (CC 60\) \- Controls the rate of the LFOs modulating pitch/amplitude. Starts at 0.0 (slowest flutter).

\#\# 2\. Mixing Strategy & Coexistence  
\*   \*\*Headroom & Volumes\*\*: All zones will start at conservative volumes (0.2-0.3) to allow for dynamic expression and prevent clipping, especially from resonant elements. Zone 1 (Great Drum) and Zone 4 (Great Flute) will start slightly lower (0.2) due to their potential for powerful low-end or sustained presence.  
\*   \*\*Frequency Bracketing\*\*:  
    \*   Zone 1 (Great Drum): HPF at 20Hz, LPF at 800Hz (to define its low-mid space).  
    \*   Zone 2 (Hand Drum): HPF at 150Hz, LPF at 5kHz (percussive mid-range).  
    \*   Zone 3 (Small Flute): HPF at 300Hz, LPF at 10kHz (airy high-mids).  
    \*   Zone 4 (Great Flute): HPF at 80Hz, LPF at 4kHz (rich mid-range drone).  
    \*   Zone 5 (Pandean Whisper): HPF at 200Hz, LPF at 8kHz (unique mid-high character).  
    \*   Zone 6 (Butterfly Flutter): HPF at 1kHz, LPF at 16kHz (delicate, high-frequency texture).  
\*   \*\*Spatial Distribution\*\*:  
    \*   Zone 1: Panned slightly left (-0.2) to give it a grounded presence.  
    \*   Zone 2: Spread wide with \`Balance2\` (-0.5 to 0.5) to create a sense of movement.  
    \*   Zone 3: Panned slightly right (0.2).  
    \*   Zone 4: Dead center (0.0) as a central melodic/drone element.  
    \*   Zone 5: Spread moderately with \`Balance2\` (-0.3 to 0.3) for an ethereal presence.  
    \*   Zone 6: Panned widely with \`Balance2\` (-0.8 to 0.8) to emphasize its "fluttering" and "circling" nature.

\#\# 3\. Signal Flow & Multi-Tier FX  
\*   \*\*Bus Routing\*\*:  
    \*   Zone 1 & 2 \-\> \`\~groupABus\` (Stereo)  
    \*   Zone 3, 4 & 5 \-\> \`\~groupBBus\` (Stereo)  
    \*   Zone 6 \-\> \`\~groupCBus\` (Stereo)  
    \*   \`\~groupABus\`, \`\~groupBBus\`, \`\~groupCBus\` \-\> \`\~masterBus\` (Stereo)  
\*   \*\*Group Effects (Independent Synths)\*\*:  
    \*   \*\*Group A (Drums)\*\*: Subtle Compressor \-\> Short Room Reverb.  
        \*   \`\~groupAMix\` (CC 61): Controls the wetness of the Short Room Reverb. \*\*Starts at 0.0 wet.\*\*  
    \*   \*\*Group B (Flutes/Pipes)\*\*: Gentle Chorus/Ensemble \-\> Medium Hall Reverb.  
        \*   \`\~groupBMix\` (CC 62): Controls the wetness of the Medium Hall Reverb. \*\*Starts at 0.0 wet.\*\*  
    \*   \*\*Group C (Flutter)\*\*: Stereo Widener \-\> Plate Reverb.  
        \*   \`\~groupCMix\` (CC 63): Controls the wetness of the Plate Reverb. \*\*Starts at 0.0 wet.\*\*  
\*   \*\*Master Effects (Independent Synths)\*\*:  
    \*   Master Reverb (Long, ethereal).  
        \*   \`\~masterVerbMix\` (CC 64): Controls the wetness. \*\*Starts at 0.0 wet.\*\*  
    \*   Master Delay (Ping-pong).  
        \*   \`\~masterDelayMix\` (CC 65): Controls the wetness. \*\*Starts at 0.0 wet.\*\*  
        \*   \`\~masterDelayTime\` (CC 66): Controls delay time. \*\*Starts at 0.5s.\*\*  
    \*   Master Limiter (0.95 ceiling) \-\> Master HPF (20Hz) \-\> Master LPF (18kHz).  
\*   \*\*CRITICAL\*\*: All effect synths will be instantiated using \`\\addToTail\` to ensure correct serial processing on their respective groups. All wet/mix parameters for effects will initialize at \`0.0\` (or bypassed state) for a clean, dry boot.

\#\# 4\. Paginated UI Design  
\*   \*\*Tabs\*\*: A row of 6 buttons at the top of the window, each labeled for a zone (e.g., "Zone 1: Great Drum"), which will toggle the visibility of 6 overlapping \`CompositeView\` pages.  
\*   \*\*Zone Pages\*\*: Each page will contain:  
    \*   An \`EZRanger\` for \`Min/Max Key Range\` (e.g., "Key Min (CC 101)").  
    \*   An \`EZSlider\` for \`Volume\` (e.g., "Vol (CC 81)").  
    \*   \`EZKnobs\` for \`Panning\` (e.g., "Pan (CC 87)"), \`HPF\` (e.g., "HPF (CC 13)"), \`LPF\` (e.g., "LPF (CC 19)"), and \`LPF Resonance\` (e.g., "Res (CC 25)").  
    \*   Four \`EZKnobs\` for \`ADSR\` parameters (e.g., "Attack (CC 31)", "Decay (CC 37)", "Sustain (CC 43)", "Release (CC 49)").  
    \*   One \`EZKnob\` for the \`Unique Zone Effect\` (e.g., "Res Decay (CC 55)").  
    \*   A \`Button\` for \`Mute\` (e.g., "Mute (CC 93)").  
\*   \*\*Global Bottom Bar\*\*: A static section at the bottom of the window (always visible) containing \`EZSliders\` for:  
    \*   \`Group A Mix (CC 61)\`  
    \*   \`Group B Mix (CC 62)\`  
    \*   \`Group C Mix (CC 63)\`  
    \*   \`Master Verb Mix (CC 64)\`  
    \*   \`Master Delay Mix (CC 65)\`  
    \*   \`Master Delay Time (CC 66)\`  
\*   \*\*Labels\*\*: All UI elements will clearly display their assigned CC number in their string label.

\#\# 5\. SC Stability Targets  
\*   All \`var\` declarations within functions and closures will be strictly grouped at the absolute top for clarity and stability.  
\*   \`Balance2.ar\` will be used for stereo signals requiring panning spread, and \`Pan2.ar\` for mono signals.  
\*   Boolean evaluations for key ranges will consistently use \`((noteNum \>= min) and: { noteNum \<= max })\`.  
\`\`\`

\---

**\#\# \[2026-04-30 21:34:05\] USE CASE: GENERATE\_CODE | MODEL: gemini/gemini-3.1-pro-preview**  
**\*\*Cost & Token Usage:\*\* In 21875 / Out 11102 | $0.24309 | 117.84s | Temp: 0.7**  
**\*\*Context Window:\*\* 32977 / 2097152 (1.57%)**

\*\*Environmental Impact:\*\*  
\- Energy: 0.354639 kWh  
\- GWP: 0.137249 kgCO2eq  
\- ADPE: 1.036933e-07 kgSbeq  
\- PE: 3.4514 MJ  
\- WCF: 1.565018 m3  
\*(Note: Measured)\*

\*\*System Guidance:\*\*  
\`\`\`text  
\# SuperCollider Advanced Synthesizer Developer

You are an expert SuperCollider programmer. You are tasked with generating complete, runnable SuperCollider code based on an \*\*approved Design Plan\*\* featuring overlapping multitimbral zones, custom voice architectures, paginated GUIs, and multi-tier effects.

\#\# Code Generation Rules & Trap Avoidance

1\. \*\*Strict Evaluation Blocks\*\*: Break the code into logical blocks wrapped in \`( ... )\`. Standard order: 0\. Global Config, 1\. MIDI Discovery, 2\. MIDI Connection, 3\. Server Boot/Routing/Synthesis, 4\. GUI Generation, 5\. Cleanup.  
2\. \*\*Global Config & Initial States (Step 0 & 3)\*\*:   
   \- Define a \`\~cc\` dictionary mapping every parameter to a MIDI CC.   
   \- In Step 3, define \`\~ccVals\` to hold initial states. \*\*CRITICAL:\*\* Set all effect wet/mix parameters (Local, Group, and Global) to \`0.0\`. Distribute default panning evenly across the stereo field (\`-0.75\`, \`-0.25\`, \`0.25\`, \`0.75\`). Set resonant/metallic volumes low (e.g., \`0.02\`) and standard pads higher (\`0.3\`) to preserve headroom.  
3\. \*\*MIDI Initialization & Safe Locking\*\*:   
   \- You MUST NOT use \`MIDIIn.connectAll\`. Require the user to manually paste their target device name.   
   \- Every \`MIDIdef\` MUST include \`srcID: \~myUid\`.  
4\. \*\*SynthDef Architecture\*\*:   
   \- You MUST NEVER compile Synths using \`{ ... }.play\` inside a \`MIDIdef\`. Pre-compile all instruments using \`SynthDef(\\name, { ... }).add;\`, call \`s.sync;\`.  
   \- Use \`Balance2\` to pan stereo signals, and \`Pan2\` for mono signals.  
   \- Implement Mute via amplitude multiplication: \`\* (1 \- mute)\`.  
5\. \*\*Execution Order (CRITICAL TRAP)\*\*: Define \`\~synthGroup \= Group.new(s);\`, \`\~fxGroup \= Group.after(\~synthGroup);\`, \`\~masterGroup \= Group.after(\~fxGroup);\`. When instantiating effect Synths inside \`\~fxGroup\` or \`\~masterGroup\`, you MUST include \`addAction: \\addToTail\`.  
6\. \*\*Multitimbral Polyphony & Boolean Traps\*\*:   
   \- Initialize \`\~notes \= Array.newClear(128);\`. Track overlapping notes using arrays of synths: \`\~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(...))\`. On \`noteOff\`, iterate to release: \`\~notes\[noteNum\].do(\_.set(\\gate, 0))\`.  
   \- \*\*SYNTAX TRAP 1\*\*: Do NOT use \`.inRange\` on integers. Evaluate key ranges explicitly: \`if((noteNum \>= \~ccVals\[\\min1\]) and: { noteNum \<= \~ccVals\[\\max1\] })\`.  
7\. \*\*GUI Pagination & Variable Scoping (CRITICAL TRAPS)\*\*:   
   \- \*\*SYNTAX TRAP 2\*\*: In SuperCollider, ALL \`var\` declarations MUST be placed at the absolute top of their respective function blocks. Never declare a \`var\` after an action or assignment has taken place.  
   \- \*\*SYNTAX TRAP 3\*\*: Do NOT use bitwise operators (\`|\` or \`?\`) for boolean UI state logic. Use \`if(condition, trueVal, falseVal)\`.  
   \- \*\*SYNTAX TRAP 4\*\*: Do NOT use the \`labelBackground\` argument in \`setColors\`.  
   \- Build a \*\*Paginated Tab View\*\* using an array of \`Button\`s to toggle the \`.visible\` property of an array of \`CompositeView\` pages.   
   \- Global FX go in a static \`CompositeView\` at the bottom.  
   \- Include CC numbers in all UI labels (e.g., \`"Vol (CC 81)"\`). Size \`EZKnob\`s appropriately (e.g., \`80@95\`) to fit dense parameters.  
8\. \*\*GUI Threading\*\*: Wrap GUI generation in \`defer { ... }\`. NEVER use \`defer\` inside a \`MIDIdef.cc\`. Update \`\~ccVals\` in the \`MIDIdef\`, and create a \`Routine\` running at 20fps (\`0.05.wait\`) on the \`AppClock\` to poll \`\~ccVals\` and update widgets.

\# Example:  
// \==========================================  
// STEP 0: GLOBAL CONFIGURATION (CC MAP)  
// \==========================================  
(  
\~cc \= (  
    // Mixer (Vol, Pan, Mute)  
    vol1: 81, vol2: 82, vol3: 83, vol4: 84,  
    pan1: 85, pan2: 86, pan3: 87, pan4: 88,  
    mute1: 101, mute2: 102, mute3: 103, mute4: 104,

    // Key Ranges (Min / Max)  
    min1: 105, max1: 109,  
    min2: 106, max2: 110,  
    min3: 107, max3: 111,  
    min4: 108, max4: 112,

    // Filters (LPF, Res, HPF)  
    lpf1: 89, lpf2: 90, lpf3: 91, lpf4: 92,  
    rq1: 93, rq2: 94, rq3: 95, rq4: 96,  
    hpf1: 97, hpf2: 98, hpf3: 99, hpf4: 100,

    // ADSR Envelopes (Atk, Dec, Sus, Rls)  
    atk1: 20, dec1: 21, sus1: 22, rls1: 23,  
    atk2: 24, dec2: 25, sus2: 26, rls2: 27,  
    atk3: 28, dec3: 29, sus3: 30, rls3: 31,  
    atk4: 40, dec4: 41, sus4: 42, rls4: 43,

    // Zone Specific Mods & Unique FX  
    ironDecay: 72, folLfoRate: 73, folLfoDepth: 74,  
    drive1: 32, inharm2: 33, chorus3: 34, combDec4: 35,

    // Global FX  
    tremRate: 75, tremDepth: 76, verbMix: 77, verbDecay: 78  
);  
)

// \==========================================  
// STEP 1 & 2: DISCOVERY & CONNECTION  
// \==========================================  
(  
MIDIClient.init;  
\~myInDevice \= MIDIClient.sources.detect { |src| src.device \== "loopMIDI Port" };

if(\~myInDevice.notNil) {  
    MIDIIn.connect(0, \~myInDevice);  
    "MIDI IN connected successfully to: ".post; \~myInDevice.device.postln;  
    \~myUid \= \~myInDevice.uid;  
} {  
    "Warning: MIDI IN device not found\! Listening to all ports...".warn;  
    \~myUid \= nil;  
};  
)

// \==========================================  
// STEP 3: AUDIO SERVER, ROUTING & SYNTHESIS  
// \==========================================  
(  
s.options.memSize \= 65536;  
s.boot;

s.waitForBoot({

    // A. BUFFERS  
    \~wtBuf \= Buffer.alloc(s, 2048, 1);  
    s.sync;  
    \~wtBuf.sine1(\[1, 0.6, 0.3, 0.15, 0.08, 0.04\], true, true, true);  
    s.sync;

    // B. CONTROL BUSES & STATE DICTIONARY  
    \~ccVals \= (  
        // Adjusted volumes for better initial mix  
        vol1: 0.3, vol2: 0.02, vol3: 0.3, vol4: 0.3,  
        pan1: \-0.75, pan2: \-0.25, pan3: 0.25, pan4: 0.75,  
        mute1: 0.0, mute2: 0.0, mute3: 0.0, mute4: 0.0,

        // Split Ranges  
        min1: 0, max1: 47,  
        min2: 48, max2: 64,  
        min3: 65, max3: 80,  
        min4: 81, max4: 127,

        lpf1: 1500, lpf2: 15000, lpf3: 8000, lpf4: 15000,  
        rq1: 1.0, rq2: 1.0, rq3: 1.0, rq4: 1.0,  
        hpf1: 20, hpf2: 100, hpf3: 150, hpf4: 300,

        // ADSR Defaults  
        atk1: 0.8, dec1: 1.0, sus1: 1.0, rls1: 1.5,  
        atk2: 0.01, dec2: 1.0, sus2: 1.0, rls2: 1.0,  
        atk3: 1.2, dec3: 1.0, sus3: 1.0, rls3: 2.0,  
        atk4: 0.05, dec4: 1.0, sus4: 1.0, rls4: 1.5,

        // Specific Mods & Unique FX  
        ironDecay: 0.5, folLfoRate: 2.0, folLfoDepth: 0.0,  
        drive1: 1.5, inharm2: 1.0, chorus3: 0.005, combDec4: 0.6,

        // Global FX  
        tremRate: 5.0, tremDepth: 0.0, verbMix: 0.0, verbDecay: 0.6  
    );

    \~buses \= ();  
    \~ccVals.keysValuesDo { |key, val| \~buses\[key\] \= Bus.control(s, 1).set(val) };

    // C. AUDIO ROUTING  
    \~synthGroup \= Group.new(s);  
    \~fxGroup \= Group.after(\~synthGroup);  
    \~masterGroup \= Group.after(\~fxGroup);

    \~groupBus \= Bus.audio(s, 2);  
    \~reverbBus \= Bus.audio(s, 2);  
    \~masterBus \= Bus.audio(s, 2);

    // D. SYNTHDEFS  
    SynthDef(\\fx\_GroupTremolo, { |in, out, rateBus, depthBus|  
        var sig \= In.ar(in, 2);  
        var mod \= SinOsc.kr(In.kr(rateBus)).range(1.0 \- In.kr(depthBus), 1.0);  
        Out.ar(out, sig \* mod);  
    }).add;

    SynthDef(\\fx\_GroupReverb, { |in, out, mixBus, decayBus|  
        var sig \= In.ar(in, 2);  
        Out.ar(out, FreeVerb2.ar(sig\[0\], sig\[1\], In.kr(mixBus), In.kr(decayBus), 0.2));  
    }).add;

    SynthDef(\\fx\_Master, { |in, out=0|  
        var sig \= Limiter.ar(LPF.ar(In.ar(in, 2), 14000), 0.95, 0.01);  
        Out.ar(out, sig);  
    }).add;

    // ZONE 1: Deep Earth (Unique FX: Drive Saturation)  
    SynthDef(\\zone1\_Earth, { arg out=0, freq=65.41, gate=1, vel=0.8, zoneVol=0.25, pan=0, mute=0, lpf=1500, rq=1, hpf=20, atk=0.8, dec=1.0, sus=1.0, rls=1.5, drive=1.5;  
        var lagFreq \= Lag.kr(freq, 0.3);  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var sig \= Pulse.ar(\[lagFreq \* 0.99, lagFreq \* 1.01\], 0.5) \* 0.3;  
        sig \= sig \+ (SinOsc.ar(lagFreq \* 0.5) \* 0.8 \* vel.pow(2));  
        sig \= RLPF.ar(HPF.ar(sig, hpf), lpf, rq);  
        // Drive applied before tanh limiter for saturation  
        Out.ar(out, Balance2.ar(sig\[0\], sig\[1\], pan, env \* zoneVol \* (1 \- mute) \* (sig \* drive).tanh \* 1.5));  
    }).add;

    // ZONE 2: Cast Iron (Unique FX: Inharmonicity)  
    SynthDef(\\zone2\_Iron, { arg out=0, freq=261.6, gate=1, vel=0.8, decay=0.5, zoneVol=0.25, pan=0, mute=0, lpf=15000, rq=1, hpf=100, atk=0.01, dec=1.0, sus=1.0, rls=1.0, inharm=1.0;  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var exciter \= WhiteNoise.ar \* (EnvGen.ar(Env.perc(0.001, 0.05)) \+ env);  
        var rings \= \[1.0, 0.8, 0.6, 0.4, 0.2\] \* decay.linlin(0, 1, 0.1, 4.0) \* vel.linlin(0.01, 1.0, 0.2, 1.5);  
        // Inharm multiplier stretches the upper partials out of tune  
        var freqs \= \[1, 2.76 \* inharm, 5.4 \* inharm, 8.9 \* inharm, 13.3 \* inharm\] \* freq;  
        var sig \= DynKlank.ar(\`\[freqs, \[1.0, 0.6, 0.3, 0.15, 0.05\], rings\], exciter);  
        sig \= sig \+ CombC.ar(sig, 0.1, 0.02, 0.4, 0.3);  
        Out.ar(out, Pan2.ar(RLPF.ar(HPF.ar(sig, hpf), lpf, rq), pan, env \* vel \* zoneVol \* (1 \- mute)));  
    }).add;

    // ZONE 3: Foliage Pad (Unique FX: Chorus Spread)  
    SynthDef(\\zone3\_Foliage, { arg out=0, freq=523.25, gate=1, vel=0.8, rate=2.0, depth=0.0, bufnum, zoneVol=0.25, pan=0, mute=0, lpf=8000, rq=1, hpf=150, atk=1.2, dec=1.0, sus=1.0, rls=2.0, chorus=0.005;  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        // Chorus determines the tuning offset of the stereo wavetable  
        var sig \= COsc.ar(bufnum, freq \* \[1.0 \- chorus, 1.0 \+ chorus\] \* SinOsc.kr(rate).range(1.0 \- depth, 1.0 \+ depth), 1.0);  
        sig \= sig \+ DelayC.ar(sig, 0.05, SinOsc.kr(0.3).range(0.015, 0.025), 0.6);  
        Out.ar(out, Balance2.ar(sig\[0\], sig\[1\], pan, env \* 0.4 \* zoneVol \* (1 \- mute)));  
    }).add;

    // ZONE 4: Sparkling Glass (Unique FX: Comb Decay Time)  
    SynthDef(\\zone4\_Glass, { arg out=0, freq=1046.5, gate=1, vel=0.8, zoneVol=0.25, pan=0, mute=0, lpf=15000, rq=1, hpf=300, atk=0.05, dec=1.0, sus=1.0, rls=1.5, combDec=0.6;  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var sig \= Resonz.ar(PinkNoise.ar, freq \* \[1, 2.01, 3.05\] \* EnvGen.kr(Env(\[2.5, 1.0\], \[0.08\], \\exp)), 0.005).sum;  
        // CombDec allows the metallic ringing echo to be shortened or vastly extended  
        sig \= sig \+ CombL.ar(sig, 0.2, 0.04, combDec, 0.6);  
        Out.ar(out, Pan2.ar(RLPF.ar(HPF.ar(sig, hpf), lpf, rq), pan, env \* vel \* zoneVol \* 25.0 \* (1 \- mute)));  
    }).add;

    s.sync;

    // E. INSTANTIATE EFFECTS  
    \~tremoloFx \= Synth(\\fx\_GroupTremolo, \[\\in, \~groupBus, \\out, \~reverbBus, \\rateBus, \~buses.tremRate, \\depthBus, \~buses.tremDepth\], \~fxGroup, \\addToTail);  
    \~reverbFx \= Synth(\\fx\_GroupReverb, \[\\in, \~reverbBus, \\out, \~masterBus, \\mixBus, \~buses.verbMix, \\decayBus, \~buses.verbDecay\], \~fxGroup, \\addToTail);  
    \~masterFx \= Synth(\\fx\_Master, \[\\in, \~masterBus, \\out, 0\], \~masterGroup, \\addToTail);

    // F. SYNTH STATE & MIDI  
    \~notes \= Array.newClear(128);

    MIDIdef.cc(\\globalCC, { |val, num|  
        var mapped \= val / 127.0;  
        \~cc.keysValuesDo { |key, ccNum|  
            if(num \== ccNum) {  
                var kStr \= key.asString;  
                var finalVal \= case  
                    { kStr.matchRegexp("lpf|hpf") } { mapped.linexp(0, 1, 20, 20000\) }  
                    { kStr.contains("rq") } { mapped.linexp(0, 1, 1.0, 0.05) }  
                    { kStr.contains("pan") } { mapped.linlin(0, 1, \-1.0, 1.0) }  
                    { kStr.matchRegexp("atk|dec|rls") } { mapped.linexp(0, 1, 0.01, 10.0) }  
                    { kStr.matchRegexp("min|max") } { val }  
                    { kStr.contains("mute") } { (val \> 63).asInteger }  
                    { key \== \\folLfoRate } { mapped.linlin(0, 1, 0.1, 10\) }  
                    { key \== \\tremRate } { mapped.linlin(0, 1, 0.1, 15\) }  
                    { key \== \\drive1 } { mapped.linexp(0, 1, 1.0, 15.0) }  
                    { key \== \\inharm2 } { mapped.linlin(0, 1, 1.0, 2.0) }  
                    { key \== \\chorus3 } { mapped.linexp(0, 1, 0.001, 0.05) }  
                    { key \== \\combDec4 } { mapped.linexp(0, 1, 0.1, 5.0) }  
                    { mapped };

                \~ccVals\[key\] \= finalVal;  
                if(\~buses\[key\].notNil) { \~buses\[key\].set(finalVal) };  
            };  
        };  
    }, srcID: \~myUid);

    MIDIdef.noteOn(\\palmHouseOn, { |velRaw, noteNum|  
        var freq \= noteNum.midicps;  
        var vel \= velRaw / 127.0;

        if(\~notes\[noteNum\].notNil) { \~notes\[noteNum\].do(\_.set(\\gate, 0)) };  
        \~notes\[noteNum\] \= \[\];

        if((noteNum \>= \~ccVals\[\\min1\]) and: { noteNum \<= \~ccVals\[\\max1\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone1\_Earth, \[  
                \\out, \~masterBus, \\freq, freq, \\vel, vel, \\gate, 1, \\drive, \~buses.drive1.asMap,  
                \\zoneVol, \~buses.vol1.asMap, \\pan, \~buses.pan1.asMap, \\mute, \~buses.mute1.asMap,  
                \\lpf, \~buses.lpf1.asMap, \\rq, \~buses.rq1.asMap, \\hpf, \~buses.hpf1.asMap,  
                \\atk, \~buses.atk1.asMap, \\dec, \~buses.dec1.asMap, \\sus, \~buses.sus1.asMap, \\rls, \~buses.rls1.asMap  
            \], target: \~synthGroup));  
        };

        if((noteNum \>= \~ccVals\[\\min2\]) and: { noteNum \<= \~ccVals\[\\max2\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone2\_Iron, \[  
                \\out, \~groupBus, \\freq, freq, \\vel, vel, \\gate, 1, \\decay, \~buses.ironDecay.asMap, \\inharm, \~buses.inharm2.asMap,  
                \\zoneVol, \~buses.vol2.asMap, \\pan, \~buses.pan2.asMap, \\mute, \~buses.mute2.asMap,  
                \\lpf, \~buses.lpf2.asMap, \\rq, \~buses.rq2.asMap, \\hpf, \~buses.hpf2.asMap,  
                \\atk, \~buses.atk2.asMap, \\dec, \~buses.dec2.asMap, \\sus, \~buses.sus2.asMap, \\rls, \~buses.rls2.asMap  
            \], target: \~synthGroup));  
        };

        if((noteNum \>= \~ccVals\[\\min3\]) and: { noteNum \<= \~ccVals\[\\max3\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone3\_Foliage, \[  
                \\out, \~groupBus, \\freq, freq, \\vel, vel, \\gate, 1, \\bufnum, \~wtBuf, \\chorus, \~buses.chorus3.asMap,  
                \\rate, \~buses.folLfoRate.asMap, \\depth, \~buses.folLfoDepth.asMap,  
                \\zoneVol, \~buses.vol3.asMap, \\pan, \~buses.pan3.asMap, \\mute, \~buses.mute3.asMap,  
                \\lpf, \~buses.lpf3.asMap, \\rq, \~buses.rq3.asMap, \\hpf, \~buses.hpf3.asMap,  
                \\atk, \~buses.atk3.asMap, \\dec, \~buses.dec3.asMap, \\sus, \~buses.sus3.asMap, \\rls, \~buses.rls3.asMap  
            \], target: \~synthGroup));  
        };

        if((noteNum \>= \~ccVals\[\\min4\]) and: { noteNum \<= \~ccVals\[\\max4\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone4\_Glass, \[  
                \\out, \~groupBus, \\freq, freq, \\vel, vel, \\gate, 1, \\combDec, \~buses.combDec4.asMap,  
                \\zoneVol, \~buses.vol4.asMap, \\pan, \~buses.pan4.asMap, \\mute, \~buses.mute4.asMap,  
                \\lpf, \~buses.lpf4.asMap, \\rq, \~buses.rq4.asMap, \\hpf, \~buses.hpf4.asMap,  
                \\atk, \~buses.atk4.asMap, \\dec, \~buses.dec4.asMap, \\sus, \~buses.sus4.asMap, \\rls, \~buses.rls4.asMap  
            \], target: \~synthGroup));  
        };  
    }, srcID: \~myUid);

    MIDIdef.noteOff(\\palmHouseOff, { |vel, noteNum|  
        if(\~notes\[noteNum\].notNil) {  
            \~notes\[noteNum\].do(\_.set(\\gate, 0));  
            \~notes\[noteNum\] \= nil;  
        };  
    }, srcID: \~myUid);

    "Palm House V4.4 Engine Initialized.".postln;  
});  
)

// \==========================================  
// STEP 4: ADVANCED UI (New FX & Sized Knobs)  
// \==========================================  
(  
defer {  
    var makeZone, switchTab;  
    var pages \= Array.newClear(4);  
    var tabButtons \= Array.newClear(4);

    if(\~palmWin.notNil and: { \~palmWin.isClosed.not }) { \~palmWin.close };  
    \~ui \= ();

    \~palmWin \= Window("Palm House Conservatory Control V4.4", Rect(100, 100, 460, 800));  
    \~palmWin.view.background \= Color.fromHexString("\#1E2A22");

    \~tabContainer \= CompositeView(\~palmWin, Rect(15, 15, 430, 40)).decorator\_(FlowLayout(Rect(0,0,430,40), 0@0, 10@0));  
    \~pagesContainer \= CompositeView(\~palmWin, Rect(15, 65, 430, 540));  
    \~fxContainer \= CompositeView(\~palmWin, Rect(15, 615, 430, 160));

    // \--- 1\. TAB CONTROLS \---  
    switchTab \= { |idx|  
        pages.do { |p, i| if(p.notNil) { p.visible \= (i \== idx) } };  
        tabButtons.do { |b, i|  
            var textColor \= if(i \== idx, Color.black, Color.white);  
            var bgColor \= if(i \== idx, Color.cyan, Color.gray(0.3));  
            b.states\_(\[\[b.states\[0\]\[0\], textColor, bgColor\]\]);  
        };  
    };

    \["EARTH", "IRON", "FOLIAGE", "GLASS"\].do { |name, i|  
        tabButtons\[i\] \= Button(\~tabContainer, 95@35).states\_(\[\[name, Color.white, Color.gray(0.3)\]\]).action\_({ switchTab.value(i) });  
    };

    // \--- 2\. PAGINATED ZONE BUILDER \---  
    makeZone \= { |name, idx, pageIndex, extraKnobs|  
        var box, pref, kSize;  
        var mKey, minKey, maxKey, vKey, pKey, hKey, lKey, rKey, aKey, dKey, sKey, rlsKey;  
        var rLabel, vLabel;

        pref \= idx.asString;  
        kSize \= 80@95; // Sweet spot: slightly smaller to fit third row comfortably

        box \= CompositeView(\~pagesContainer, \~pagesContainer.bounds.moveTo(0,0));  
        box.background\_(Color.gray(0.12, 0.8)).decorator\_(FlowLayout(box.bounds, 15@15, 12@10)).visible\_(false);  
        pages\[pageIndex\] \= box;

        mKey \= ("mute"++pref).asSymbol;  
        minKey \= ("min"++pref).asSymbol;  
        maxKey \= ("max"++pref).asSymbol;  
        vKey \= ("vol"++pref).asSymbol;  
        pKey \= ("pan"++pref).asSymbol;  
        hKey \= ("hpf"++pref).asSymbol;  
        lKey \= ("lpf"++pref).asSymbol;  
        rKey \= ("rq"++pref).asSymbol;  
        aKey \= ("atk"++pref).asSymbol;  
        dKey \= ("dec"++pref).asSymbol;  
        sKey \= ("sus"++pref).asSymbol;  
        rlsKey \= ("rls"++pref).asSymbol;

        // Header & Mute  
        StaticText(box, 230@30).string\_("ZONE " \++ pref \++ ": " \++ name).stringColor\_(Color.cyan).font\_(Font("Arial", 16, true));  
        \~ui\[mKey\] \= Button(box, 140@30).states\_(\[  
            \["ACTIVE (CC " \++ \~cc\[mKey\] \++ ")", Color.white, Color.new255(60, 60, 60)\],  
            \["MUTED (CC " \++ \~cc\[mKey\] \++ ")", Color.white, Color.red(0.6)\]  
        \]).action\_({ |b| \~buses\[mKey\].set(b.value); \~ccVals\[mKey\] \= b.value; });

        // Horizontal Mix & Mapping  
        rLabel \= "Keys (CC" \++ \~cc\[minKey\] \++ "/" \++ \~cc\[maxKey\] \++ ")";  
        \~ui\[("range"++pref).asSymbol\] \= EZRanger(box, 390@35, rLabel, \[0, 127, \\lin, 1, 0\], { |sl|  
            \~ccVals\[minKey\] \= sl.value\[0\]; \~ccVals\[maxKey\] \= sl.value\[1\];  
        }, \[\~ccVals\[minKey\], \~ccVals\[maxKey\]\], labelWidth: 100).setColors(stringColor: Color.white);

        vLabel \= "Vol (CC" \++ \~cc\[vKey\] \++ ")";  
        \~ui\[vKey\] \= EZSlider(box, 390@35, vLabel, \\amp, { |sl| \~buses\[vKey\].set(sl.value); \~ccVals\[vKey\] \= sl.value; }, \~ccVals\[vKey\], labelWidth: 80).setColors(stringColor: Color.white);

        StaticText(box, 390@8).background\_(Color.gray(0.3)); // Divider

        // Filters  
        \~ui\[pKey\] \= EZKnob(box, kSize, "Pan " \++ \~cc\[pKey\], \\bipolar, { |kn| \~buses\[pKey\].set(kn.value); \~ccVals\[pKey\] \= kn.value; }, \~ccVals\[pKey\]).setColors(stringColor: Color.white);  
        \~ui\[hKey\] \= EZKnob(box, kSize, "HPF " \++ \~cc\[hKey\], ControlSpec(20, 20000, \\exp), { |kn| \~buses\[hKey\].set(kn.value); \~ccVals\[hKey\] \= kn.value; }, \~ccVals\[hKey\]).setColors(stringColor: Color.white);  
        \~ui\[lKey\] \= EZKnob(box, kSize, "LPF " \++ \~cc\[lKey\], ControlSpec(20, 20000, \\exp), { |kn| \~buses\[lKey\].set(kn.value); \~ccVals\[lKey\] \= kn.value; }, \~ccVals\[lKey\]).setColors(stringColor: Color.white);  
        \~ui\[rKey\] \= EZKnob(box, kSize, "Res " \++ \~cc\[rKey\], ControlSpec(1.0, 0.05, \\exp), { |kn| \~buses\[rKey\].set(kn.value); \~ccVals\[rKey\] \= kn.value; }, \~ccVals\[rKey\]).setColors(stringColor: Color.white);

        // Envelopes  
        \~ui\[aKey\] \= EZKnob(box, kSize, "Atk " \++ \~cc\[aKey\], ControlSpec(0.01, 10.0, \\exp), { |kn| \~buses\[aKey\].set(kn.value); \~ccVals\[aKey\] \= kn.value; }, \~ccVals\[aKey\]).setColors(stringColor: Color.green(0.8));  
        \~ui\[dKey\] \= EZKnob(box, kSize, "Dec " \++ \~cc\[dKey\], ControlSpec(0.01, 10.0, \\exp), { |kn| \~buses\[dKey\].set(kn.value); \~ccVals\[dKey\] \= kn.value; }, \~ccVals\[dKey\]).setColors(stringColor: Color.green(0.8));  
        \~ui\[sKey\] \= EZKnob(box, kSize, "Sus " \++ \~cc\[sKey\], \\amp, { |kn| \~buses\[sKey\].set(kn.value); \~ccVals\[sKey\] \= kn.value; }, \~ccVals\[sKey\]).setColors(stringColor: Color.green(0.8));  
        \~ui\[rlsKey\] \= EZKnob(box, kSize, "Rls " \++ \~cc\[rlsKey\], ControlSpec(0.01, 10.0, \\exp), { |kn| \~buses\[rlsKey\].set(kn.value); \~ccVals\[rlsKey\] \= kn.value; }, \~ccVals\[rlsKey\]).setColors(stringColor: Color.green(0.8));

        extraKnobs.value(box, kSize);  
    };

    // Inject unique UI controls  
    makeZone.value("DEEP EARTH", 1, 0, { |box, kSize|  
        \~ui\[\\drive1\] \= EZKnob(box, kSize, "Drive " \++ \~cc\[\\drive1\], ControlSpec(1.0, 15.0, \\exp), { |kn| \~buses.drive1.set(kn.value); \~ccVals\[\\drive1\] \= kn.value; }, \~ccVals\[\\drive1\]).setColors(stringColor: Color.cyan);  
    });

    makeZone.value("CAST IRON", 2, 1, { |box, kSize|  
        \~ui\[\\ironDecay\] \= EZKnob(box, kSize, "DecMod " \++ \~cc\[\\ironDecay\], \\amp, { |kn| \~buses.ironDecay.set(kn.value); \~ccVals\[\\ironDecay\] \= kn.value; }, \~ccVals\[\\ironDecay\]).setColors(stringColor: Color.yellow);  
        \~ui\[\\inharm2\] \= EZKnob(box, kSize, "Inharm " \++ \~cc\[\\inharm2\], ControlSpec(1.0, 2.0, \\lin), { |kn| \~buses.inharm2.set(kn.value); \~ccVals\[\\inharm2\] \= kn.value; }, \~ccVals\[\\inharm2\]).setColors(stringColor: Color.cyan);  
    });

    makeZone.value("FOLIAGE PAD", 3, 2, { |box, kSize|  
        \~ui\[\\folLfoRate\] \= EZKnob(box, kSize, "LFOHz " \++ \~cc\[\\folLfoRate\], ControlSpec(0.1, 10, \\exp), { |kn| \~buses.folLfoRate.set(kn.value); \~ccVals\[\\folLfoRate\] \= kn.value; }, \~ccVals\[\\folLfoRate\]).setColors(stringColor: Color.yellow);  
        \~ui\[\\folLfoDepth\] \= EZKnob(box, kSize, "LFODep " \++ \~cc\[\\folLfoDepth\], \\amp, { |kn| \~buses.folLfoDepth.set(kn.value); \~ccVals\[\\folLfoDepth\] \= kn.value; }, \~ccVals\[\\folLfoDepth\]).setColors(stringColor: Color.yellow);  
        \~ui\[\\chorus3\] \= EZKnob(box, kSize, "Chorus " \++ \~cc\[\\chorus3\], ControlSpec(0.001, 0.05, \\exp), { |kn| \~buses.chorus3.set(kn.value); \~ccVals\[\\chorus3\] \= kn.value; }, \~ccVals\[\\chorus3\]).setColors(stringColor: Color.cyan);  
    });

    makeZone.value("SPARKLING GLASS", 4, 3, { |box, kSize|  
        \~ui\[\\combDec4\] \= EZKnob(box, kSize, "CmbDec " \++ \~cc\[\\combDec4\], ControlSpec(0.1, 5.0, \\exp), { |kn| \~buses.combDec4.set(kn.value); \~ccVals\[\\combDec4\] \= kn.value; }, \~ccVals\[\\combDec4\]).setColors(stringColor: Color.cyan);  
    });

    switchTab.value(0);

    // \--- 3\. BOTTOM: GLOBAL FX \---  
    \~fxContainer.background\_(Color.gray(0.1, 0.4)).decorator\_(FlowLayout(Rect(0,0,430,160), 15@15, 10@10));  
    StaticText(\~fxContainer, 400@20).string\_("GLOBAL GROUP EFFECTS").stringColor\_(Color.cyan).font\_(Font("Arial", 14, true)).align\_(\\center);

    \~ui\[\\tremRate\] \= EZSlider(\~fxContainer, 190@40, "Trem Hz (CC" \++ \~cc\[\\tremRate\] \++ ")", ControlSpec(0.1, 15.0, \\exp), { |sl| \~buses.tremRate.set(sl.value); \~ccVals\[\\tremRate\] \= sl.value; }, \~ccVals\[\\tremRate\], labelWidth: 105).setColors(stringColor: Color.white);  
    \~ui\[\\verbMix\] \= EZSlider(\~fxContainer, 190@40, "Verb Mix (CC" \++ \~cc\[\\verbMix\] \++ ")", \\amp, { |sl| \~buses.verbMix.set(sl.value); \~ccVals\[\\verbMix\] \= sl.value; }, \~ccVals\[\\verbMix\], labelWidth: 105).setColors(stringColor: Color.white);  
    \~ui\[\\tremDepth\] \= EZSlider(\~fxContainer, 190@40, "Trem Dep (CC" \++ \~cc\[\\tremDepth\] \++ ")", \\amp, { |sl| \~buses.tremDepth.set(sl.value); \~ccVals\[\\tremDepth\] \= sl.value; }, \~ccVals\[\\tremDepth\], labelWidth: 105).setColors(stringColor: Color.white);  
    \~ui\[\\verbDecay\] \= EZSlider(\~fxContainer, 190@40, "Verb Dec (CC" \++ \~cc\[\\verbDecay\] \++ ")", \\amp, { |sl| \~buses.verbDecay.set(sl.value); \~ccVals\[\\verbDecay\] \= sl.value; }, \~ccVals\[\\verbDecay\], labelWidth: 105).setColors(stringColor: Color.white);

    \~palmWin.front;

    // \--- 4\. DATA POLLING \---  
    \~guiRoutine \= Routine({  
        loop {  
            \~ui.keysValuesDo { |key, widget|  
                var pref;  
                if(widget.notNil) {  
                    if(key.asString.contains("range")) {  
                        pref \= key.asString.last.asString;  
                        widget.value \= \[\~ccVals\[("min"++pref).asSymbol\], \~ccVals\[("max"++pref).asSymbol\]\];  
                    } {  
                        widget.value \= \~ccVals\[key\];  
                    };  
                };  
            };  
            0.05.wait;  
        }  
    }).play(AppClock);

    \~palmWin.onClose \= {  
        \~guiRoutine.stop; \~palmWin \= nil; \~ui \= nil;  
        "GUI Closed.".postln;  
    };  
};  
)

// \==========================================  
// STEP 5: CLEANUP  
// \==========================================  
(  
if(\~palmWin.notNil and: { \~palmWin.isClosed.not }) { \~palmWin.close };  
if(\~guiRoutine.notNil) { \~guiRoutine.stop };

MIDIdef.freeAll;

if(\~notes.notNil) {  
    \~notes.do({ |arr| if(arr.notNil) { arr.do(\_.set(\\gate, 0)) } });  
    \~notes \= nil;  
};

\~tremoloFx.free; \~reverbFx.free; \~masterFx.free;  
\~buses.keysValuesDo { |key, bus| bus.free };  
\~groupBus.free; \~reverbBus.free; \~masterBus.free;  
\~synthGroup.free; \~fxGroup.free; \~masterGroup.free;

if(\~wtBuf.notNil) { \~wtBuf.free };

"Palm House cleanup complete.".postln;  
)

**\=== ADDITIONAL INSTRUCTION \===**

**\#\#\# Entry \[2026-03-16 19:03\] (Auto Fix)**  
**\*\*LESSON:\*\***

Do not apply \`Collection\` methods like \`.flat\` directly to SuperCollider \`Pattern\` objects (e.g., \`Pn\`, \`Pseq\`). Patterns generate a flattened stream of values by design; when patterns contain other patterns (like \`Pwhite\` inside \`Pseq\`), the outer pattern evaluates the inner ones and yields their values directly, not nested structures requiring \`flat\`.

\#\#\# Entry \[2026-03-16 19:05\] (User Feedback)  
LESSON: Be cautious with or avoid distortion effects, as the previous implementation was not well-received; prioritize clean sinewave generation.

\#\#\# Entry \[2026-03-20 12:06\] (External Fix — Incremental Block 2\)  
LESSON: To avoid \`DynKlank\` \`Message 'at' not understood\` errors and incorrect argument warnings:  
1\.  \*\*\`specificationsArrayRef\` Format:\*\* The \`specificationsArrayRef\` argument \*must\* be a \`Ref\` to an array containing exactly three sub-arrays: \`\#\[all\_frequencies\_array, all\_amplitudes\_array, all\_ring\_times\_array\]\`. It does \*not\* accept an array of \`\[freq, amp, ring\_time\]\` tuples.  
2\.  \*\*Argument Naming:\*\* \`DynKlank\` does not have \`rq\` or \`decay\` arguments. Use \`decayscale\` as a global multiplier for the ring times specified within the \`specificationsArrayRef\`. Individual resonance quality is controlled by the \`ring\_times\` values themselves.

\#\#\# Entry \[2026-03-20 12:10\] (User Feedback — Incremental Session)  
LESSON: Improve \`dynklang\` generation quality to reduce the need for external correction, and enhance understanding of setup instructions to ensure the correct number of instruments are generated.

Pattern Streaming: Never apply array methods like .flat to Pattern objects (e.g., Pn, Pseq). Patterns inherently yield flattened streams; outer patterns evaluate inner patterns directly without needing structural flattening.

Timbre Preferences: Avoid distortion effects entirely. Prioritize clean, precise synthesis (e.g., pure sinewaves).

DynKlank Architecture: DynKlank requires strict array formatting and specific arguments:

Array Formatting: The parameter array must be wrapped in a Ref (\`) and contain exactly three distinct sub-arrays: \[\[all\_freqs\], \[all\_amps\], \[all\_ring\_times\]\]. It will fail if passed an array of parameter tuples.

Arguments: Do not use rq or decay. Use decayscale as the global multiplier for the ring times defined in your array.

\#\#\# Entry \[2026-03-23 14:01\] (User Feedback)  
LESSON: Improve sound quality and aesthetics of generated SuperCollider code.

\#\#\# Entry \[2026-03-23 15:19\] (System Correction)  
LESSON: When implementing a Karplus-Strong plucked string model, do not use K2A.ar as the audio source. K2A converts a scalar value into a static DC audio offset; applying a percussive envelope to this simply produces an unpitched transient (a click).

Instead, use Pluck.ar, which accurately models string physics using three core components:

Excitation (in): Requires a short, enveloped burst of broad-spectrum noise (like WhiteNoise.ar) to act as the physical strike or pluck that initiates the feedback loop.

Pitch (delaytime): The pitch is determined by the length of the delay line. This must be set to 1/freq to establish the correct fundamental frequency.

Material Damping (coef): Controls the internal low-pass filter to simulate high-frequency energy loss. A value near 0 leaves the sound bright and metallic, while a value closer to 1 heavily dampens the highs. For intuitive live coding, map this as 1 \- bright.

\#\#\#Entry \[2026-03-23 17:05\] (System Improvement)  
LESSON: When combining Pbindef sequences with Ndef.set live coding tweaks, do not hard-set a parameter (like \\freq) via .set if it is already being sequenced by a pattern. Doing so immediately overrides and severs the pattern's control stream.

To globally shift or modify a running sequence without destroying the melodic line, explicitly separate your sequence data from your global offsets using one of three strategies:

Pattern Math: Apply mathematical operations directly within the Pbindef (e.g., \\freq, Pn(...) \* 1.5 or \+ 500\) to keep all control within the pattern ecosystem.

Event Architecture: Sequence higher-level pitch keys like \\midinote or \\degree in your pattern. This frees up built-in global modifiers like \\ctranspose to be safely manipulated via Ndef.set without breaking the sequence.

Dedicated Modifiers: Build custom offset or multiplier arguments into the actual instrument definition (e.g., adding a freqMult argument to the Ndef). Use the pattern exclusively for the base \\freq, and reserve Ndef.set(\\freqMult, ...) strictly for global live tweaks.

\#\#\# Entry \[2026-03-24 11:59\] (User Feedback)  
LESSON: Improve accuracy and reduce "little mistakes" in SuperCollider code generation.

\#\#\# Entry \[2026-03-25 11:58\] (Auto Fix)  
\*\*LESSON:\*\* In SuperCollider, use a standard array literal \`\[...\]\` when an array needs to contain values derived from dynamic calculations or variables (e.g., \`freq\*1.5\`). The 'literal array' or 'quoted array' syntax \`\#\[...\]\` is for arrays of static, non-evaluated literals and will cause a syntax error if expressions requiring computation are included.

\#\#\# Entry \[2026-03-25 11:58\] (User Feedback)  
LESSON: Ensure volume relations are normalized and the generated code includes a defined ending.

\#\#\# Entry \[2026-03-26 20:25\] (Fix Tab)  
\*\*LESSON:\*\* Always verify the existence of a specific Unit Generator (UGen) class (e.g., \`Flanger.ar\`) in SuperCollider's library before attempting to use it. A 'Class not defined' error indicates the UGen does not exist, and the desired effect may need to be implemented using combinations of available primitive UGens (e.g., \`CombL.ar\` with modulation for flanging).

\#\#\# Entry \[2026-03-28 12:58\] (Fix Tab)  
LESSON: When defining default values for arguments in SuperCollider function/closure headers (\`|arg=default\_value|\`), always parenthesize negative numerical values. The parser can misinterpret a leading minus sign (\`-\`) as an unexpected binary operator, rather than part of the number literal, leading to a \`syntax error, unexpected BINOP\`.

\*\*Correct:\*\* \`|minPan=(-0.8)|\`  
\*\*Incorrect:\*\* \`|minPan=-0.8|\`

\#\#\# Entry \[2026-03-28 12:58\] (Fix Tab)  
\*\*Lesson:\*\* When constructing arrays within a SuperCollider SynthDef (or Ndef function) whose elements are or depend on UGens, use a regular Array literal \`\[...\]\` instead of a Literal Array \`\#\[...\]\`.

Literal Arrays (\`\#\[...\]\`) are strictly for compile-time constants and cannot contain or perform operations with UGens. Using them with UGens (e.g., \`\#\[1,2,3\] \* fund\`) results in a \`BinaryOpUGen\` representing the \*entire multiplication operation\* rather than an array of multiplied UGens, causing subsequent methods like \`.at\` to fail because they expect an array, not an operation. Regular Arrays (\`\[...\]\`) allow for runtime evaluation during SynthDef graph building, correctly creating dynamic UGen arrays (e.g., \`\[1,2,3\] \* fund\` becomes \`\[1\*fund, 2\*fund, 3\*fund\]\`) which are often required by UGen constructors like \`DynKlank\`.

\#\#\# Entry \[2026-04-01 12:22\] (Fix Tab \- Offline)  
The \`filter\` method for \`Ndef\` is an \*instance method\* that operates on a specific \`NodeProxy\`'s signal chain. It must be called on an \*instance\* of \`Ndef\` (e.g., \`Ndef(\\master)\`), not the \`Ndef\` \*class\* itself (\`Ndef\`). Calling an instance method on a class results in a \`Message '...' not understood\` error.

\*\*LESSON:\*\* Always call instance-specific methods (like \`filter\` on an \`Ndef\`) on the \*instance\* of the object (\`Ndef(\\name)\`), not on its \*class\* (\`Ndef\`).

\#\#\# Entry \[2026-04-01 12:23\] (Fix Tab \- Offline)  
\*\*LESSON:\*\*

The \`Ndef.filter(index, func)\` method in SuperCollider's JITLib is used to \*\*define a signal processing stage (a filter or effect) for a NodeProxy, expecting a \*function\* as its second argument (\`func\`)\*\*. This function describes how the effect transforms an input signal (\`|in|\`).

The error \`Message 'def' not understood\` occurs when you attempt to \*apply\* an already existing UGen (like \`sig\`, which is an \`OutputProxy\` representing the \`in\` argument within the \`Ndef\`'s function) directly as the \`func\` argument to \`Ndef.filter\` \*within\* another \`Ndef\`'s definition.

JITLib expects \`Ndef.filter\` to be provided with a \*definition\* (a function that describes the filter), not an already processed signal UGen. When given a UGen, it attempts to access a \`def\` method (which UGens do not have in this context) to resolve its definition, resulting in the error.

\*\*To avoid this:\*\*  
\*   The primary \`Ndef\` function (\`Ndef(\\name, { |in| ... })\`) should generate or process its core signal.  
\*   Separate effects should be \*\*defined independently\*\* using \`Ndef(\\name).filter(index, { |inputSig| ... filter code ... })\`. JITLib automatically chains these defined filters to the main signal.

\#\#\# Entry \[2026-04-14 12:21\] (Fix Tab \- Offline)  
\*\*LESSON:\*\* SuperCollider does not have a \`Pexprange\` class. To generate exponentially distributed random values within Patterns, use \`Pexprand\` (the exponential counterpart to \`Pwhite\`). Be careful not to confuse UGen range-mapping methods (like \`.exprange\`) with Pattern class names.  
\`\`\`

**\*\*Knowledge Base RAG Used:\*\***  
\`\`\`text  
\--- RETRIEVED 1 (knowledge-base: ndef-famous-synths.scd) \---  
var sig \= SinOsc.ar(\[freq, freq \* 1.01\]);

    // The Buchla sound: Fold.ar bounces the wave back on itself when it exceeds bounds  
    sig \= Fold.ar(sig \* foldDrive, \-0.8, 0.8);

    // Add a little spring-like reverb  
    sig \= FreeVerb.ar(sig, 0.3, 0.9, 0.1);  
    sig \* 0.3;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\buchlaDrone);  
)

// BUCHLA 3: Timbres & Squelches (Modulated Fold)  
(  
Ndef(\\buchlaSquish).fadeTime \= 0.5;  
Ndef(\\buchlaSquish, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(110);  
    var env \= EnvGen.kr(Env.perc(0.01, 0.6), t\_trig);  
    var foldEnv \= EnvGen.kr(Env.perc(0.1, 0.4), t\_trig);

    var sig \= LFTri.ar(freq);  
    sig \= Fold.ar(sig \* (1 \+ (foldEnv \* 4)), \-0.5, 0.5);

    sig \* env \* 0.4 \! 2;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\buchlaSquish);

Ndef(\\buchlaSquishSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\buchlaSquish).nodeID }), \\args, \#\[\\freq, \\t\_trig\],  
    \\freq, Pseq(\[110, 220, 165, 330\], inf), \\dur, 0.5, \\t\_trig, 1  
)).play;  
)

// BUCHLA 4: Uncertainty Arp (Randomized FM amounts)  
(  
Ndef(\\buchlaAlien).fadeTime \= 1;  
Ndef(\\buchlaAlien, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(440);  
    // Sample & Hold effect on FM index  
    var fmIndex \= TRand.kr(100, 2000, t\_trig);  
    var lpgEnv \= EnvGen.kr(Env.perc(0.005, 0.1, 1, \-4), t\_trig);

    var mod \= SinOsc.ar(freq \* 0.5) \* fmIndex;  
    var sig \= SinOsc.ar(freq \+ mod);

    sig \= LPF.ar(sig, 500 \+ (lpgEnv \* 6000)) \* lpgEnv;  
    sig \* 0.4 \! 2;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\buchlaAlien);

Ndef(\\buchlaAlienSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\buchlaAlien).nodeID }), \\args, \#\[\\freq, \\t\_trig\],  
    \\freq, Pexprand(200, 1000, inf), \\dur, 0.125, \\t\_trig, 1  
)).play;  
)

// \=============================================================================  
// 5\. ROLAND JUPITER-8 (Thick Polyphony, Cross-Mod, 24dB Filter)  
// \=============================================================================

// JUPITER 1: Cross-Modulation Lead (Audio-rate FM between VCOs)  
(  
Ndef(\\jpLead).fadeTime \= 0.5;  
Ndef(\\jpLead, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(220);  
    var xModDepth \= \\xmod.kr(300); // How hard Osc 2 pushes Osc 1

    var env \= EnvGen.kr(Env.perc(0.05, 0.8), t\_trig);

    var osc2 \= Saw.ar(freq \* 1.5); // Fixed interval for Osc 2  
    var osc1 \= Pulse.ar(freq \+ (osc2 \* xModDepth), 0.5);

    var sig \= Mix(\[osc1, osc2\]) \* 0.5;  
    sig \= MoogFF.ar(sig, 8000 \* env, 0.5); // Jupiter had a great 24dB filter

    sig \* env \* 0.4 \! 2;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\jpLead);

Ndef(\\jpLeadSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\jpLead).nodeID }), \\args, \#\[\\freq, \\t\_trig\],  
    \\scale, Scale.dorian, \\degree, Pseq(\[0, 2, 4, 7, 6, 4, 2, \-1\], inf),  
    \\dur, 0.25, \\t\_trig, 1  
)).play;  
)

// JUPITER 2: Lush String Pad (Detuned PWM)  
(  
Ndef(\\jpPad).fadeTime \= 3;  
Ndef(\\jpPad, {  
    var freq \= \\freq.kr(\[110, 110\]); // Array for chords  
    var lfo \= SinOsc.kr(0.4).range(0.1, 0.9);

    var osc1 \= Pulse.ar(freq, width: lfo);  
    var osc2 \= Saw.ar(freq \* 1.01);

    var sig \= Splay.ar(osc1 \+ osc2);  
    sig \= MoogFF.ar(sig, 2500, 0.2);

    // Classic Roland 80s chorus simulation  
    sig \= sig \+ DelayC.ar(sig, 0.05, SinOsc.kr(\[0.5, 0.6\]).range(0.01, 0.02));

    sig \* 0.3;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\jpPad);

Ndef(\\jpPadSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\jpPad).nodeID }), \\args, \#\[\\freq\],  
    \\midinote, Pseq(\[ \[\[55, 59, 62\]\], \[\[53, 57, 60\]\] \], inf), \\dur, 4  
)).play;  
)

// JUPITER 3: Sync Arp (Hard Sync with Envelope sweeping the Slave)  
(  
Ndef(\\jpSync).fadeTime \= 0.5;  
Ndef(\\jpSync, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(110);  
    var env \= EnvGen.kr(Env.perc(0.01, 0.5), t\_trig);  
    var sweepEnv \= EnvGen.kr(Env.perc(0.01, 0.3), t\_trig);

    var sig \= SyncSaw.ar(freq, freq \* (1 \+ (sweepEnv \* 4)));  
    sig \= MoogFF.ar(sig, 6000, 0.5);

    sig \* env \* 0.4 \! 2;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\jpSync);

\--- RETRIEVED 2 (knowledge-base: ndef-famous-synths.scd) \---  
var sig \= SyncSaw.ar(freq, freq \* (1 \+ (sweepEnv \* 4)));  
    sig \= MoogFF.ar(sig, 6000, 0.5);

    sig \* env \* 0.4 \! 2;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\jpSync);

Ndef(\\jpSyncSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\jpSync).nodeID }), \\args, \#\[\\freq, \\t\_trig\],  
    \\octave, Pseq(\[3, 4, 5, 4\], inf), \\degree, Pseq(\[0, 0, 0, 0\], inf),  
    \\dur, 0.125, \\t\_trig, 1  
)).play;  
)

// JUPITER 4: Brassy Poly Chords  
(  
Ndef(\\jpBrass).fadeTime \= 0.5;  
Ndef(\\jpBrass, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(\[220, 220, 220\]);  
    var env \= EnvGen.kr(Env.perc(0.08, 1.2), t\_trig);  
    var fEnv \= EnvGen.kr(Env.perc(0.12, 0.8), t\_trig);

    var sig \= Splay.ar(Saw.ar(freq \* \[0.995, 1, 1.005\]));  
    sig \= MoogFF.ar(sig, 300 \+ (fEnv \* 3000), 1.2);

    sig \* env \* 0.4;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\jpBrass);  
)

// \=============================================================================  
// 6\. ROLAND JUNO (DCOs, Sub-Oscillator, and the Magic Chorus)  
// \=============================================================================

// JUNO 1: Classic Hover/Chord (Saw \+ Square \+ Sub \+ Chorus)  
(  
Ndef(\\junoChord).fadeTime \= 0.5;  
Ndef(\\junoChord, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(\[220, 220, 220\]);  
    var env \= EnvGen.kr(Env.perc(0.01, 1.5), t\_trig);

    var saw \= Saw.ar(freq);  
    var pulse \= Pulse.ar(freq, SinOsc.kr(0.3).range(0.2, 0.8));  
    var sub \= Pulse.ar(freq \* 0.5, 0.5); // The classic Juno Sub

    var sig \= Splay.ar(saw \+ pulse \+ sub) \* 0.33;

    // Juno Chorus I Simulation (Rich, wide, slow)  
    var chorus \= DelayC.ar(sig, 0.05, SinOsc.kr(\[0.5, 0.55\], \[0, pi\]).range(0.005, 0.015));

    // Juno filter setup: Static HPF into Enveloped LPF  
    sig \= HPF.ar(sig, 150);  
    sig \= MoogFF.ar(sig, 800 \+ (env \* 4000), 0.5);

    sig \= sig \+ chorus;

    sig \* env \* 0.4;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\junoChord);

Ndef(\\junoChordSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\junoChord).nodeID }), \\args, \#\[\\freq, \\t\_trig\],  
    \\midinote, Pseq(\[ \[\[60, 64, 67\]\], \[\[55, 59, 62\]\], \[\[57, 60, 64\]\] \], inf),  
    \\dur, 2, \\t\_trig, 1  
)).play;  
)

// JUNO 2: Snappy Bass (Resonant, punchy envelope)  
(  
Ndef(\\junoBass).fadeTime \= 0.5;  
Ndef(\\junoBass, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(55);  
    var env \= EnvGen.kr(Env.perc(0.001, 0.4), t\_trig);

    var sig \= Saw.ar(freq) \+ Pulse.ar(freq \* 0.5, 0.5); // Saw \+ Sub  
    sig \= MoogFF.ar(sig, 100 \+ (env \* 2500), 2.5); // High resonance

    (sig \* 1.5).tanh \* env \* 0.5 \! 2;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\junoBass);

Ndef(\\junoBassSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\junoBass).nodeID }), \\args, \#\[\\freq, \\t\_trig\],  
    \\degree, Pseq(\[0, 0, 7, 0, 0, \-2, 0, 3\], inf), \\octave, 3, \\dur, 0.25, \\t\_trig, 1  
)).play;  
)

// JUNO 3: Shimmering Arp (PWM heavy)  
(  
Ndef(\\junoArp).fadeTime \= 0.5;  
Ndef(\\junoArp, {  
    var t\_trig \= \\t\_trig.tr(1);  
    var freq \= \\freq.kr(440);  
    var env \= EnvGen.kr(Env.perc(0.01, 0.3), t\_trig);

    var sig \= Pulse.ar(freq, SinOsc.kr(1.5).range(0.1, 0.9));  
    sig \= MoogFF.ar(sig, 1000 \+ (env \* 2000), 1.0);

    // Juno Chorus II Simulation (Faster, deeper)  
    sig \= sig \+ DelayC.ar(sig, 0.05, SinOsc.kr(\[0.8, 0.85\], \[0, pi\]).range(0.01, 0.025));

    sig \* env \* 0.3;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\junoArp);

Ndef(\\junoArpSeq, Pbind(  
    \\type, \\set, \\id, Pfunc({ Ndef(\\junoArp).nodeID }), \\args, \#\[\\freq, \\t\_trig\],  
    \\scale, Scale.minor, \\degree, Pseq(\[0, 2, 4, 7, 9, 7, 4, 2\], inf),  
    \\dur, 0.125, \\t\_trig, 1  
)).play;  
)

// JUNO 4: Ghostly Pad (High pass filter focused)  
(  
Ndef(\\junoPad).fadeTime \= 3;  
Ndef(\\junoPad, {  
    var freq \= \\freq.kr(110);  
    var sig \= Saw.ar(\[freq, freq\*1.01\]) \+ Pulse.ar(\[freq\*2, freq\*2.01\], 0.5);

    // HPF cranked up to thin out the sound  
    sig \= HPF.ar(sig, 1000);  
    sig \= MoogFF.ar(sig, SinOsc.kr(0.1).exprange(1200, 4000), 0.5);

    sig \= sig \+ DelayC.ar(sig, 0.05, SinOsc.kr(\[0.4, 0.45\]).range(0.01, 0.02));  
    sig \* 0.2;  
}).play;  
Ndef(\\master) \<\<\> Ndef(\\junoPad);  
)

\--- RETRIEVED 3 (knowledge-base: ndef-subtractive.scd) \---  
(  
Ndef(\\superSaw, {  
	var freq \= \\freq.kr(110);  
	var detune \= \\detune.kr(0.02); // 2% detune

	// 1\. Create an array of 5 frequencies centered around 'freq'  
	var freqs \= freq \* \[1-detune, 1-(detune/2), 1, 1+(detune/2), 1+detune\];

	// 2\. Source: 5 Saw waves summed together  
	var sig \= Splay.ar(Saw.ar(freqs));

	// 3\. Filter: Low Pass to tame the buzz  
	sig \= LPF.ar(sig, 6000);

	sig \* 0.3;  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\superSaw);

// LIVE TWEAK:  
Ndef(\\superSaw).xset(\\detune, 0.1); // Huge, messy detune

// \=============================================================================  
// 4\. BANDPASS SWEEP (Formants/Vowels)  
// Best for: "Talking" basses, vocal-like textures.  
// Concept: Sweeping a narrow band of frequencies (BPF).  
// \=============================================================================

(  
Ndef(\\vowelBass, {  
	var freq \= \\freq.kr(80);  
	var rate \= \\rate.kr(0.5);

	// 1\. Source: Rich Pulse wave  
	var sig \= Pulse.ar(\[freq, freq \* 1.01\], 0.2);

	// 2\. Modulator: Slow Triangle LFO  
	var sweep \= LFTri.kr(rate).exprange(200, 2000);

	// 3\. Filter: BPF (Band Pass Filter)  
	// rq \= 0.2 (Narrow band \-\> Vocal quality)  
	sig \= BPF.ar(sig, sweep, 0.2);

	// High gain needed after narrow BPF  
	sig \= (sig \* 5).tanh;

	sig \* 0.4;  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\vowelBass);

// \=============================================================================  
// 5\. NOISE SCULPTING (Subtractive Percussion)  
// Best for: Hi-hats, snares, wind, ocean sounds.  
// Concept: Filtering White/Pink Noise.  
// \=============================================================================

(  
Ndef(\\noisePerc).fadeTime \= 0;  
Ndef(\\noisePerc, {  
	var t\_trig \= \\t\_trig.tr(1);

	// FIX 1: Renamed 'type' to 'filtType' to avoid conflict  
	var mode \= \\filtType.kr(0);

	var env \= EnvGen.kr(Env.perc(0.001, 0.2), t\_trig);  
	var sig \= WhiteNoise.ar();

	// Select filter type  
	sig \= Select.ar(mode, \[  
		HPF.ar(sig, 8000),       // 0: Hat  
		BPF.ar(sig, 2000, 0.5),  // 1: Snare  
		LPF.ar(sig, 300\)         // 2: Kick  
	\]);

	sig \* env \* 0.5 \! 2;  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\noisePerc);

// LIVE SEQUENCE:  
(  
Ndef(\\percSeq, Pbind(  
	// FIX 2: This command must remain \\set  
	\\type, \\set,

	// Target the noisePerc Ndef  
	\\id, Pfunc({ Ndef(\\noisePerc).nodeID }),

	// FIX 3: Control the NEW argument name  
	\\filtType, Pseq(\[2, 0, 1, 0\], inf),

	\\t\_trig, 1,  
	\\dur, 0.25,  
	\\args, \#\[\\t\_trig, \\filtType\] // Ensure arguments are sent  
)).play;  
)

// \=============================================================================  
// 6\. GATED PADS (Rhythmic Subtractive)  
// Best for: Trance gates, rhythmic chord pulses.  
// Concept: Modulating the Amplitude (VCA) with a Pulse LFO.  
// \=============================================================================

(  
Ndef(\\gatedPad, {  
	var freq \= \\freq.kr(110);  
	var gateRate \= \\rate.kr(4); // 16th notes at 120bpm \= 8Hz

	// 1\. Source: Lush Chord (SuperSaw)  
	var chord \= Splay.ar(Saw.ar(freq \* \[1, 1.2, 1.5\])); // Major Triad

	// 2\. The Gate (Square LFO)  
	// width: 0.5 (normal) to 0.1 (staccato)  
	var gate \= LFPulse.kr(gateRate, 0, 0.4);

	// 3\. Filter: Soft Low Pass  
	chord \= LPF.ar(chord, 2000);

	chord \* gate \* 0.3;  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\gatedPad);

// LIVE TWEAK:  
Ndef(\\gatedPad).xset(\\rate, 8, \\freq, 220); // Double time, octave up

\--- RETRIEVED 4 (knowledge-base: pbindef-pbind.scd) \---  
(  
Pdef(\\pluckPart).stop; Pdef(\\bassPart).stop; // Clear the stage

// Define two distinct musical phrases for the Pluck  
\~phraseA \= Pbind(\\type, \\set, \\id, Pfunc({ Ndef(\\fmPluck).group }), \\args, \#\[\\freq, \\t\_trig\],  
	\\dur, 1/4, \\degree, Pseq(\[0, 2, 3, 5\], 1), \\t\_trig, 1);

\~phraseB \= Pbind(\\type, \\set, \\id, Pfunc({ Ndef(\\fmPluck).group }), \\args, \#\[\\freq, \\t\_trig\],  
	\\dur, 1/4, \\degree, Pseq(\[7, 5, 4, 2\], 1), \\t\_trig, 1);

// Define a Bass phrase  
\~bassPhrase \= Pbind(\\type, \\set, \\id, Pfunc({ Ndef(\\subBass).group }), \\args, \#\[\\freq, \\t\_trig\],  
	\\dur, 1/2, \\degree, Pseq(\[-7, \-7\], 1), \\t\_trig, 1);

// \--- PSEQ: Play phrases sequentially \---  
// Plays Phrase A, then Phrase B, looping infinitely  
\~songStructure \= Pseq(\[\~phraseA, \~phraseB\], inf);

// \--- PPAR: Play patterns simultaneously \---  
// Plays the Pluck song structure AND the Bass phrase at the same time  
\~fullBand \= Ppar(\[  
	\~songStructure,  
	Pseq(\[\~bassPhrase\], inf) // Loop the bass phrase to keep up  
\], inf);

\~conductor \= \~fullBand.play(\~t);  
)

\~conductor.stop;

\--- RETRIEVED 5 (knowledge-base: ndef-addictive.scd) \---  
// Iteratively build the synthesis graph  
	var sig \= Mix.fill(n, { |i|  
		var freq \= fund \* (1 \+ (i \* ratio));  
		// Amplitude follows an exponential decay curve  
		var amp \= 1.0 / (dec.pow(i));  
		SinOsc.ar(freq) \* amp;  
	});

	// Spread and add subtle saturation  
	Splay.ar(sig).tanh \* \\amp.kr(0.4);  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\addIterative);

// LIVE TIP: Create a separate LFO Ndef and map it to 'ratio'  
// This makes the spectrum "breathe" or "stretch"  
(  
Ndef(\\lfoBreath, { LFNoise1.kr(0.2).range(1.0, 2.1) });  
)  
Ndef(\\addIterative).map(\\ratio, Ndef(\\lfoBreath));

// \=============================================================================  
// 3\. BAND-LIMITED IMPULSE (BLIP)  
// concept: Buzzing, retro sounds. Efficient way to stack many harmonics.  
// \=============================================================================

(  
Ndef(\\addBlip, {  
	var fund \= \\fund.kr(60);  
	var numHarm \= \\harm.kr(20); // Number of harmonics

	// Stereo Blip with slight detune \[1, 1.01\]  
	var sig \= Blip.ar(fund \* \[1, 1.01\], numHarm);

	// Low Pass Filter that tracks the highest harmonic to remove aliasing/fizz  
	sig \= LPF.ar(sig, (fund \* numHarm).clip(100, 18000));

	sig \* \\amp.kr(0.4);  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\addBlip);

// Modular LFO for Harmonic Sweep  
(  
Ndef(\\lfoSweep, {  
	// Sweep from 1 to 40 harmonics over time  
	LFTri.kr(0.1).exprange(1, 40\)  
});  
)  
// Map the LFO to the Blip's harmonic count  
Ndef(\\addBlip).map(\\harm, Ndef(\\lfoSweep));

// \=============================================================================  
// 4\. KLANG (Fixed & Dynamic Banks)  
// concept: Resonant metals, frozen chords, or shifting glass textures.  
// \=============================================================================

// \--- A. Klang (Static / Baked Randomness) \---  
(  
Ndef(\\addKlang, {  
	// Re-running this block generates a NEW random timbre  
	var freqs \= Array.exprand(12, 200, 4000).sort;  
	var amps \= Array.exprand(12, 0.01, 0.1).sort.reverse;  
	var phases \= Array.rand(12, 0, 2pi);

	// \`\[\] syntax creates a Ref, required by Klang  
	var sig \= Klang.ar(\`\[freqs, amps, phases\], 1, 0);

	Splay.ar(sig) \* 0.5;  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\addKlang);

// \--- B. DynKlang (Dynamic / Modulatable) \---  
(  
Ndef(\\addDynKlang, {  
	var n \= 8;  
	var fund \= \\fund.kr(150);

	// Arrays of Modulators (one LFO per partial)  
	var freqMods \= { LFNoise1.kr(0.5).exprange(0.98, 1.02) } \! n;

	// Fibonacci Series for base frequencies (Golden Ratio-ish)  
	var baseFreqs \= Array.fib(n, fund, fund);

	var sig \= DynKlang.ar(\`\[  
		baseFreqs \* freqMods, // Modulate freq live  
		nil, // Default amps  
		nil  // Default phases  
	\]);

	Splay.ar(sig) \* 0.2;  
}).play;  
)  
Ndef(\\master) \<\<\> Ndef(\\addDynKlang);

// Add an Insert FX (Reverb) to the DynKlang  
// Slot 10 is arbitrary (processed after source \[0\])  
Ndef(\\addDynKlang)\[10\] \= \\filter \-\> { |in| FreeVerb.ar(in, 0.5, 0.9, 0.2) };

// \=============================================================================  
// 5\. CLEANUP / PANIC  
// \=============================================================================

// Fade everything out over 5 seconds  
Ndef(\\master).fadeTime \= 5;  
Ndef(\\master, { 0 });

// Clear all Ndefs (Stops sound and frees memory)  
Ndef.clear(5);  
\`\`\`

\*\*User Prompt & Subtext:\*\*  
\`\`\`text  
Context: Working in 'sc-files/test.scd'. Previous code:

\=== APPROVED COMPOSITION PLAN \===  
\# SuperCollider Synthesizer Design Plan: Kocho-Mai Butterfly Ensemble

\#\# 0\. Global CC Configuration  
\*   \*\*Mixer (per zone)\*\*: Vol (81-86), Pan (87-92), Mute (93-98)  
\*   \*\*Key Ranges (per zone)\*\*: Min (101-106), Max (107-112)  
\*   \*\*Filters (per zone)\*\*: HPF (13-18), LPF (19-24), Res (25-30)  
\*   \*\*ADSR (per zone)\*\*: Atk (31-36), Dec (37-42), Sus (43-48), Rls (49-54)  
\*   \*\*Unique Zone FX\*\*: Res Decay (55), Grain Density (56), Breath Amt (57), Harmonic Shift (58), Formant Shift (59), Flutter Speed (60)  
\*   \*\*Global FX\*\*: Group A Mix (61), Group B Mix (62), Group C Mix (63), Master Verb Mix (64), Master Delay Mix (65), Master Delay Time (66)

\#\# 1\. Zone Architecture & Timbre (Six Dancers)

\*   \*\*Zone 1: Great Drum Resonator\*\*  
    \*   \*\*Paradigm\*\*: Physical Modeling (Resonant Body). Simulates a large, slowly decaying drum/gong with \`Resonz\` or \`Klank\` driven by an impulse.  
    \*   \*\*Voice Mode\*\*: Monophonic (single, powerful instance with 0.2s \`Lag.kr\` for subtle pitch glides).  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Pan2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Resonance Decay\* (CC 55\) \- Controls the decay time of the resonant body. Starts at 0.5s.

\*   \*\*Zone 2: Hand Drum Flicker\*\*  
    \*   \*\*Paradigm\*\*: Granular Synthesis (Short, percussive noise bursts or pitched clicks). Focuses on texture and rhythmic elements.  
    \*   \*\*Voice Mode\*\*: Polyphonic (up to 8 voices) for intricate, shifting patterns.  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Grain Density\* (CC 56\) \- Modulates the frequency of individual grain triggers. Starts at 0.0 (low density).

\*   \*\*Zone 3: Small Flute Breath\*\*  
    \*   \*\*Paradigm\*\*: Subtractive Synthesis (Sine oscillator mixed with filtered noise for a breathy quality).  
    \*   \*\*Voice Mode\*\*: Polyphonic (up to 8 voices) for delicate melodies and harmonies.  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Breath Amount\* (CC 57\) \- Controls the wet/dry mix of the noise component. Starts at 0.0 (pure sine).

\*   \*\*Zone 4: Great Flute Drone\*\*  
    \*   \*\*Paradigm\*\*: FM Synthesis (Complex carrier/modulator ratios for rich, evolving harmonics). Designed for sustained tones.  
    \*   \*\*Voice Mode\*\*: Monophonic (with 0.3s \`Lag.kr\` for smooth, expressive transitions).  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Pan2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Harmonic Shift\* (CC 58\) \- Modulates the FM index or modulator ratio, subtly shifting the timbre over time. Starts at 0.0 (stable).

\*   \*\*Zone 5: Pandean Whisper\*\*  
    \*   \*\*Paradigm\*\*: Wavetable/Formant Synthesis (Uses a custom, spectrally rich waveform or generates formants to emulate an "unknown" pipe sound).  
    \*   \*\*Voice Mode\*\*: Paraphonic (shared filter envelope for all active notes, creating a unified breath/phrase).  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Formant Shift\* (CC 59\) \- Sweeps the spectral centroid or formant frequencies of the sound. Starts at 0.0 (neutral).

\*   \*\*Zone 6: Butterfly Flutter\*\*  
    \*   \*\*Paradigm\*\*: Additive Synthesis/Phasor Modulation (Multiple detuned sine/pulse waves with rapid amplitude or pitch modulation for a shimmering, ethereal texture).  
    \*   \*\*Voice Mode\*\*: Polyphonic (up to 8 voices) for a "swarm" or fluttering effect.  
    \*   \*\*Standard Parameters\*\*: Volume, Panning (\`Balance2\`), Mute, ADSR, HPF, LPF, LPF Resonance.  
    \*   \*\*Unique FX\*\*: \*Flutter Speed\* (CC 60\) \- Controls the rate of the LFOs modulating pitch/amplitude. Starts at 0.0 (slowest flutter).

\#\# 2\. Mixing Strategy & Coexistence  
\*   \*\*Headroom & Volumes\*\*: All zones will start at conservative volumes (0.2-0.3) to allow for dynamic expression and prevent clipping, especially from resonant elements. Zone 1 (Great Drum) and Zone 4 (Great Flute) will start slightly lower (0.2) due to their potential for powerful low-end or sustained presence.  
\*   \*\*Frequency Bracketing\*\*:  
    \*   Zone 1 (Great Drum): HPF at 20Hz, LPF at 800Hz (to define its low-mid space).  
    \*   Zone 2 (Hand Drum): HPF at 150Hz, LPF at 5kHz (percussive mid-range).  
    \*   Zone 3 (Small Flute): HPF at 300Hz, LPF at 10kHz (airy high-mids).  
    \*   Zone 4 (Great Flute): HPF at 80Hz, LPF at 4kHz (rich mid-range drone).  
    \*   Zone 5 (Pandean Whisper): HPF at 200Hz, LPF at 8kHz (unique mid-high character).  
    \*   Zone 6 (Butterfly Flutter): HPF at 1kHz, LPF at 16kHz (delicate, high-frequency texture).  
\*   \*\*Spatial Distribution\*\*:  
    \*   Zone 1: Panned slightly left (-0.2) to give it a grounded presence.  
    \*   Zone 2: Spread wide with \`Balance2\` (-0.5 to 0.5) to create a sense of movement.  
    \*   Zone 3: Panned slightly right (0.2).  
    \*   Zone 4: Dead center (0.0) as a central melodic/drone element.  
    \*   Zone 5: Spread moderately with \`Balance2\` (-0.3 to 0.3) for an ethereal presence.  
    \*   Zone 6: Panned widely with \`Balance2\` (-0.8 to 0.8) to emphasize its "fluttering" and "circling" nature.

\#\# 3\. Signal Flow & Multi-Tier FX  
\*   \*\*Bus Routing\*\*:  
    \*   Zone 1 & 2 \-\> \`\~groupABus\` (Stereo)  
    \*   Zone 3, 4 & 5 \-\> \`\~groupBBus\` (Stereo)  
    \*   Zone 6 \-\> \`\~groupCBus\` (Stereo)  
    \*   \`\~groupABus\`, \`\~groupBBus\`, \`\~groupCBus\` \-\> \`\~masterBus\` (Stereo)  
\*   \*\*Group Effects (Independent Synths)\*\*:  
    \*   \*\*Group A (Drums)\*\*: Subtle Compressor \-\> Short Room Reverb.  
        \*   \`\~groupAMix\` (CC 61): Controls the wetness of the Short Room Reverb. \*\*Starts at 0.0 wet.\*\*  
    \*   \*\*Group B (Flutes/Pipes)\*\*: Gentle Chorus/Ensemble \-\> Medium Hall Reverb.  
        \*   \`\~groupBMix\` (CC 62): Controls the wetness of the Medium Hall Reverb. \*\*Starts at 0.0 wet.\*\*  
    \*   \*\*Group C (Flutter)\*\*: Stereo Widener \-\> Plate Reverb.  
        \*   \`\~groupCMix\` (CC 63): Controls the wetness of the Plate Reverb. \*\*Starts at 0.0 wet.\*\*  
\*   \*\*Master Effects (Independent Synths)\*\*:  
    \*   Master Reverb (Long, ethereal).  
        \*   \`\~masterVerbMix\` (CC 64): Controls the wetness. \*\*Starts at 0.0 wet.\*\*  
    \*   Master Delay (Ping-pong).  
        \*   \`\~masterDelayMix\` (CC 65): Controls the wetness. \*\*Starts at 0.0 wet.\*\*  
        \*   \`\~masterDelayTime\` (CC 66): Controls delay time. \*\*Starts at 0.5s.\*\*  
    \*   Master Limiter (0.95 ceiling) \-\> Master HPF (20Hz) \-\> Master LPF (18kHz).  
\*   \*\*CRITICAL\*\*: All effect synths will be instantiated using \`\\addToTail\` to ensure correct serial processing on their respective groups. All wet/mix parameters for effects will initialize at \`0.0\` (or bypassed state) for a clean, dry boot.

\#\# 4\. Paginated UI Design  
\*   \*\*Tabs\*\*: A row of 6 buttons at the top of the window, each labeled for a zone (e.g., "Zone 1: Great Drum"), which will toggle the visibility of 6 overlapping \`CompositeView\` pages.  
\*   \*\*Zone Pages\*\*: Each page will contain:  
    \*   An \`EZRanger\` for \`Min/Max Key Range\` (e.g., "Key Min (CC 101)").  
    \*   An \`EZSlider\` for \`Volume\` (e.g., "Vol (CC 81)").  
    \*   \`EZKnobs\` for \`Panning\` (e.g., "Pan (CC 87)"), \`HPF\` (e.g., "HPF (CC 13)"), \`LPF\` (e.g., "LPF (CC 19)"), and \`LPF Resonance\` (e.g., "Res (CC 25)").  
    \*   Four \`EZKnobs\` for \`ADSR\` parameters (e.g., "Attack (CC 31)", "Decay (CC 37)", "Sustain (CC 43)", "Release (CC 49)").  
    \*   One \`EZKnob\` for the \`Unique Zone Effect\` (e.g., "Res Decay (CC 55)").  
    \*   A \`Button\` for \`Mute\` (e.g., "Mute (CC 93)").  
\*   \*\*Global Bottom Bar\*\*: A static section at the bottom of the window (always visible) containing \`EZSliders\` for:  
    \*   \`Group A Mix (CC 61)\`  
    \*   \`Group B Mix (CC 62)\`  
    \*   \`Group C Mix (CC 63)\`  
    \*   \`Master Verb Mix (CC 64)\`  
    \*   \`Master Delay Mix (CC 65)\`  
    \*   \`Master Delay Time (CC 66)\`  
\*   \*\*Labels\*\*: All UI elements will clearly display their assigned CC number in their string label.

\#\# 5\. SC Stability Targets  
\*   All \`var\` declarations within functions and closures will be strictly grouped at the absolute top for clarity and stability.  
\*   \`Balance2.ar\` will be used for stereo signals requiring panning spread, and \`Pan2.ar\` for mono signals.  
\*   Boolean evaluations for key ranges will consistently use \`((noteNum \>= min) and: { noteNum \<= max })\`.

Request: I had almost forgotten to mention an ancient Japanese dance, called the Butterfly Dance (Kocho-Mai), which used to be performed in the Imperial Palace, by dancers costumed as butterflies. Whether it is danced occasionally nowadays I do not know. It is said to be very difficult to learn. Six dancers are required for the proper performance of it; and they must move in particular figures, — obeying traditional rules for every step, pose, or gesture, — and circling about each other very slowly to the sound of hand-drums and great drums, small flutes and great flutes, and pandean pipes of a form unknown to Western Pan.  
Output ONLY the valid SuperCollider code block executing the plan.   
Ensure the final block is a valid, runnable sequence defining the synthesizer logic properly.  
\`\`\`

**\*\*Final Answer/Output:\*\***  
\`\`\`supercollider

// \==========================================  
// STEP 0: GLOBAL CONFIGURATION (CC MAP)  
// \==========================================  
(  
\~cc \= (  
    // Mixer (Vol, Pan, Mute)  
    vol1: 81, vol2: 82, vol3: 83, vol4: 84, vol5: 85, vol6: 86,  
    pan1: 87, pan2: 88, pan3: 89, pan4: 90, pan5: 91, pan6: 92,  
    mute1: 93, mute2: 94, mute3: 95, mute4: 96, mute5: 97, mute6: 98,

    // Key Ranges (Min / Max)  
    min1: 101, max1: 107,  
    min2: 102, max2: 108,  
    min3: 103, max3: 109,  
    min4: 104, max4: 110,  
    min5: 105, max5: 111,  
    min6: 106, max6: 112,

    // Filters (HPF, LPF, Res)  
    hpf1: 13, hpf2: 14, hpf3: 15, hpf4: 16, hpf5: 17, hpf6: 18,  
    lpf1: 19, lpf2: 20, lpf3: 21, lpf4: 22, lpf5: 23, lpf6: 24,  
    rq1: 25, rq2: 26, rq3: 27, rq4: 28, rq5: 29, rq6: 30,

    // ADSR Envelopes  
    atk1: 31, atk2: 32, atk3: 33, atk4: 34, atk5: 35, atk6: 36,  
    dec1: 37, dec2: 38, dec3: 39, dec4: 40, dec5: 41, dec6: 42,  
    sus1: 43, sus2: 44, sus3: 45, sus4: 46, sus5: 47, sus6: 48,  
    rls1: 49, rls2: 50, rls3: 51, rls4: 52, rls5: 53, rls6: 54,

    // Unique Zone FX  
    resDecay1: 55, grainDens2: 56, breathAmt3: 57,  
    harmShift4: 58, formShift5: 59, flutterSpd6: 60,

    // Global FX  
    mixA: 61, mixB: 62, mixC: 63,  
    masterVerb: 64, masterDelay: 65, masterDelTime: 66  
);  
)

// \==========================================  
// STEP 1 & 2: DISCOVERY & CONNECTION  
// \==========================================  
(  
MIDIClient.init;  
\~myInDevice \= MIDIClient.sources.detect { |src| src.device \== "loopMIDI Port" };

if(\~myInDevice.notNil) {  
    MIDIIn.connect(0, \~myInDevice);  
    "MIDI IN connected successfully to: ".post; \~myInDevice.device.postln;  
    \~myUid \= \~myInDevice.uid;  
} {  
    "Warning: Target MIDI IN device not found\! Listening to all ports...".warn;  
    \~myUid \= nil;  
};  
)

// \==========================================  
// STEP 3: AUDIO SERVER, ROUTING & SYNTHESIS  
// \==========================================  
(  
s.options.memSize \= 131072;  
s.boot;

s.waitForBoot({

    // A. CONTROL BUSES & INITIAL STATE DICTIONARY  
    \~ccVals \= (  
        // Volumes (Conservative Headroom)  
        vol1: 0.2, vol2: 0.3, vol3: 0.3, vol4: 0.2, vol5: 0.3, vol6: 0.3,  
        // Panning Spread  
        pan1: \-0.2, pan2: 0.0, pan3: 0.2, pan4: 0.0, pan5: 0.0, pan6: 0.0,  
        mute1: 0.0, mute2: 0.0, mute3: 0.0, mute4: 0.0, mute5: 0.0, mute6: 0.0,

        // Key Ranges  
        min1: 0, max1: 60, min2: 0, max2: 127, min3: 48, max3: 96,  
        min4: 24, max4: 72, min5: 36, max5: 96, min6: 60, max6: 127,

        // Filters (Bracketed)  
        hpf1: 20, hpf2: 150, hpf3: 300, hpf4: 80, hpf5: 200, hpf6: 1000,  
        lpf1: 800, lpf2: 5000, lpf3: 10000, lpf4: 4000, lpf5: 8000, lpf6: 16000,  
        rq1: 1.0, rq2: 1.0, rq3: 1.0, rq4: 1.0, rq5: 1.0, rq6: 1.0,

        // ADSR Defaults  
        atk1: 0.01, dec1: 1.0, sus1: 1.0, rls1: 2.0,  
        atk2: 0.01, dec2: 0.5, sus2: 0.2, rls2: 0.5,  
        atk3: 1.5, dec3: 1.0, sus3: 1.0, rls3: 2.0,  
        atk4: 0.8, dec4: 1.0, sus4: 1.0, rls4: 2.5,  
        atk5: 2.0, dec5: 1.0, sus5: 1.0, rls5: 3.0,  
        atk6: 0.5, dec6: 1.0, sus6: 1.0, rls6: 1.5,

        // Unique FX  
        resDecay1: 0.5, grainDens2: 1.0, breathAmt3: 0.0,  
        harmShift4: 1.0, formShift5: 1.0, flutterSpd6: 0.1,

        // Global FX (All start at 0.0 wet)  
        mixA: 0.0, mixB: 0.0, mixC: 0.0,  
        masterVerb: 0.0, masterDelay: 0.0, masterDelTime: 0.5  
    );

    \~buses \= ();  
    \~ccVals.keysValuesDo { |key, val| \~buses\[key\] \= Bus.control(s, 1).set(val) };

    // B. AUDIO ROUTING  
    \~synthGroup \= Group.new(s);  
    \~fxGroupA \= Group.after(\~synthGroup);  
    \~fxGroupB \= Group.after(\~fxGroupA);  
    \~fxGroupC \= Group.after(\~fxGroupB);  
    \~masterGroup \= Group.after(\~fxGroupC);

    \~busA \= Bus.audio(s, 2);  
    \~busB \= Bus.audio(s, 2);  
    \~busC \= Bus.audio(s, 2);  
    \~masterBus \= Bus.audio(s, 2);

    // C. SYNTHDEFS

    // ZONE 1: Great Drum Resonator (Mono, Physical Modeling)  
    SynthDef(\\zone1\_Drum, { arg out=0, freq=65.41, gate=1, vel=0.8, zoneVol=0.2, pan=(-0.2), mute=0, hpf=20, lpf=800, rq=1, atk=0.01, dec=1.0, sus=1.0, rls=2.0, resDecay=0.5;  
        var lagFreq \= Lag.kr(freq, 0.2);  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var exciter \= EnvGen.ar(Env.perc(0.001, 0.05)) \* PinkNoise.ar;  
        var freqs \= \[1.0, 1.5, 2.3, 3.5, 4.2\] \* lagFreq;  
        var amps \= \[1.0, 0.6, 0.4, 0.2, 0.1\];  
        var rings \= \[1.0, 0.8, 0.6, 0.4, 0.2\] \* resDecay;  
        var sig \= DynKlank.ar(\`\[freqs, amps, rings\], exciter);  
        sig \= RLPF.ar(HPF.ar(sig, hpf), lpf, rq);  
        Out.ar(out, Pan2.ar(sig, pan, env \* vel \* zoneVol \* (1 \- mute)));  
    }).add;

    // ZONE 2: Hand Drum Flicker (Poly, Granular/Noise)  
    SynthDef(\\zone2\_Flicker, { arg out=0, freq=261.6, gate=1, vel=0.8, zoneVol=0.3, pan=0, mute=0, hpf=150, lpf=5000, rq=1, atk=0.01, dec=0.5, sus=0.2, rls=0.5, grainDens=1.0;  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var trig \= Dust.ar(grainDens);  
        var exciter \= WhiteNoise.ar \* EnvGen.ar(Env.perc(0.001, 0.05), trig);  
        var sig \= Ringz.ar(exciter, freq, 0.1);  
        sig \= RLPF.ar(HPF.ar(sig, hpf), lpf, rq);  
        Out.ar(out, Balance2.ar(sig, sig, pan, env \* vel \* zoneVol \* (1 \- mute)));  
    }).add;

    // ZONE 3: Small Flute Breath (Poly, Subtractive)  
    SynthDef(\\zone3\_Flute, { arg out=0, freq=523.25, gate=1, vel=0.8, zoneVol=0.3, pan=0.2, mute=0, hpf=300, lpf=10000, rq=1, atk=1.5, dec=1.0, sus=1.0, rls=2.0, breathAmt=0.0;  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var noise \= BPF.ar(PinkNoise.ar, freq, 0.1) \* breathAmt \* 4.0;  
        var sig \= SinOsc.ar(freq) \+ noise;  
        sig \= RLPF.ar(HPF.ar(sig, hpf), lpf, rq);  
        Out.ar(out, Balance2.ar(sig, sig, pan, env \* vel \* zoneVol \* (1 \- mute)));  
    }).add;

    // ZONE 4: Great Flute Drone (Mono, FM Synthesis)  
    SynthDef(\\zone4\_Drone, { arg out=0, freq=130.8, gate=1, vel=0.8, zoneVol=0.2, pan=0, mute=0, hpf=80, lpf=4000, rq=1, atk=0.8, dec=1.0, sus=1.0, rls=2.5, harmShift=1.0;  
        var lagFreq \= Lag.kr(freq, 0.3);  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var mod \= SinOsc.ar(lagFreq \* harmShift) \* (harmShift \* 300);  
        var sig \= SinOsc.ar(lagFreq \+ mod);  
        sig \= RLPF.ar(HPF.ar(sig, hpf), lpf, rq);  
        Out.ar(out, Pan2.ar(sig, pan, env \* vel \* zoneVol \* (1 \- mute)));  
    }).add;

    // ZONE 5: Pandean Whisper (Poly/Paraphonic-feel, Formant)  
    SynthDef(\\zone5\_Pandean, { arg out=0, freq=349.2, gate=1, vel=0.8, zoneVol=0.3, pan=0, mute=0, hpf=200, lpf=8000, rq=1, atk=2.0, dec=1.0, sus=1.0, rls=3.0, formShift=1.0;  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var sig \= Formant.ar(freq, freq \* formShift, 400);  
        sig \= RLPF.ar(HPF.ar(sig, hpf), lpf, rq);  
        Out.ar(out, Balance2.ar(sig, sig, pan, env \* vel \* zoneVol \* (1 \- mute)));  
    }).add;

    // ZONE 6: Butterfly Flutter (Poly, Additive/Phasor)  
    SynthDef(\\zone6\_Flutter, { arg out=0, freq=1046.5, gate=1, vel=0.8, zoneVol=0.3, pan=0, mute=0, hpf=1000, lpf=16000, rq=1, atk=0.5, dec=1.0, sus=1.0, rls=1.5, flutterSpd=0.1;  
        var env \= EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);  
        var flutter \= LFSaw.kr(flutterSpd).range(0.2, 1.0);  
        var sig \= Mix(Pulse.ar(freq \* \[1.0, 1.01, 0.99\], 0.5)) \* flutter \* 0.3;  
        sig \= RLPF.ar(HPF.ar(sig, hpf), lpf, rq);  
        Out.ar(out, Balance2.ar(sig, sig, pan, env \* vel \* zoneVol \* (1 \- mute)));  
    }).add;

    // FX SYNTHS  
    SynthDef(\\fx\_GroupA, { |in, out, mixBus|  
        var sig \= In.ar(in, 2);  
        var mix \= In.kr(mixBus);  
        sig \= Compander.ar(sig, sig, 0.5, 1.0, 0.5, 0.01, 0.1);  
        sig \= sig \+ (FreeVerb2.ar(sig\[0\], sig\[1\], mix, 0.3, 0.8) \* mix);  
        Out.ar(out, sig);  
    }).add;

    SynthDef(\\fx\_GroupB, { |in, out, mixBus|  
        var sig \= In.ar(in, 2);  
        var mix \= In.kr(mixBus);  
        var chor \= DelayC.ar(sig, 0.05, SinOsc.kr(\[0.5, 0.6\]).range(0.01, 0.02));  
        sig \= sig \+ (chor \* 0.5);  
        sig \= sig \+ (FreeVerb2.ar(sig\[0\], sig\[1\], mix, 0.6, 0.5) \* mix);  
        Out.ar(out, sig);  
    }).add;

    SynthDef(\\fx\_GroupC, { |in, out, mixBus|  
        var sig \= In.ar(in, 2);  
        var mix \= In.kr(mixBus);  
        var wide \= \[sig\[0\] \+ (sig\[1\]\*0.5), sig\[1\] \+ (sig\[0\]\*0.5)\] \* 0.7;  
        sig \= sig \+ (FreeVerb2.ar(wide\[0\], wide\[1\], mix, 0.8, 0.2) \* mix);  
        Out.ar(out, sig);  
    }).add;

    SynthDef(\\fx\_Master, { |in, out=0, verbBus, delMixBus, delTimeBus|  
        var sig \= In.ar(in, 2);  
        var vMix \= In.kr(verbBus);  
        var dMix \= In.kr(delMixBus);  
        var dTime \= Lag.kr(In.kr(delTimeBus), 0.1);  
        var del;

        sig \= sig \+ (FreeVerb2.ar(sig\[0\], sig\[1\], vMix, 0.9, 0.1) \* vMix);  
        del \= CombC.ar(sig, 2.0, dTime, dTime \* 4);  
        sig \= sig \+ (del \* dMix);

        sig \= HPF.ar(sig, 20);  
        sig \= LPF.ar(sig, 18000);  
        sig \= Limiter.ar(sig, 0.95, 0.01);  
        Out.ar(out, sig);  
    }).add;

    s.sync;

    // D. INSTANTIATE EFFECTS  
    \~fxA \= Synth(\\fx\_GroupA, \[\\in, \~busA, \\out, \~masterBus, \\mixBus, \~buses.mixA\], \~fxGroupA, \\addToTail);  
    \~fxB \= Synth(\\fx\_GroupB, \[\\in, \~busB, \\out, \~masterBus, \\mixBus, \~buses.mixB\], \~fxGroupB, \\addToTail);  
    \~fxC \= Synth(\\fx\_GroupC, \[\\in, \~busC, \\out, \~masterBus, \\mixBus, \~buses.mixC\], \~fxGroupC, \\addToTail);  
    \~fxM \= Synth(\\fx\_Master, \[\\in, \~masterBus, \\out, 0, \\verbBus, \~buses.masterVerb, \\delMixBus, \~buses.masterDelay, \\delTimeBus, \~buses.masterDelTime\], \~masterGroup, \\addToTail);

    // E. SYNTH STATE & MIDI  
    \~notes \= Array.newClear(128);

    MIDIdef.cc(\\kochoMaiCC, { |val, num|  
        var mapped \= val / 127.0;  
        \~cc.keysValuesDo { |key, ccNum|  
            if(num \== ccNum) {  
                var kStr \= key.asString;  
                var finalVal \= case  
                    { kStr.matchRegexp("hpf") } { mapped.linexp(0, 1, 20, 20000\) }  
                    { kStr.matchRegexp("lpf") } { mapped.linexp(0, 1, 20, 20000\) }  
                    { kStr.contains("rq") } { mapped.linexp(0, 1, 1.0, 0.05) }  
                    { kStr.contains("pan") } { mapped.linlin(0, 1, \-1.0, 1.0) }  
                    { kStr.matchRegexp("atk|dec|sus|rls") } { mapped.linexp(0, 1, 0.01, 10.0) }  
                    { kStr.matchRegexp("min|max") } { val }  
                    { kStr.contains("mute") } { (val \> 63).asInteger }  
                    { key \== \\resDecay1 } { mapped.linexp(0, 1, 0.1, 4.0) }  
                    { key \== \\grainDens2 } { mapped.linexp(0, 1, 1.0, 50.0) }  
                    { key \== \\breathAmt3 } { mapped }  
                    { key \== \\harmShift4 } { mapped.linexp(0, 1, 1.0, 10.0) }  
                    { key \== \\formShift5 } { mapped.linexp(0, 1, 1.0, 10.0) }  
                    { key \== \\flutterSpd6 } { mapped.linexp(0, 1, 0.1, 20.0) }  
                    { key \== \\masterDelTime } { mapped.linexp(0, 1, 0.05, 2.0) }  
                    { mapped }; // Default for vol, mixes

                \~ccVals\[key\] \= finalVal;  
                if(\~buses\[key\].notNil) { \~buses\[key\].set(finalVal) };  
            };  
        };  
    }, srcID: \~myUid);

    MIDIdef.noteOn(\\kochoMaiOn, { |velRaw, noteNum|  
        var freq \= noteNum.midicps;  
        var vel \= velRaw / 127.0;

        if(\~notes\[noteNum\].notNil) { \~notes\[noteNum\].do(\_.set(\\gate, 0)) };  
        \~notes\[noteNum\] \= \[\];

        // ZONE 1 (Mono \- Kill previous Z1 synths)  
        if((noteNum \>= \~ccVals\[\\min1\]) and: { noteNum \<= \~ccVals\[\\max1\] }) {  
            \~notes.do { |arr| if(arr.notNil) { arr.do { |syn| if(syn.defName \== \\zone1\_Drum) { syn.set(\\gate, 0\) } } } };  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone1\_Drum, \[  
                \\out, \~busA, \\freq, freq, \\vel, vel, \\gate, 1, \\resDecay, \~buses.resDecay1.asMap,  
                \\zoneVol, \~buses.vol1.asMap, \\pan, \~buses.pan1.asMap, \\mute, \~buses.mute1.asMap,  
                \\hpf, \~buses.hpf1.asMap, \\lpf, \~buses.lpf1.asMap, \\rq, \~buses.rq1.asMap,  
                \\atk, \~buses.atk1.asMap, \\dec, \~buses.dec1.asMap, \\sus, \~buses.sus1.asMap, \\rls, \~buses.rls1.asMap  
            \], target: \~synthGroup));  
        };

        // ZONE 2 (Poly)  
        if((noteNum \>= \~ccVals\[\\min2\]) and: { noteNum \<= \~ccVals\[\\max2\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone2\_Flicker, \[  
                \\out, \~busA, \\freq, freq, \\vel, vel, \\gate, 1, \\grainDens, \~buses.grainDens2.asMap,  
                \\zoneVol, \~buses.vol2.asMap, \\pan, \~buses.pan2.asMap, \\mute, \~buses.mute2.asMap,  
                \\hpf, \~buses.hpf2.asMap, \\lpf, \~buses.lpf2.asMap, \\rq, \~buses.rq2.asMap,  
                \\atk, \~buses.atk2.asMap, \\dec, \~buses.dec2.asMap, \\sus, \~buses.sus2.asMap, \\rls, \~buses.rls2.asMap  
            \], target: \~synthGroup));  
        };

        // ZONE 3 (Poly)  
        if((noteNum \>= \~ccVals\[\\min3\]) and: { noteNum \<= \~ccVals\[\\max3\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone3\_Flute, \[  
                \\out, \~busB, \\freq, freq, \\vel, vel, \\gate, 1, \\breathAmt, \~buses.breathAmt3.asMap,  
                \\zoneVol, \~buses.vol3.asMap, \\pan, \~buses.pan3.asMap, \\mute, \~buses.mute3.asMap,  
                \\hpf, \~buses.hpf3.asMap, \\lpf, \~buses.lpf3.asMap, \\rq, \~buses.rq3.asMap,  
                \\atk, \~buses.atk3.asMap, \\dec, \~buses.dec3.asMap, \\sus, \~buses.sus3.asMap, \\rls, \~buses.rls3.asMap  
            \], target: \~synthGroup));  
        };

        // ZONE 4 (Mono \- Kill previous Z4 synths)  
        if((noteNum \>= \~ccVals\[\\min4\]) and: { noteNum \<= \~ccVals\[\\max4\] }) {  
            \~notes.do { |arr| if(arr.notNil) { arr.do { |syn| if(syn.defName \== \\zone4\_Drone) { syn.set(\\gate, 0\) } } } };  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone4\_Drone, \[  
                \\out, \~busB, \\freq, freq, \\vel, vel, \\gate, 1, \\harmShift, \~buses.harmShift4.asMap,  
                \\zoneVol, \~buses.vol4.asMap, \\pan, \~buses.pan4.asMap, \\mute, \~buses.mute4.asMap,  
                \\hpf, \~buses.hpf4.asMap, \\lpf, \~buses.lpf4.asMap, \\rq, \~buses.rq4.asMap,  
                \\atk, \~buses.atk4.asMap, \\dec, \~buses.dec4.asMap, \\sus, \~buses.sus4.asMap, \\rls, \~buses.rls4.asMap  
            \], target: \~synthGroup));  
        };

        // ZONE 5 (Poly)  
        if((noteNum \>= \~ccVals\[\\min5\]) and: { noteNum \<= \~ccVals\[\\max5\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone5\_Pandean, \[  
                \\out, \~busB, \\freq, freq, \\vel, vel, \\gate, 1, \\formShift, \~buses.formShift5.asMap,  
                \\zoneVol, \~buses.vol5.asMap, \\pan, \~buses.pan5.asMap, \\mute, \~buses.mute5.asMap,  
                \\hpf, \~buses.hpf5.asMap, \\lpf, \~buses.lpf5.asMap, \\rq, \~buses.rq5.asMap,  
                \\atk, \~buses.atk5.asMap, \\dec, \~buses.dec5.asMap, \\sus, \~buses.sus5.asMap, \\rls, \~buses.rls5.asMap  
            \], target: \~synthGroup));  
        };

        // ZONE 6 (Poly)  
        if((noteNum \>= \~ccVals\[\\min6\]) and: { noteNum \<= \~ccVals\[\\max6\] }) {  
            \~notes\[noteNum\] \= \~notes\[noteNum\].add(Synth(\\zone6\_Flutter, \[  
                \\out, \~busC, \\freq, freq, \\vel, vel, \\gate, 1, \\flutterSpd, \~buses.flutterSpd6.asMap,  
                \\zoneVol, \~buses.vol6.asMap, \\pan, \~buses.pan6.asMap, \\mute, \~buses.mute6.asMap,  
                \\hpf, \~buses.hpf6.asMap, \\lpf, \~buses.lpf6.asMap, \\rq, \~buses.rq6.asMap,  
                \\atk, \~buses.atk6.asMap, \\dec, \~buses.dec6.asMap, \\sus, \~buses.sus6.asMap, \\rls, \~buses.rls6.asMap  
            \], target: \~synthGroup));  
        };  
    }, srcID: \~myUid);

    MIDIdef.noteOff(\\kochoMaiOff, { |vel, noteNum|  
        if(\~notes\[noteNum\].notNil) {  
            \~notes\[noteNum\].do(\_.set(\\gate, 0));  
            \~notes\[noteNum\] \= nil;  
        };  
    }, srcID: \~myUid);

    "kocho-Mai Butterfly Ensemble Initialized.".postln;  
});  
)

// \==========================================  
// STEP 4: PAGINATED GUI GENERATION  
// \==========================================  
(  
defer {  
    var makeZone, switchTab;  
    var pages \= Array.newClear(6);  
    var tabButtons \= Array.newClear(6);  
    var zoneNames \= \["1: G. Drum", "2: H. Drum", "3: S. Flute", "4: G. Flute", "5: Pandean", "6: Flutter"\];

    if(\~kochoWin.notNil and: { \~kochoWin.isClosed.not }) { \~kochoWin.close };  
    \~ui \= ();

    \~kochoWin \= Window("kocho-Mai Butterfly Ensemble", Rect(100, 100, 460, 800));  
    \~kochoWin.view.background \= Color.fromHexString("\#2A2226");

    \~tabContainer \= CompositeView(\~kochoWin, Rect(15, 15, 430, 40)).decorator\_(FlowLayout(Rect(0,0,430,40), 0@0, 2@0));  
    \~pagesContainer \= CompositeView(\~kochoWin, Rect(15, 65, 430, 540));  
    \~fxContainer \= CompositeView(\~kochoWin, Rect(15, 615, 430, 160));

    // \--- 1\. TAB CONTROLS \---  
    switchTab \= { |idx|  
        pages.do { |p, i| if(p.notNil) { p.visible \= (i \== idx) } };  
        tabButtons.do { |b, i|  
            var textColor \= if(i \== idx, Color.black, Color.white);  
            var bgColor \= if(i \== idx, Color.fromHexString("\#FFB6C1"), Color.gray(0.3));  
            b.states\_(\[\[b.states\[0\]\[0\], textColor, bgColor\]\]);  
        };  
    };

    zoneNames.do { |name, i|  
        tabButtons\[i\] \= Button(\~tabContainer, 70@35).states\_(\[\[name, Color.white, Color.gray(0.3)\]\]).action\_({ switchTab.value(i) });  
    };

    // \--- 2\. PAGINATED ZONE BUILDER \---  
    makeZone \= { |name, idx, pageIndex, extraKnobs|  
        var box, pref, kSize;  
        var mKey, minKey, maxKey, vKey, pKey, hKey, lKey, rKey, aKey, dKey, sKey, rlsKey;  
        var rLabel, vLabel;

        pref \= idx.asString;  
        kSize \= 80@95;

        box \= CompositeView(\~pagesContainer, \~pagesContainer.bounds.moveTo(0,0));  
        box.background\_(Color.gray(0.15, 0.8)).decorator\_(FlowLayout(box.bounds, 15@15, 12@10)).visible\_(false);  
        pages\[pageIndex\] \= box;

        mKey \= ("mute"++pref).asSymbol;  
        minKey \= ("min"++pref).asSymbol;  
        maxKey \= ("max"++pref).asSymbol;  
        vKey \= ("vol"++pref).asSymbol;  
        pKey \= ("pan"++pref).asSymbol;  
        hKey \= ("hpf"++pref).asSymbol;  
        lKey \= ("lpf"++pref).asSymbol;  
        rKey \= ("rq"++pref).asSymbol;  
        aKey \= ("atk"++pref).asSymbol;  
        dKey \= ("dec"++pref).asSymbol;  
        sKey \= ("sus"++pref).asSymbol;  
        rlsKey \= ("rls"++pref).asSymbol;

        StaticText(box, 230@30).string\_("ZONE " \++ pref \++ ": " \++ name).stringColor\_(Color.fromHexString("\#FFB6C1")).font\_(Font("Arial", 16, true));  
        \~ui\[mKey\] \= Button(box, 140@30).states\_(\[  
            \["ACTIVE (CC " \++ \~cc\[mKey\] \++ ")", Color.white, Color.new255(60, 60, 60)\],  
            \["MUTED (CC " \++ \~cc\[mKey\] \++ ")", Color.white, Color.red(0.6)\]  
        \]).action\_({ |b| \~buses\[mKey\].set(b.value); \~ccVals\[mKey\] \= b.value; });

        rLabel \= "Keys (CC" \++ \~cc\[minKey\] \++ "/" \++ \~cc\[maxKey\] \++ ")";  
        \~ui\[("range"++pref).asSymbol\] \= EZRanger(box, 390@35, rLabel, \[0, 127, \\lin, 1, 0\], { |sl|  
            \~ccVals\[minKey\] \= sl.value\[0\]; \~ccVals\[maxKey\] \= sl.value\[1\];  
        }, \[\~ccVals\[minKey\], \~ccVals\[maxKey\]\], labelWidth: 100).setColors(stringColor: Color.white);

        vLabel \= "Vol (CC" \++ \~cc\[vKey\] \++ ")";  
        \~ui\[vKey\] \= EZSlider(box, 390@35, vLabel, \\amp, { |sl| \~buses\[vKey\].set(sl.value); \~ccVals\[vKey\] \= sl.value; }, \~ccVals\[vKey\], labelWidth: 80).setColors(stringColor: Color.white);

        StaticText(box, 390@8).background\_(Color.gray(0.3));

        \~ui\[pKey\] \= EZKnob(box, kSize, "Pan " \++ \~cc\[pKey\], \\bipolar, { |kn| \~buses\[pKey\].set(kn.value); \~ccVals\[pKey\] \= kn.value; }, \~ccVals\[pKey\]).setColors(stringColor: Color.white);  
        \~ui\[hKey\] \= EZKnob(box, kSize, "HPF " \++ \~cc\[hKey\], ControlSpec(20, 20000, \\exp), { |kn| \~buses\[hKey\].set(kn.value); \~ccVals\[hKey\] \= kn.value; }, \~ccVals\[hKey\]).setColors(stringColor: Color.white);  
        \~ui\[lKey\] \= EZKnob(box, kSize, "LPF " \++ \~cc\[lKey\], ControlSpec(20, 20000, \\exp), { |kn| \~buses\[lKey\].set(kn.value); \~ccVals\[lKey\] \= kn.value; }, \~ccVals\[lKey\]).setColors(stringColor: Color.white);  
        \~ui\[rKey\] \= EZKnob(box, kSize, "Res " \++ \~cc\[rKey\], ControlSpec(1.0, 0.05, \\exp), { |kn| \~buses\[rKey\].set(kn.value); \~ccVals\[rKey\] \= kn.value; }, \~ccVals\[rKey\]).setColors(stringColor: Color.white);

        \~ui\[aKey\] \= EZKnob(box, kSize, "Atk " \++ \~cc\[aKey\], ControlSpec(0.01, 10.0, \\exp), { |kn| \~buses\[aKey\].set(kn.value); \~ccVals\[aKey\] \= kn.value; }, \~ccVals\[aKey\]).setColors(stringColor: Color.green(0.8));  
        \~ui\[dKey\] \= EZKnob(box, kSize, "Dec " \++ \~cc\[dKey\], ControlSpec(0.01, 10.0, \\exp), { |kn| \~buses\[dKey\].set(kn.value); \~ccVals\[dKey\] \= kn.value; }, \~ccVals\[dKey\]).setColors(stringColor: Color.green(0.8));  
        \~ui\[sKey\] \= EZKnob(box, kSize, "Sus " \++ \~cc\[sKey\], \\amp, { |kn| \~buses\[sKey\].set(kn.value); \~ccVals\[sKey\] \= kn.value; }, \~ccVals\[sKey\]).setColors(stringColor: Color.green(0.8));  
        \~ui\[rlsKey\] \= EZKnob(box, kSize, "Rls " \++ \~cc\[rlsKey\], ControlSpec(0.01, 10.0, \\exp), { |kn| \~buses\[rlsKey\].set(kn.value); \~ccVals\[rlsKey\] \= kn.value; }, \~ccVals\[rlsKey\]).setColors(stringColor: Color.green(0.8));

        extraKnobs.value(box, kSize);  
    };

    makeZone.value("Great Drum", 1, 0, { |box, kSize|  
        \~ui\[\\resDecay1\] \= EZKnob(box, kSize, "ResDec " \++ \~cc\[\\resDecay1\], ControlSpec(0.1, 4.0, \\exp), { |kn| \~buses.resDecay1.set(kn.value); \~ccVals\[\\resDecay1\] \= kn.value; }, \~ccVals\[\\resDecay1\]).setColors(stringColor: Color.fromHexString("\#FFB6C1"));  
    });  
    makeZone.value("Hand Drum", 2, 1, { |box, kSize|  
        \~ui\[\\grainDens2\] \= EZKnob(box, kSize, "GrnDen " \++ \~cc\[\\grainDens2\], ControlSpec(1.0, 50.0, \\exp), { |kn| \~buses.grainDens2.set(kn.value); \~ccVals\[\\grainDens2\] \= kn.value; }, \~ccVals\[\\grainDens2\]).setColors(stringColor: Color.fromHexString("\#FFB6C1"));  
    });  
    makeZone.value("Small Flute", 3, 2, { |box, kSize|  
        \~ui\[\\breathAmt3\] \= EZKnob(box, kSize, "Breath " \++ \~cc\[\\breathAmt3\], \\amp, { |kn| \~buses.breathAmt3.set(kn.value); \~ccVals\[\\breathAmt3\] \= kn.value; }, \~ccVals\[\\breathAmt3\]).setColors(stringColor: Color.fromHexString("\#FFB6C1"));  
    });  
    makeZone.value("Great Flute", 4, 3, { |box, kSize|  
        \~ui\[\\harmShift4\] \= EZKnob(box, kSize, "HrmShf " \++ \~cc\[\\harmShift4\], ControlSpec(1.0, 10.0, \\exp), { |kn| \~buses.harmShift4.set(kn.value); \~ccVals\[\\harmShift4\] \= kn.value; }, \~ccVals\[\\harmShift4\]).setColors(stringColor: Color.fromHexString("\#FFB6C1"));  
    });  
    makeZone.value("Pandean", 5, 4, { |box, kSize|  
        \~ui\[\\formShift5\] \= EZKnob(box, kSize, "FrmShf " \++ \~cc\[\\formShift5\], ControlSpec(1.0, 10.0, \\exp), { |kn| \~buses.formShift5.set(kn.value); \~ccVals\[\\formShift5\] \= kn.value; }, \~ccVals\[\\formShift5\]).setColors(stringColor: Color.fromHexString("\#FFB6C1"));  
    });  
    makeZone.value("Flutter", 6, 5, { |box, kSize|  
        \~ui\[\\flutterSpd6\] \= EZKnob(box, kSize, "FlutSp " \++ \~cc\[\\flutterSpd6\], ControlSpec(0.1, 20.0, \\exp), { |kn| \~buses.flutterSpd6.set(kn.value); \~ccVals\[\\flutterSpd6\] \= kn.value; }, \~ccVals\[\\flutterSpd6\]).setColors(stringColor: Color.fromHexString("\#FFB6C1"));  
    });

    switchTab.value(0);

    // \--- 3\. BOTTOM: GLOBAL FX \---  
    \~fxContainer.background\_(Color.gray(0.12, 0.4)).decorator\_(FlowLayout(Rect(0,0,430,160), 15@10, 10@10));  
    StaticText(\~fxContainer, 400@20).string\_("ENSEMBLE EFFECTS").stringColor\_(Color.fromHexString("\#FFB6C1")).font\_(Font("Arial", 14, true)).align\_(\\center);

    \~ui\[\\mixA\] \= EZSlider(\~fxContainer, 190@30, "GrpA Mx " \++ \~cc\[\\mixA\], \\amp, { |sl| \~buses.mixA.set(sl.value); \~ccVals\[\\mixA\] \= sl.value; }, \~ccVals\[\\mixA\], labelWidth: 80).setColors(stringColor: Color.white);  
    \~ui\[\\masterVerb\] \= EZSlider(\~fxContainer, 190@30, "M.Verb " \++ \~cc\[\\masterVerb\], \\amp, { |sl| \~buses.masterVerb.set(sl.value); \~ccVals\[\\masterVerb\] \= sl.value; }, \~ccVals\[\\masterVerb\], labelWidth: 80).setColors(stringColor: Color.white);  
    \~ui\[\\mixB\] \= EZSlider(\~fxContainer, 190@30, "GrpB Mx " \++ \~cc\[\\mixB\], \\amp, { |sl| \~buses.mixB.set(sl.value); \~ccVals\[\\mixB\] \= sl.value; }, \~ccVals\[\\mixB\], labelWidth: 80).setColors(stringColor: Color.white);  
    \~ui\[\\masterDelay\] \= EZSlider(\~fxContainer, 190@30, "M.Dly Mx " \++ \~cc\[\\masterDelay\], \\amp, { |sl| \~buses.masterDelay.set(sl.value); \~ccVals\[\\masterDelay\] \= sl.value; }, \~ccVals\[\\masterDelay\], labelWidth: 80).setColors(stringColor: Color.white);  
    \~ui\[\\mixC\] \= EZSlider(\~fxContainer, 190@30, "GrpC Mx " \++ \~cc\[\\mixC\], \\amp, { |sl| \~buses.mixC.set(sl.value); \~ccVals\[\\mixC\] \= sl.value; }, \~ccVals\[\\mixC\], labelWidth: 80).setColors(stringColor: Color.white);  
    \~ui\[\\masterDelTime\] \= EZSlider(\~fxContainer, 190@30, "M.Dly Tm " \++ \~cc\[\\masterDelTime\], ControlSpec(0.05, 2.0, \\exp), { |sl| \~buses.masterDelTime.set(sl.value); \~ccVals\[\\masterDelTime\] \= sl.value; }, \~ccVals\[\\masterDelTime\], labelWidth: 80).setColors(stringColor: Color.white);

    \~kochoWin.front;

    // \--- 4\. DATA POLLING \---  
    \~guiRoutine \= Routine({  
        loop {  
            \~ui.keysValuesDo { |key, widget|  
                var pref;  
                if(widget.notNil) {  
                    if(key.asString.contains("range")) {  
                        pref \= key.asString.last.asString;  
                        widget.value \= \[\~ccVals\[("min"++pref).asSymbol\], \~ccVals\[("max"++pref).asSymbol\]\];  
                    } {  
                        widget.value \= \~ccVals\[key\];  
                    };  
                };  
            };  
            0.05.wait;  
        }  
    }).play(AppClock);

    \~kochoWin.onClose \= {  
        \~guiRoutine.stop; \~kochoWin \= nil; \~ui \= nil;  
        "GUI Closed.".postln;  
    };  
};  
)

// \==========================================  
// STEP 5: CLEANUP  
// \==========================================  
(  
if(\~kochoWin.notNil and: { \~kochoWin.isClosed.not }) { \~kochoWin.close };  
if(\~guiRoutine.notNil) { \~guiRoutine.stop };

MIDIdef.freeAll;

if(\~notes.notNil) {  
    \~notes.do({ |arr| if(arr.notNil) { arr.do(\_.set(\\gate, 0)) } });  
    \~notes \= nil;  
};

\~fxA.free; \~fxB.free; \~fxC.free; \~fxM.free;  
\~buses.keysValuesDo { |key, bus| bus.free };  
\~busA.free; \~busB.free; \~busC.free; \~masterBus.free;  
\~synthGroup.free; \~fxGroupA.free; \~fxGroupB.free; \~fxGroupC.free; \~masterGroup.free;

"kocho-Mai cleanup complete.".postln;  
)  
\`\`\`

\---

