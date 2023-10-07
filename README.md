# dual_dice

The dice game is a demo project to show the working of logic devices with the use of 'Akshayapatra'. Akshayapatra is a CPLD development board based on **Xilinx XC9572XL-10VQG64C**.
It is designed and developed at CEDT, NSIT. Dual dice is an intuitive game based upon some defined rules for play.

CPLD stands for Complex Programmable Logic Devices which is a free bucket of thousands of gates available for the user and can be connected by programming. The CPLD is a combination of a fully programmable AND/OR array and a bank of macrocells. The array is reprogrammable and can perform a multitude of logic functions. Macrocells are functional blocks that perform combinatorial or sequential logic, and also have the added flexibility for true or complement, along with varied feedback paths.
The CPLD used for this specific project is Xilinx XC9572XL-10VQG64C. This CPLD ic runs on 3.3V and has **72 macrocells** with a maximum count of **52 input/output pins**. Rest of the pins are dedicated for special purposes.
Macrocells are key components of PLD devices. It contains logic implementing disjunctive normal form expression and more specialized logic operation.

## Working
The program into the CPLD is fed by the JTAG protocol pins.
The code is written in VHDL in Xilinx ISE. The main part of this project is a finite state machine which is coded inside the CPLD. The FSM takes in the inputs from the buttons and according to its present state decides the output and the next jump to another state. This all is implemented with flip-flops and some other combinational logic.
The state machine with the help of some pre-defined blocks constitute the entire project. The blocks generate some data which is manipulate by the main FSM design required to proceed further. The FSM control the blocks by some control signals. The entire set consisting of the control signals with the blocks is called datapath and the blocks are called elements of datapath.
|<img src="images/FSM_dualdice.png" height="600">|
|:--:|
|*FSM for dual dice game*|
