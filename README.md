# 🥤 FSM-Based Vending Machine Controller

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Architecture](https://img.shields.io/badge/Architecture-FSM-orange)
![Status](https://img.shields.io/badge/Status-Synthesizable-green)

A fully synthesizable **Vending Machine Controller** implemented in Verilog. This project utilizes a Finite State Machine (FSM) to handle coin accumulation, product selection, and price comparison. It features a modular design separating the coin decoding logic from the main control loop, making it easily adaptable for different currencies or FPGA boards.

---

## 🧩 Key Features

- **Multi-Denomination Support:** Accepts **₹5, ₹10, and ₹25** inputs via a dedicated coin decoder module.
- **Dynamic Balance Tracking:** Internal accumulator registers current funds and updates in real-time.
- **Smart Dispensing Logic:**
  - Checks if `Balance ≥ Price` before dispensing.
  - Automatically calculates and asserts the `change_return` signal.
- **User Feedback:** Status signals for `Ready`, `Dispensing`, and `Insufficient Funds`.
- **Modular Design:** Split into `coin_decoder.v` and `vending_fsm.v` for clean hierarchy.

---

## ⚙️ Architecture & FSM

The system is built around a central FSM that transitions based on clock edges and user inputs.



[Image of finite state machine diagram for vending machine]


### State Descriptions
| State | Function |
| :--- | :--- |
| **IDLE** | Waits for coin insertion. Resets accumulator if transaction cancelled. |
| **SCAN_COIN** | Decodes input pulses and updates the internal `current_balance` register. |
| **WAIT_SEL** | Waits for user to select a product (`prod_sel`). |
| **CHECK_FUNDS** | Compares `current_balance` vs `product_price`. |
| **DISPENSE** | Asserts `dispense_out` if funds are sufficient. |
| **RETURN** | Returns remaining balance (if any) and resets for next user. |

---

## 💰 Product & Pricing Map

The machine supports 4 distinct products selected via a 2-bit input code.

| Product Name | Selection Code (`sel`) | Price (₹) |
| :--- | :---: | :---: |
| **Item 0** (e.g., Water) | `2'b00` | **35** |
| **Item 1** (e.g., Soda) | `2'b01` | **50** |
| **Item 2** (e.g., Chips) | `2'b10` | **65** |
| **Item 3** (e.g., Chocolate) | `2'b11` | **100** |

---

## 🔌 I/O Interface

| Direction | Port Name | Width | Description |
| :--- | :--- | :--- | :--- |
| **Input** | `clk` | 1-bit | System Clock (50MHz/100MHz) |
| **Input** | `rst_n` | 1-bit | Active-low asynchronous reset |
| **Input** | `coin_in` | 3-bit | One-hot encoded coin input (representing 5, 10, 25) |
| **Input** | `prod_sel` | 2-bit | Product selection switch |
| **Input** | `req_buy` | 1-bit | Button press to confirm purchase |
| **Output** | `dispense` | 1-bit | High when product is released |
| **Output** | `change_out` | 8-bit | Binary value of change returned |
| **Output** | `ready` | 1-bit | System ready for new transaction |

---

## 📁 Repository Structure

```text
.
├── src
│   ├── Machine.v      # Entire Vending Machine Code
│   └── Machine_tb.v   # Testbench simulation file
