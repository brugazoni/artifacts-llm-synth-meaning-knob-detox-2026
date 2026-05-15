

// ==========================================
// STEP 0: GLOBAL CONFIGURATION (CC MAP)
// ==========================================
(
~cc = (
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

// ==========================================
// STEP 1 & 2: DISCOVERY & CONNECTION
// ==========================================
(
MIDIClient.init;
~myInDevice = MIDIClient.sources.detect { |src| src.device == "loopMIDI Port" };

if(~myInDevice.notNil) {
    MIDIIn.connect(0, ~myInDevice);
    "MIDI IN connected successfully to: ".post; ~myInDevice.device.postln;
    ~myUid = ~myInDevice.uid;
} {
    "Warning: Target MIDI IN device not found! Listening to all ports...".warn;
    ~myUid = nil;
};
)

// ==========================================
// STEP 3: AUDIO SERVER, ROUTING & SYNTHESIS
// ==========================================
(
s.options.memSize = 131072;
s.boot;

s.waitForBoot({

    // A. CONTROL BUSES & INITIAL STATE DICTIONARY
    ~ccVals = (
        // Volumes (Conservative Headroom)
        vol1: 0.2, vol2: 0.3, vol3: 0.3, vol4: 0.2, vol5: 0.3, vol6: 0.3,
        // Panning Spread
        pan1: -0.2, pan2: 0.0, pan3: 0.2, pan4: 0.0, pan5: 0.0, pan6: 0.0,
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

    ~buses = ();
    ~ccVals.keysValuesDo { |key, val| ~buses[key] = Bus.control(s, 1).set(val) };

    // B. AUDIO ROUTING
    ~synthGroup = Group.new(s);
    ~fxGroupA = Group.after(~synthGroup);
    ~fxGroupB = Group.after(~fxGroupA);
    ~fxGroupC = Group.after(~fxGroupB);
    ~masterGroup = Group.after(~fxGroupC);

    ~busA = Bus.audio(s, 2);
    ~busB = Bus.audio(s, 2);
    ~busC = Bus.audio(s, 2);
    ~masterBus = Bus.audio(s, 2);

    // C. SYNTHDEFS

    // ZONE 1: Great Drum Resonator (Mono, Physical Modeling)
    SynthDef(\zone1_Drum, { arg out=0, freq=65.41, gate=1, vel=0.8, zoneVol=0.2, pan=(-0.2), mute=0, hpf=20, lpf=800, rq=1, atk=0.01, dec=1.0, sus=1.0, rls=2.0, resDecay=0.5;
        var lagFreq = Lag.kr(freq, 0.2);
        var env = EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);
        var exciter = EnvGen.ar(Env.perc(0.001, 0.05)) * PinkNoise.ar;
        var freqs = [1.0, 1.5, 2.3, 3.5, 4.2] * lagFreq;
        var amps = [1.0, 0.6, 0.4, 0.2, 0.1];
        var rings = [1.0, 0.8, 0.6, 0.4, 0.2] * resDecay;
        var sig = DynKlank.ar(`[freqs, amps, rings], exciter);
        sig = RLPF.ar(HPF.ar(sig, hpf), lpf, rq);
        Out.ar(out, Pan2.ar(sig, pan, env * vel * zoneVol * (1 - mute)));
    }).add;

    // ZONE 2: Hand Drum Flicker (Poly, Granular/Noise)
    SynthDef(\zone2_Flicker, { arg out=0, freq=261.6, gate=1, vel=0.8, zoneVol=0.3, pan=0, mute=0, hpf=150, lpf=5000, rq=1, atk=0.01, dec=0.5, sus=0.2, rls=0.5, grainDens=1.0;
        var env = EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);
        var trig = Dust.ar(grainDens);
        var exciter = WhiteNoise.ar * EnvGen.ar(Env.perc(0.001, 0.05), trig);
        var sig = Ringz.ar(exciter, freq, 0.1);
        sig = RLPF.ar(HPF.ar(sig, hpf), lpf, rq);
        Out.ar(out, Balance2.ar(sig, sig, pan, env * vel * zoneVol * (1 - mute)));
    }).add;

    // ZONE 3: Small Flute Breath (Poly, Subtractive)
    SynthDef(\zone3_Flute, { arg out=0, freq=523.25, gate=1, vel=0.8, zoneVol=0.3, pan=0.2, mute=0, hpf=300, lpf=10000, rq=1, atk=1.5, dec=1.0, sus=1.0, rls=2.0, breathAmt=0.0;
        var env = EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);
        var noise = BPF.ar(PinkNoise.ar, freq, 0.1) * breathAmt * 4.0;
        var sig = SinOsc.ar(freq) + noise;
        sig = RLPF.ar(HPF.ar(sig, hpf), lpf, rq);
        Out.ar(out, Balance2.ar(sig, sig, pan, env * vel * zoneVol * (1 - mute)));
    }).add;

    // ZONE 4: Great Flute Drone (Mono, FM Synthesis)
    SynthDef(\zone4_Drone, { arg out=0, freq=130.8, gate=1, vel=0.8, zoneVol=0.2, pan=0, mute=0, hpf=80, lpf=4000, rq=1, atk=0.8, dec=1.0, sus=1.0, rls=2.5, harmShift=1.0;
        var lagFreq = Lag.kr(freq, 0.3);
        var env = EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);
        var mod = SinOsc.ar(lagFreq * harmShift) * (harmShift * 300);
        var sig = SinOsc.ar(lagFreq + mod);
        sig = RLPF.ar(HPF.ar(sig, hpf), lpf, rq);
        Out.ar(out, Pan2.ar(sig, pan, env * vel * zoneVol * (1 - mute)));
    }).add;

    // ZONE 5: Pandean Whisper (Poly/Paraphonic-feel, Formant)
    SynthDef(\zone5_Pandean, { arg out=0, freq=349.2, gate=1, vel=0.8, zoneVol=0.3, pan=0, mute=0, hpf=200, lpf=8000, rq=1, atk=2.0, dec=1.0, sus=1.0, rls=3.0, formShift=1.0;
        var env = EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);
        var sig = Formant.ar(freq, freq * formShift, 400);
        sig = RLPF.ar(HPF.ar(sig, hpf), lpf, rq);
        Out.ar(out, Balance2.ar(sig, sig, pan, env * vel * zoneVol * (1 - mute)));
    }).add;

    // ZONE 6: Butterfly Flutter (Poly, Additive/Phasor)
    SynthDef(\zone6_Flutter, { arg out=0, freq=1046.5, gate=1, vel=0.8, zoneVol=0.3, pan=0, mute=0, hpf=1000, lpf=16000, rq=1, atk=0.5, dec=1.0, sus=1.0, rls=1.5, flutterSpd=0.1;
        var env = EnvGen.kr(Env.adsr(atk, dec, sus, rls), gate, doneAction: 2);
        var flutter = LFSaw.kr(flutterSpd).range(0.2, 1.0);
        var sig = Mix(Pulse.ar(freq * [1.0, 1.01, 0.99], 0.5)) * flutter * 0.3;
        sig = RLPF.ar(HPF.ar(sig, hpf), lpf, rq);
        Out.ar(out, Balance2.ar(sig, sig, pan, env * vel * zoneVol * (1 - mute)));
    }).add;

    // FX SYNTHS
    SynthDef(\fx_GroupA, { |in, out, mixBus|
        var sig = In.ar(in, 2);
        var mix = In.kr(mixBus);
        sig = Compander.ar(sig, sig, 0.5, 1.0, 0.5, 0.01, 0.1);
        sig = sig + (FreeVerb2.ar(sig[0], sig[1], mix, 0.3, 0.8) * mix);
        Out.ar(out, sig);
    }).add;

    SynthDef(\fx_GroupB, { |in, out, mixBus|
        var sig = In.ar(in, 2);
        var mix = In.kr(mixBus);
        var chor = DelayC.ar(sig, 0.05, SinOsc.kr([0.5, 0.6]).range(0.01, 0.02));
        sig = sig + (chor * 0.5);
        sig = sig + (FreeVerb2.ar(sig[0], sig[1], mix, 0.6, 0.5) * mix);
        Out.ar(out, sig);
    }).add;

    SynthDef(\fx_GroupC, { |in, out, mixBus|
        var sig = In.ar(in, 2);
        var mix = In.kr(mixBus);
        var wide = [sig[0] + (sig[1]*0.5), sig[1] + (sig[0]*0.5)] * 0.7;
        sig = sig + (FreeVerb2.ar(wide[0], wide[1], mix, 0.8, 0.2) * mix);
        Out.ar(out, sig);
    }).add;

    SynthDef(\fx_Master, { |in, out=0, verbBus, delMixBus, delTimeBus|
        var sig = In.ar(in, 2);
        var vMix = In.kr(verbBus);
        var dMix = In.kr(delMixBus);
        var dTime = Lag.kr(In.kr(delTimeBus), 0.1);
        var del;

        sig = sig + (FreeVerb2.ar(sig[0], sig[1], vMix, 0.9, 0.1) * vMix);
        del = CombC.ar(sig, 2.0, dTime, dTime * 4);
        sig = sig + (del * dMix);

        sig = HPF.ar(sig, 20);
        sig = LPF.ar(sig, 18000);
        sig = Limiter.ar(sig, 0.95, 0.01);
        Out.ar(out, sig);
    }).add;

    s.sync;

    // D. INSTANTIATE EFFECTS
    ~fxA = Synth(\fx_GroupA, [\in, ~busA, \out, ~masterBus, \mixBus, ~buses.mixA], ~fxGroupA, \addToTail);
    ~fxB = Synth(\fx_GroupB, [\in, ~busB, \out, ~masterBus, \mixBus, ~buses.mixB], ~fxGroupB, \addToTail);
    ~fxC = Synth(\fx_GroupC, [\in, ~busC, \out, ~masterBus, \mixBus, ~buses.mixC], ~fxGroupC, \addToTail);
    ~fxM = Synth(\fx_Master, [\in, ~masterBus, \out, 0, \verbBus, ~buses.masterVerb, \delMixBus, ~buses.masterDelay, \delTimeBus, ~buses.masterDelTime], ~masterGroup, \addToTail);

    // E. SYNTH STATE & MIDI
    ~notes = Array.newClear(128);

    MIDIdef.cc(\kochoMaiCC, { |val, num|
        var mapped = val / 127.0;
        ~cc.keysValuesDo { |key, ccNum|
            if(num == ccNum) {
                var kStr = key.asString;
                var finalVal = case
                    { kStr.matchRegexp("hpf") } { mapped.linexp(0, 1, 20, 20000) }
                    { kStr.matchRegexp("lpf") } { mapped.linexp(0, 1, 20, 20000) }
                    { kStr.contains("rq") } { mapped.linexp(0, 1, 1.0, 0.05) }
                    { kStr.contains("pan") } { mapped.linlin(0, 1, -1.0, 1.0) }
                    { kStr.matchRegexp("atk|dec|sus|rls") } { mapped.linexp(0, 1, 0.01, 10.0) }
                    { kStr.matchRegexp("min|max") } { val }
                    { kStr.contains("mute") } { (val > 63).asInteger }
                    { key == \resDecay1 } { mapped.linexp(0, 1, 0.1, 4.0) }
                    { key == \grainDens2 } { mapped.linexp(0, 1, 1.0, 50.0) }
                    { key == \breathAmt3 } { mapped }
                    { key == \harmShift4 } { mapped.linexp(0, 1, 1.0, 10.0) }
                    { key == \formShift5 } { mapped.linexp(0, 1, 1.0, 10.0) }
                    { key == \flutterSpd6 } { mapped.linexp(0, 1, 0.1, 20.0) }
                    { key == \masterDelTime } { mapped.linexp(0, 1, 0.05, 2.0) }
                    { mapped }; // Default for vol, mixes

                ~ccVals[key] = finalVal;
                if(~buses[key].notNil) { ~buses[key].set(finalVal) };
            };
        };
    }, srcID: ~myUid);

    MIDIdef.noteOn(\kochoMaiOn, { |velRaw, noteNum|
        var freq = noteNum.midicps;
        var vel = velRaw / 127.0;

        if(~notes[noteNum].notNil) { ~notes[noteNum].do(_.set(\gate, 0)) };
        ~notes[noteNum] = [];

        // ZONE 1 (Mono - Kill previous Z1 synths)
        if((noteNum >= ~ccVals[\min1]) and: { noteNum <= ~ccVals[\max1] }) {
            ~notes.do { |arr| if(arr.notNil) { arr.do { |syn| if(syn.defName == \zone1_Drum) { syn.set(\gate, 0) } } } };
            ~notes[noteNum] = ~notes[noteNum].add(Synth(\zone1_Drum, [
                \out, ~busA, \freq, freq, \vel, vel, \gate, 1, \resDecay, ~buses.resDecay1.asMap,
                \zoneVol, ~buses.vol1.asMap, \pan, ~buses.pan1.asMap, \mute, ~buses.mute1.asMap,
                \hpf, ~buses.hpf1.asMap, \lpf, ~buses.lpf1.asMap, \rq, ~buses.rq1.asMap,
                \atk, ~buses.atk1.asMap, \dec, ~buses.dec1.asMap, \sus, ~buses.sus1.asMap, \rls, ~buses.rls1.asMap
            ], target: ~synthGroup));
        };

        // ZONE 2 (Poly)
        if((noteNum >= ~ccVals[\min2]) and: { noteNum <= ~ccVals[\max2] }) {
            ~notes[noteNum] = ~notes[noteNum].add(Synth(\zone2_Flicker, [
                \out, ~busA, \freq, freq, \vel, vel, \gate, 1, \grainDens, ~buses.grainDens2.asMap,
                \zoneVol, ~buses.vol2.asMap, \pan, ~buses.pan2.asMap, \mute, ~buses.mute2.asMap,
                \hpf, ~buses.hpf2.asMap, \lpf, ~buses.lpf2.asMap, \rq, ~buses.rq2.asMap,
                \atk, ~buses.atk2.asMap, \dec, ~buses.dec2.asMap, \sus, ~buses.sus2.asMap, \rls, ~buses.rls2.asMap
            ], target: ~synthGroup));
        };

        // ZONE 3 (Poly)
        if((noteNum >= ~ccVals[\min3]) and: { noteNum <= ~ccVals[\max3] }) {
            ~notes[noteNum] = ~notes[noteNum].add(Synth(\zone3_Flute, [
                \out, ~busB, \freq, freq, \vel, vel, \gate, 1, \breathAmt, ~buses.breathAmt3.asMap,
                \zoneVol, ~buses.vol3.asMap, \pan, ~buses.pan3.asMap, \mute, ~buses.mute3.asMap,
                \hpf, ~buses.hpf3.asMap, \lpf, ~buses.lpf3.asMap, \rq, ~buses.rq3.asMap,
                \atk, ~buses.atk3.asMap, \dec, ~buses.dec3.asMap, \sus, ~buses.sus3.asMap, \rls, ~buses.rls3.asMap
            ], target: ~synthGroup));
        };

        // ZONE 4 (Mono - Kill previous Z4 synths)
        if((noteNum >= ~ccVals[\min4]) and: { noteNum <= ~ccVals[\max4] }) {
            ~notes.do { |arr| if(arr.notNil) { arr.do { |syn| if(syn.defName == \zone4_Drone) { syn.set(\gate, 0) } } } };
            ~notes[noteNum] = ~notes[noteNum].add(Synth(\zone4_Drone, [
                \out, ~busB, \freq, freq, \vel, vel, \gate, 1, \harmShift, ~buses.harmShift4.asMap,
                \zoneVol, ~buses.vol4.asMap, \pan, ~buses.pan4.asMap, \mute, ~buses.mute4.asMap,
                \hpf, ~buses.hpf4.asMap, \lpf, ~buses.lpf4.asMap, \rq, ~buses.rq4.asMap,
                \atk, ~buses.atk4.asMap, \dec, ~buses.dec4.asMap, \sus, ~buses.sus4.asMap, \rls, ~buses.rls4.asMap
            ], target: ~synthGroup));
        };

        // ZONE 5 (Poly)
        if((noteNum >= ~ccVals[\min5]) and: { noteNum <= ~ccVals[\max5] }) {
            ~notes[noteNum] = ~notes[noteNum].add(Synth(\zone5_Pandean, [
                \out, ~busB, \freq, freq, \vel, vel, \gate, 1, \formShift, ~buses.formShift5.asMap,
                \zoneVol, ~buses.vol5.asMap, \pan, ~buses.pan5.asMap, \mute, ~buses.mute5.asMap,
                \hpf, ~buses.hpf5.asMap, \lpf, ~buses.lpf5.asMap, \rq, ~buses.rq5.asMap,
                \atk, ~buses.atk5.asMap, \dec, ~buses.dec5.asMap, \sus, ~buses.sus5.asMap, \rls, ~buses.rls5.asMap
            ], target: ~synthGroup));
        };

        // ZONE 6 (Poly)
        if((noteNum >= ~ccVals[\min6]) and: { noteNum <= ~ccVals[\max6] }) {
            ~notes[noteNum] = ~notes[noteNum].add(Synth(\zone6_Flutter, [
                \out, ~busC, \freq, freq, \vel, vel, \gate, 1, \flutterSpd, ~buses.flutterSpd6.asMap,
                \zoneVol, ~buses.vol6.asMap, \pan, ~buses.pan6.asMap, \mute, ~buses.mute6.asMap,
                \hpf, ~buses.hpf6.asMap, \lpf, ~buses.lpf6.asMap, \rq, ~buses.rq6.asMap,
                \atk, ~buses.atk6.asMap, \dec, ~buses.dec6.asMap, \sus, ~buses.sus6.asMap, \rls, ~buses.rls6.asMap
            ], target: ~synthGroup));
        };
    }, srcID: ~myUid);

    MIDIdef.noteOff(\kochoMaiOff, { |vel, noteNum|
        if(~notes[noteNum].notNil) {
            ~notes[noteNum].do(_.set(\gate, 0));
            ~notes[noteNum] = nil;
        };
    }, srcID: ~myUid);

    "kocho-Mai Butterfly Ensemble Initialized.".postln;
});
)

// ==========================================
// STEP 4: PAGINATED GUI GENERATION
// ==========================================
(
defer {
    var makeZone, switchTab;
    var pages = Array.newClear(6);
    var tabButtons = Array.newClear(6);
    var zoneNames = ["1: G. Drum", "2: H. Drum", "3: S. Flute", "4: G. Flute", "5: Pandean", "6: Flutter"];

    if(~kochoWin.notNil and: { ~kochoWin.isClosed.not }) { ~kochoWin.close };
    ~ui = ();

    ~kochoWin = Window("kocho-Mai Butterfly Ensemble", Rect(100, 100, 460, 800));
    ~kochoWin.view.background = Color.fromHexString("#2A2226");

    ~tabContainer = CompositeView(~kochoWin, Rect(15, 15, 430, 40)).decorator_(FlowLayout(Rect(0,0,430,40), 0@0, 2@0));
    ~pagesContainer = CompositeView(~kochoWin, Rect(15, 65, 430, 540));
    ~fxContainer = CompositeView(~kochoWin, Rect(15, 615, 430, 160));

    // --- 1. TAB CONTROLS ---
    switchTab = { |idx|
        pages.do { |p, i| if(p.notNil) { p.visible = (i == idx) } };
        tabButtons.do { |b, i|
            var textColor = if(i == idx, Color.black, Color.white);
            var bgColor = if(i == idx, Color.fromHexString("#FFB6C1"), Color.gray(0.3));
            b.states_([[b.states[0][0], textColor, bgColor]]);
        };
    };

    zoneNames.do { |name, i|
        tabButtons[i] = Button(~tabContainer, 70@35).states_([[name, Color.white, Color.gray(0.3)]]).action_({ switchTab.value(i) });
    };

    // --- 2. PAGINATED ZONE BUILDER ---
    makeZone = { |name, idx, pageIndex, extraKnobs|
        var box, pref, kSize;
        var mKey, minKey, maxKey, vKey, pKey, hKey, lKey, rKey, aKey, dKey, sKey, rlsKey;
        var rLabel, vLabel;

        pref = idx.asString;
        kSize = 80@95;

        box = CompositeView(~pagesContainer, ~pagesContainer.bounds.moveTo(0,0));
        box.background_(Color.gray(0.15, 0.8)).decorator_(FlowLayout(box.bounds, 15@15, 12@10)).visible_(false);
        pages[pageIndex] = box;

        mKey = ("mute"++pref).asSymbol;
        minKey = ("min"++pref).asSymbol;
        maxKey = ("max"++pref).asSymbol;
        vKey = ("vol"++pref).asSymbol;
        pKey = ("pan"++pref).asSymbol;
        hKey = ("hpf"++pref).asSymbol;
        lKey = ("lpf"++pref).asSymbol;
        rKey = ("rq"++pref).asSymbol;
        aKey = ("atk"++pref).asSymbol;
        dKey = ("dec"++pref).asSymbol;
        sKey = ("sus"++pref).asSymbol;
        rlsKey = ("rls"++pref).asSymbol;

        StaticText(box, 230@30).string_("ZONE " ++ pref ++ ": " ++ name).stringColor_(Color.fromHexString("#FFB6C1")).font_(Font("Arial", 16, true));
        ~ui[mKey] = Button(box, 140@30).states_([
            ["ACTIVE (CC " ++ ~cc[mKey] ++ ")", Color.white, Color.new255(60, 60, 60)],
            ["MUTED (CC " ++ ~cc[mKey] ++ ")", Color.white, Color.red(0.6)]
        ]).action_({ |b| ~buses[mKey].set(b.value); ~ccVals[mKey] = b.value; });

        rLabel = "Keys (CC" ++ ~cc[minKey] ++ "/" ++ ~cc[maxKey] ++ ")";
        ~ui[("range"++pref).asSymbol] = EZRanger(box, 390@35, rLabel, [0, 127, \lin, 1, 0], { |sl|
            ~ccVals[minKey] = sl.value[0]; ~ccVals[maxKey] = sl.value[1];
        }, [~ccVals[minKey], ~ccVals[maxKey]], labelWidth: 100).setColors(stringColor: Color.white);

        vLabel = "Vol (CC" ++ ~cc[vKey] ++ ")";
        ~ui[vKey] = EZSlider(box, 390@35, vLabel, \amp, { |sl| ~buses[vKey].set(sl.value); ~ccVals[vKey] = sl.value; }, ~ccVals[vKey], labelWidth: 80).setColors(stringColor: Color.white);

        StaticText(box, 390@8).background_(Color.gray(0.3));

        ~ui[pKey] = EZKnob(box, kSize, "Pan " ++ ~cc[pKey], \bipolar, { |kn| ~buses[pKey].set(kn.value); ~ccVals[pKey] = kn.value; }, ~ccVals[pKey]).setColors(stringColor: Color.white);
        ~ui[hKey] = EZKnob(box, kSize, "HPF " ++ ~cc[hKey], ControlSpec(20, 20000, \exp), { |kn| ~buses[hKey].set(kn.value); ~ccVals[hKey] = kn.value; }, ~ccVals[hKey]).setColors(stringColor: Color.white);
        ~ui[lKey] = EZKnob(box, kSize, "LPF " ++ ~cc[lKey], ControlSpec(20, 20000, \exp), { |kn| ~buses[lKey].set(kn.value); ~ccVals[lKey] = kn.value; }, ~ccVals[lKey]).setColors(stringColor: Color.white);
        ~ui[rKey] = EZKnob(box, kSize, "Res " ++ ~cc[rKey], ControlSpec(1.0, 0.05, \exp), { |kn| ~buses[rKey].set(kn.value); ~ccVals[rKey] = kn.value; }, ~ccVals[rKey]).setColors(stringColor: Color.white);

        ~ui[aKey] = EZKnob(box, kSize, "Atk " ++ ~cc[aKey], ControlSpec(0.01, 10.0, \exp), { |kn| ~buses[aKey].set(kn.value); ~ccVals[aKey] = kn.value; }, ~ccVals[aKey]).setColors(stringColor: Color.green(0.8));
        ~ui[dKey] = EZKnob(box, kSize, "Dec " ++ ~cc[dKey], ControlSpec(0.01, 10.0, \exp), { |kn| ~buses[dKey].set(kn.value); ~ccVals[dKey] = kn.value; }, ~ccVals[dKey]).setColors(stringColor: Color.green(0.8));
        ~ui[sKey] = EZKnob(box, kSize, "Sus " ++ ~cc[sKey], \amp, { |kn| ~buses[sKey].set(kn.value); ~ccVals[sKey] = kn.value; }, ~ccVals[sKey]).setColors(stringColor: Color.green(0.8));
        ~ui[rlsKey] = EZKnob(box, kSize, "Rls " ++ ~cc[rlsKey], ControlSpec(0.01, 10.0, \exp), { |kn| ~buses[rlsKey].set(kn.value); ~ccVals[rlsKey] = kn.value; }, ~ccVals[rlsKey]).setColors(stringColor: Color.green(0.8));

        extraKnobs.value(box, kSize);
    };

    makeZone.value("Great Drum", 1, 0, { |box, kSize|
        ~ui[\resDecay1] = EZKnob(box, kSize, "ResDec " ++ ~cc[\resDecay1], ControlSpec(0.1, 4.0, \exp), { |kn| ~buses.resDecay1.set(kn.value); ~ccVals[\resDecay1] = kn.value; }, ~ccVals[\resDecay1]).setColors(stringColor: Color.fromHexString("#FFB6C1"));
    });
    makeZone.value("Hand Drum", 2, 1, { |box, kSize|
        ~ui[\grainDens2] = EZKnob(box, kSize, "GrnDen " ++ ~cc[\grainDens2], ControlSpec(1.0, 50.0, \exp), { |kn| ~buses.grainDens2.set(kn.value); ~ccVals[\grainDens2] = kn.value; }, ~ccVals[\grainDens2]).setColors(stringColor: Color.fromHexString("#FFB6C1"));
    });
    makeZone.value("Small Flute", 3, 2, { |box, kSize|
        ~ui[\breathAmt3] = EZKnob(box, kSize, "Breath " ++ ~cc[\breathAmt3], \amp, { |kn| ~buses.breathAmt3.set(kn.value); ~ccVals[\breathAmt3] = kn.value; }, ~ccVals[\breathAmt3]).setColors(stringColor: Color.fromHexString("#FFB6C1"));
    });
    makeZone.value("Great Flute", 4, 3, { |box, kSize|
        ~ui[\harmShift4] = EZKnob(box, kSize, "HrmShf " ++ ~cc[\harmShift4], ControlSpec(1.0, 10.0, \exp), { |kn| ~buses.harmShift4.set(kn.value); ~ccVals[\harmShift4] = kn.value; }, ~ccVals[\harmShift4]).setColors(stringColor: Color.fromHexString("#FFB6C1"));
    });
    makeZone.value("Pandean", 5, 4, { |box, kSize|
        ~ui[\formShift5] = EZKnob(box, kSize, "FrmShf " ++ ~cc[\formShift5], ControlSpec(1.0, 10.0, \exp), { |kn| ~buses.formShift5.set(kn.value); ~ccVals[\formShift5] = kn.value; }, ~ccVals[\formShift5]).setColors(stringColor: Color.fromHexString("#FFB6C1"));
    });
    makeZone.value("Flutter", 6, 5, { |box, kSize|
        ~ui[\flutterSpd6] = EZKnob(box, kSize, "FlutSp " ++ ~cc[\flutterSpd6], ControlSpec(0.1, 20.0, \exp), { |kn| ~buses.flutterSpd6.set(kn.value); ~ccVals[\flutterSpd6] = kn.value; }, ~ccVals[\flutterSpd6]).setColors(stringColor: Color.fromHexString("#FFB6C1"));
    });

    switchTab.value(0);

    // --- 3. BOTTOM: GLOBAL FX ---
    ~fxContainer.background_(Color.gray(0.12, 0.4)).decorator_(FlowLayout(Rect(0,0,430,160), 15@10, 10@10));
    StaticText(~fxContainer, 400@20).string_("ENSEMBLE EFFECTS").stringColor_(Color.fromHexString("#FFB6C1")).font_(Font("Arial", 14, true)).align_(\center);

    ~ui[\mixA] = EZSlider(~fxContainer, 190@30, "GrpA Mx " ++ ~cc[\mixA], \amp, { |sl| ~buses.mixA.set(sl.value); ~ccVals[\mixA] = sl.value; }, ~ccVals[\mixA], labelWidth: 80).setColors(stringColor: Color.white);
    ~ui[\masterVerb] = EZSlider(~fxContainer, 190@30, "M.Verb " ++ ~cc[\masterVerb], \amp, { |sl| ~buses.masterVerb.set(sl.value); ~ccVals[\masterVerb] = sl.value; }, ~ccVals[\masterVerb], labelWidth: 80).setColors(stringColor: Color.white);
    ~ui[\mixB] = EZSlider(~fxContainer, 190@30, "GrpB Mx " ++ ~cc[\mixB], \amp, { |sl| ~buses.mixB.set(sl.value); ~ccVals[\mixB] = sl.value; }, ~ccVals[\mixB], labelWidth: 80).setColors(stringColor: Color.white);
    ~ui[\masterDelay] = EZSlider(~fxContainer, 190@30, "M.Dly Mx " ++ ~cc[\masterDelay], \amp, { |sl| ~buses.masterDelay.set(sl.value); ~ccVals[\masterDelay] = sl.value; }, ~ccVals[\masterDelay], labelWidth: 80).setColors(stringColor: Color.white);
    ~ui[\mixC] = EZSlider(~fxContainer, 190@30, "GrpC Mx " ++ ~cc[\mixC], \amp, { |sl| ~buses.mixC.set(sl.value); ~ccVals[\mixC] = sl.value; }, ~ccVals[\mixC], labelWidth: 80).setColors(stringColor: Color.white);
    ~ui[\masterDelTime] = EZSlider(~fxContainer, 190@30, "M.Dly Tm " ++ ~cc[\masterDelTime], ControlSpec(0.05, 2.0, \exp), { |sl| ~buses.masterDelTime.set(sl.value); ~ccVals[\masterDelTime] = sl.value; }, ~ccVals[\masterDelTime], labelWidth: 80).setColors(stringColor: Color.white);

    ~kochoWin.front;

    // --- 4. DATA POLLING ---
    ~guiRoutine = Routine({
        loop {
            ~ui.keysValuesDo { |key, widget|
                var pref;
                if(widget.notNil) {
                    if(key.asString.contains("range")) {
                        pref = key.asString.last.asString;
                        widget.value = [~ccVals[("min"++pref).asSymbol], ~ccVals[("max"++pref).asSymbol]];
                    } {
                        widget.value = ~ccVals[key];
                    };
                };
            };
            0.05.wait;
        }
    }).play(AppClock);

    ~kochoWin.onClose = {
        ~guiRoutine.stop; ~kochoWin = nil; ~ui = nil;
        "GUI Closed.".postln;
    };
};
)

// ==========================================
// STEP 5: CLEANUP
// ==========================================
(
if(~kochoWin.notNil and: { ~kochoWin.isClosed.not }) { ~kochoWin.close };
if(~guiRoutine.notNil) { ~guiRoutine.stop };

MIDIdef.freeAll;

if(~notes.notNil) {
    ~notes.do({ |arr| if(arr.notNil) { arr.do(_.set(\gate, 0)) } });
    ~notes = nil;
};

~fxA.free; ~fxB.free; ~fxC.free; ~fxM.free;
~buses.keysValuesDo { |key, bus| bus.free };
~busA.free; ~busB.free; ~busC.free; ~masterBus.free;
~synthGroup.free; ~fxGroupA.free; ~fxGroupB.free; ~fxGroupC.free; ~masterGroup.free;

"kocho-Mai cleanup complete.".postln;
)