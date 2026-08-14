# Episode #1699 LFSR Random Number Generator (White Noise)

LFSR - Linear Feedback Shift Register

LFSR Random Number Generator (White Noise) https://www.youtube.com/watch?v=WGhRAbQ1fRw

<br>

# BitDemo

Uses 24-bit LFSR like 3 595 shift registers in series, outputs 1 bit value.

<img src="doc/bitdemo.jpg" alt="pin_out  random output on scope" width="800">
<br>
<br>

# LedsDemo

Outputs LFSR lower bits into 10 DE0 onboard LEDs.

<video width="640" height="360" controls>
  <source src="doc/CAM00626-ed.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
<br><br>

# VgaDemo

Useful for any video output implementation for first time live testing, to be sure RGB outputs are not stuck or wired to wrong signals.<br>
For better non-repeative randomness uses 32 bits LFSR.

<img src="doc/CAM00622-ed.jpg" alt="black-white static noise on screen" width="1100">
