<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 64
nchnls = 2
0dbfs = 1

giPortHandle OSCinit 57120
giNumBands init 51

//Cursor Values
gknote[] init giNumBands
gkdetune[] init giNumBands
gkamps[] init giNumBands
gktranspose[] init giNumBands
gkcutoff[] init giNumBands
gkreso[] init giNumBands
gklineperc[] init giNumBands

//Trigger Values
gktrigNote init 0

//Note Arrays
giNotes[] fillarray -3, 0, 4, 7, 11, 14, 16
giNotelen lenarray giNotes
//giTranspose[] fillarray 0, 12, 24, 36
giTranspose[] fillarray 0, 7, 12, 19, 24, 31, 36
giTranLen lenarray giTranspose

//Default Globals
giMIDIRoot = 30
giDetuneAmt = 12 //in cents

//Wavetable
giTri ftgen 0, 0, 512, 10, 1, 1/2, 1/3, 1/4, 1/5, 0, 1/7, 0, 1/9


//Trigger Listener
instr 1
	ktid init 0
	ktval init 0

	kGotTrig OSClisten giPortHandle, "/trigger", "ff", ktid, ktval
	ktrig changed ktval

kcount init 0
seed 0
if(ktrig = 1) then
	kcount += 1
	if(kcount = int(giNumBands * 2.1)) then
		krand random -3, 3
		ktrigMIDI = int(krand)
		gktrigNote += ktrigMIDI
		kcount = 0
	endif
endif

endin

//Cursor Listener
instr 2
	kid init 0
	kx init 0
	ky init 0
	kz init 0
	klineperc init 0
	kidA[] init giNumBands
	kxA[] init giNumBands 
	kyA[] init giNumBands
	kzA[] init giNumBands
	klp[] init giNumBands
	
nxtmsg:
	kGotIt OSClisten giPortHandle, "/cursor", "fffff", kid, kx, ky, kz, klineperc
	if(kGotIt == 0) goto exit
	
		iportkTime = .01
	
;		kxPort portk kx, iportkTime
;		kyPort portk ky, iportkTime
;		kzPort portk kz, iportkTime
;		klpPort portk klineperc, iportkTime
		
		kxA[kid-1001] = kx
		kyA[kid-1001] = ky
		kzA[kid-1001] = kz
		klp[kid-1001] = klineperc
		
	kgoto nxtmsg
exit:

kcount = 0

while kcount < giNumBands do
	gknote[kcount] = int(kxA[kcount] * (giNotelen -1) + 0.5)
	gktranspose[kcount] = int(kzA[kcount] * (giTranLen - 1) + 0.5)
	gkdetune[kcount] = kyA[kcount] * giDetuneAmt * 2 - giDetuneAmt
	gkamps[kcount]  = kzA[kcount]
	gkcutoff[kcount] = kyA[kcount]^3 * 9000
	gkreso[kcount] = klp[kcount] * .95
	kcount = kcount + 1
od
endin

instr 3
ipan = p4/giNumBands-1

ktrigNote = gktrigNote
ktrigFreq portk gktrigNote, 2

kfreq = cpsmidinn(giMIDIRoot + giNotes[gknote[p4]] +giTranspose[gktranspose[p4]] + ktrigFreq)
kdetuned = kfreq * 2^(gkdetune[p4]/1200)

aosc oscili gkamps[p4], kdetuned, giTri
aosc/=giNumBands
afilt moogladder aosc, gkcutoff[p4], gkreso[p4]

a1, a2 pan2 afilt, ipan
outs a1, a2

if(p4 + 1 < giNumBands) then
	schedule(3, 0, p3, p4+1)
endif
endin

</CsInstruments>
<CsScore>
i1 0 1000
i2 0 1000
i3 0 1000 0

</CsScore>
</CsoundSynthesizer>














































<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>0</width>
 <height>0</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
