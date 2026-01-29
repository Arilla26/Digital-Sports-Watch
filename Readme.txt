# ⌚ Sports Stopwatch – Designed in Verilog HDL

## 📌 Project Overview

This is a final project for the **Logic Design (CO3091)** course at the University of Technology – VNU-HCM. The goal of this project is to build a **multifunctional digital stopwatch** with capabilities including:

- Precise time counting (hours, minutes, seconds, hundredths of a second)
- Display time on **12 seven-segment LEDs**
- Store and display multiple results on a **20x4 LCD screen**
- Support for **pause/resume**, and **manual adjustment** of time

## 🗂️ Project Structure
├── src/ # Contains all Verilog source files
│ ├── Chia_10ena/ # Clock divider modules
│ ├── Dem_GPG_NN/ # Hour-minute-second counter with blinking
│ ├── GM_HT_12Led/ # Seven-segment LED decoder
│ ├── HEXTOBCD/ # Hexadecimal to BCD converters
│ ├── LCD_DATA_TRANSFER/ # Data packing for LCD
│ ├── LCD_Transfer/ # LCD data transfer control (FSM)
│ └── Dong_ho_the_thao.v # Top-level integration module
├── Readme # Project documentation

## 🧰 Technologies Used

- **HDL Language**: Verilog
- **Simulation Tool**: Xilinx Vivado
- **Hardware Platform**: Arty Z7 FPGA
- **Design Style**: RTL (Register Transfer Level), modular structure

## 🧩 System Architecture

The system is structured into 6 main modules:

1. **Clock Divider** – generates signals of 1Hz, 2Hz, 5Hz, 1kHz, etc.
2. **Time Counter** – handles hour, minute, second counting with blink and adjustment modes
3. **Button Debounce** – ensures clean signals from button presses
4. **Hex to BCD Converter** – converts internal binary values to BCD for display
5. **Seven-Segment Decoder** – drives the 12 seven-segment LED display
6. **LCD Data Transfer & Display Controller** – handles output to 20x4 LCD screen

## 🖥️ Output Display

- **12x Seven-Segment LEDs**: show live time in format `hh:mm:ss.xx`
- **20x4 LCD Display**: shows saved results (lap times, distances, etc.)