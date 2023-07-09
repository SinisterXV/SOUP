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
- Use the script `simulate.py` to run the simulation, either on the server or locally. The arguments for the script are:

```
    -h, --help          show this help message and exit
    -c, --compile_only  compile the files without executing them
    -a ASM, --asm ASM   which assembler file to execute
    -g, --gui           open the gui to analyze waveforms
    -p, --pretty        prettify dump
```
