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

<img src="doc/CAM00625-ed.jpg" alt="pin_out  random output on scope" width="800">
<br>

Video demo:
https://github.com/user-attachments/assets/c27f9ea6-12c2-4042-8be1-6437bfb8a787
<br><br>

# VgaDemo

Useful for any video output implementation for first time live testing, to be sure RGB outputs are not stuck or wired to wrong signals.<br>
For better non-repeative randomness uses 32 bits LFSR.

<img src="doc/CAM00622-ed.jpg" alt="black-white static noise on screen" width="1100">
