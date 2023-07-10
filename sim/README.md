# How to run the simulation

- Go to the `scripts/` folder

- Use `python3 transfer_to_server.py` to move the dlx to the server. To make it work, you need a `.env` file inside the `scripts/` folder with the following structure: 
``` 
    HOST="xxx"
    PORT=xxx
    USER_SERVER="xxx"
    PASSWORD="xxx"
    SERVER_WORKING_DIRECTORY="xxx"
```
- Use the script `simulate.py` to run the simulation, either on the server or locally. If you are working on the server, you need to run first `setmentor`. The arguments for the script are:

```
usage: simulate.py [-h] [-c] [-a ASM] [-g] [-p] [-v [KEY=VALUE ...]]

options:
  -h, --help            show this help message and exit
  -c, --compile_only    compile the files without executing them
  -a ASM, --asm ASM     which assembler file to execute
  -g, --gui             open the gui to analyze waveforms
  -p, --pretty          prettify dump
  -v [KEY=VALUE ...], --verify [KEY=VALUE ...]
                        Set a list of key-value elements to verify from the rf/dram final dump. This option
                        is used only if `-p` is present. You can add either a register as `rx=XXX` where `x`
                        is in 0...31 or a memory cell as `my=YYY`, where `y` is in 0...255. The value can be
                        written both in hex (8 digits) or in dec
```

- After the simulation is terminated, a dump of the register file and of the dram can be found in `sim/sump_ref_dmem.dump`.o

- Using the `-v` argument, an automated verification of the final result can be performed. You can either verify a dram cell or the value of a register. The provided value is checked with the content of the rf/dram at the end of the simulation. On the output of the command you can see whether the match was found or not. Here is an example: 

```
> python3 simulate.py --asm dlx_test_binomial -p -v r20=24310 m10=100

...

    Register r20 is 24310 as expected
    Memory location m10 is not 100;
    ->	Found 0

```

- In the gui mode, all the signals of the datapath are already in the waveform viewer, grouped by pipeline stage, so that it is easy to see, at each stage, what is happening in each stage.