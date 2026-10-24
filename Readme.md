# Multifunctional Sports Stopwatch on FPGA

A digital sports stopwatch written in Verilog for an **Arty Z7 (Xilinx Zynq-7020)**, with **10 ms resolution**, lap memory, pause/resume and manual time adjustment. It drives a **scanned 12-digit seven-segment display** and a **20×4 character LCD**.

> Course project — Logic Design, Computer Engineering, HCMUT.

---

## Overview

The design is a hierarchy of small, single-purpose modules rather than one large state machine: **27 modules**, six levels deep at its deepest path, with `DEBOUNCE_BTN` reused in five places. Every module has an explicit port list, and every bus in the block diagrams carries its width, so each diagram reads port-for-port against its module.

**Top-level interface**

| Signal | Width | Direction | Role |
|---|---|---|---|
| `ckht` | 1 | in | System clock — 125 MHz on Arty Z7 |
| `btn0` | 1 | in | Reset |
| `btn1` / `btn3` | 1 | in | Adjust up / down |
| `btn2` | 1 | in | Mode select |
| `btn4` | 1 | in | Pause / resume |
| `btn5` | 1 | in | Save lap |
| `sw[1:0]` | 2 | in | Counting rate select |
| `sseg` | 8 | out | Seven-segment data, `{dp,g,f,e,d,c,b,a}` |
| `cathode` | 12 | out | Seven-segment digit scan, one-hot |
| `lcd_db` | 8 | out | LCD data bus |
| `lcd_rs`, `lcd_e`, `lcd_p` | 1 | out | LCD control |

---

## Top-level architecture

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/01-top-level-dark.png">
  <img alt="Top-level block diagram" src="docs/01-top-level.png">
</picture>

| Module | Role |
|---|---|
| `Chia_10ena` | Clock divider — produces `ena1hz`, `ena2hz`, `ena5hz`, `ena20hz`, `ena50hz`, `ena100hz`, `ena1khz` |
| `Dahop_4kenh_1bit` | 4:1 multiplexer — picks the counting tick from `sw[1:0]` |
| `DEM_GPGPT_NN` | Time counter — hundredths, seconds, minutes, hours |
| `HEX_TO_BCD` | Splits each 7-bit time field into two BCD digits |
| `GM_HT_12LED` | Scanned seven-segment display driver |
| `LCD_Data_Transfer` | Packs BCD digits into LCD character data |
| `LCD_Transfer` | LCD controller driver |

**One design decision worth calling out:** the counting tick is selectable at run time. The divider offers several enable rates and the multiplexer picks which one becomes `ena_db`, the tick that advances the hundredths counter:

| `sw[1:0]` | `ena_db` | Effect |
|---|---|---|
| `00` | 1 Hz | Hundredths advance once per second — slow motion |
| `01` | 20 Hz | 5× slow |
| `10` | 50 Hz | 2× slow |
| `11` | 100 Hz | **Real time** — 10 ms resolution |

The same bitstream therefore runs either as a working stopwatch or as a slow-motion demonstrator, which makes the carry chain through hundredths → seconds → minutes → hours visible without a logic analyser.

---

## Module hierarchy

```
DONG_HO_THE_THAO
├── Chia_10ena                      clock divider
│   └── Chia_10
├── Dahop_4kenh_1bit                4:1 mux — counting rate select
├── DEM_GPGPT_NN                    time counter
│   ├── DEBOUNCE_BTN  ×3            up / down / pause
│   ├── XULY_MOD_DC                 mode and decimal-point handling
│   │   ├── DEM_MOD_20_NN           digit blink + adjust-mode timeout
│   │   ├── DEM_2BIT_BTN            mode counter 0 → 1 → 2 → 3
│   │   │   ├── Cd_lam_hep_btn      debounce then edge-detect
│   │   │   │   ├── DEBOUNCE_BTN
│   │   │   │   └── Lam_hep_xung
│   │   │   └── Dem_2bit
│   │   └── DAUCHAM                 decimal-point mask per mode
│   └── DEM_TT_MUD                  counter core
├── HEX_TO_BCD
│   └── sohex7bit     ×4            one per time field
├── GM_HT_12LED                     seven-segment scan driver
│   ├── DEM_4BIT                    scan counter
│   ├── DAHOP_12KENH                12:1 digit mux
│   ├── DAHOP_12DC                  12:1 decimal-point mux
│   ├── DAHOP_12ENA                 12:1 digit-enable mux
│   ├── GIAIMA_7DOAN_ENA_DP         BCD → seven-segment decoder
│   └── GIAIMA_4_12H                4 → 12 digit-select decoder
├── LCD_Data_Transfer
└── LCD_Transfer
    ├── DEBOUNCE_BTN                lap-save button
    ├── LCD_GAN_DULIEU              builds four 160-bit display lines
    └── LCD_HIENTHI                 LCD timing and transfer
```

---

## Time counter — `DEM_GPGPT_NN`

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/02-dem-gpgpt-nn-dark.png">
  <img alt="Time counter block diagram" src="docs/02-dem-gpgpt-nn.png">
</picture>

Three `DEBOUNCE_BTN` instances filter the up, down and pause buttons before anything downstream sees them. `XULY_MOD_DC` handles mode selection and the decimal-point pattern; `DEM_TT_MUD` is the counter core, producing four 7-bit fields — `ptgiay`, `giay`, `phut`, `gio`.

Up and down use the debouncer's *level* output gated by `ena5hz`, so holding a button auto-repeats at 5 Hz. Pause needs one toggle per press instead, so the edge detection for it belongs inside `DEM_TT_MUD`.

### Mode and decimal point — `XULY_MOD_DC`

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/03-xuly-mod-dc-dark.png">
  <img alt="Mode and decimal-point block diagram" src="docs/03-xuly-mod-dc.png">
</picture>

`DEM_2BIT_BTN` turns mode-button presses into a 2-bit mode code. `DEM_MOD_20_NN` blinks the pair of digits being adjusted at 2 Hz, and counts ticks of inactivity so the adjust mode times out on its own. `DAUCHAM` maps the mode to the 12-bit decimal-point mask, lighting the dot on the units digit of whichever field is being adjusted.

---

## Seven-segment driver — `GM_HT_12LED`

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/04-gm-ht-12led-dark.png">
  <img alt="Seven-segment driver block diagram" src="docs/04-gm-ht-12led.png">
</picture>

`DEM_4BIT`, a scan counter clocked by `ena1khz`, drives three parallel 12:1 multiplexers — one for the digit value, one for the decimal point, one for the digit enable. The selected digit goes through `GIAIMA_7DOAN_ENA_DP` to produce `sseg[7:0]`, while `GIAIMA_4_12H` expands the scan index into the 12-bit `cathode` select.

Scanning at 1 kHz refreshes each of the twelve digits about 83 times per second, above the flicker threshold.

**Digit map.** The diagram leaves `led_72`, `led_75`, `led_78` and `led_81` unconnected, so the blank separators sit at indices 2, 5, 8 and 11:

| index | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| | ptg | ptg | — | sec | sec | — | min | min | — | hr | hr | — |

Physical left-to-right order is fixed by the constraints file rather than by the RTL. `cathode[0]` has to be the rightmost digit, otherwise the display reads backwards.

---

## BCD conversion — `HEX_TO_BCD`

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/05-hex-to-bcd-dark.png">
  <img alt="Binary to BCD block diagram" src="docs/05-hex-to-bcd.png">
</picture>

Four identical `sohex7bit` instances, one per time field. Each takes a 7-bit binary value and splits it into tens (`chuc`) and units (`donvi`), 4 bits each, by double dabble — seven shifts with the add-3 correction applied after the first six.

---

## LCD path — `LCD_Transfer`

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/06-lcd-transfer-dark.png">
  <img alt="LCD path block diagram" src="docs/06-lcd-transfer.png">
</picture>

`LCD_GAN_DULIEU` assembles four 160-bit lines — 20 characters × 8 bits each, matching the 20×4 display — with line 0 holding a fixed title and lines 1–3 acting as a three-deep shift register of saved laps. `LCD_HIENTHI` drives the HD44780 power-on initialisation sequence and the data/command protocol on `lcd_db`, `lcd_rs`, `lcd_e` and `lcd_p`.

---

## Notes for board bring-up

The programmable logic on Arty Z7 is clocked by the **125 MHz** Ethernet reference on pin **H16**, so the divider constants have to be sized for that.

Arty Z7 has no seven-segment display, no character LCD, and only four buttons and two switches on board, while this design needs **39 user I/O pins** — 6 buttons, 2 switches, 8 segment lines, 12 digit-select lines, 8 LCD data lines and 3 LCD control lines. Everything except the clock has to come out through the Pmod headers.

Three things to settle when writing the constraints:

1. **Polarity.** The RTL drives `sseg` and `cathode` active-high. Common-anode displays need both inverted.
2. **Digit order.** `cathode[0]` is the rightmost digit.
3. **LCD R/W.** The design never drives R/W; HD44780 needs it low to accept writes, so tie it to ground.

---

## Diagram source

The complete block diagram is [`docs/00-full-diagram.svg`](docs/00-full-diagram.svg), drawn in [diagrams.net](https://app.diagrams.net) — every level on one canvas. The panels above are cut from it, each in a light and a dark version so the README follows the reader's GitHub theme.

---

## Repository structure

```
.
├── src/        Verilog source — 27 modules
├── docs/       Block diagrams: full canvas plus six panels, light and dark
└── Readme.md
```
