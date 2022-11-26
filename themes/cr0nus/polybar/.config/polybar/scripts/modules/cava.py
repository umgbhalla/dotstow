#!/usr/bin/python3


import sys
import time
import struct
import os.path
import subprocess
import configparser


from collections import OrderedDict


##################################################
# Config

# This script converts cava's data output into fancy little bars. These values can range from 0 to 100
# We need to distribute 9 characters ('Zero output' and all bar heights: '▁▂▃▄▅▆▇█') over this value range.
# The 'BAR_FACTOR' is used to calculate all those states and keep the code readable
# (See 'BAR_CHARACTERS')
#
BAR_FACTOR = 100 / 7

# Configure resolution and style of the output here.
# The script fetches the cava output value and searches for the biggest matching key to get the character from
# (See 'BAR_FACTOR')
#
BAR_CHARACTERS = dict([
    (000, '▁'),  # Zero output

    (BAR_FACTOR * 1, '▁'),
    (BAR_FACTOR * 2, '▂'),
    (BAR_FACTOR * 3, '▃'),
    (BAR_FACTOR * 4, '▄'),
    (BAR_FACTOR * 5, '▅'),
    (BAR_FACTOR * 6, '▆'),
    (BAR_FACTOR * 7, '▇'),

    (100, '█'),  # Highest output
])

# Separator Character between bars. Can be anything
#
# Default: ' '
#
SEPARATOR = ' '

# Display no output if all bars are at minimum level (no sound output)
#
# Default: False
#
HIDE_WHEN_EMPTY = False

# Specify how long this script should wait before printing another value
#
# Default: 0.0005
#
OUTPUT_DELAY = 0.0005

# Specify how many times cava can report "no sound" (all values are 0) before the script detects it
#
# Default: 5
#
EMPTY_OUTPUT_THRESHOLD = 5

# If the script output should be written to a named pipe, specify the path here.
# Set to 'None' to disable FIFO output and print to STDOUT
#
# Default: None
#
# Examples:
#   "/tmp/cava_polybar_output.fifo"
#   os.path.join(os.sep, "tmp", "cava_polybar_output.fifo")
#
PIPE_OUT = None


# Path of the temporary cava configuration used to run the cava subprocess
#
# Default: os.path.join(os.sep, "tmp", "cava_polybar.config")
#
# Examples:
#   "/tmp/cava_polybar.config"
#   os.path.join(os.sep, "tmp", "cava_polybar.config")
#
CAVA_CONFIG_PATH = os.path.join(os.sep, "tmp", "cava_polybar.config")

# The following data will be used in the temporary cava config
#
# FIFO input pipe for raw cava data
#
PIPE_IN = os.path.join(os.sep, "tmp", "cava_polybar_input.fifo")

# Number of bars in cava
#
# Default: 8
#
CAVA_BARS_NUMBER = 8

# Output bit format for cava.
# Can be 16bit ot 8bit, but 8 should be plenty of resolution for the default of 8 bars...
#
# Default: "8bit"
#
CAVA_BIT_FORMAT = "8bit"


##################################################
# Code begins here

bytetype, bytesize, bytenorm = ("H", 2, 65535) if (
    CAVA_BIT_FORMAT == "16bit") else ("B", 1, 255)


def output(string, file):
    """
    Print/Write the given value either to STDOUT ot the specified output pipe

    Args:
        string ([string]): String to print
        file ([file]): [description]
    """

    if (PIPE_OUT):
        file.write(string)
    else:
        print(string, end="")
        sys.stdout.flush()

    time.sleep(OUTPUT_DELAY)


def valueToCharacter(value):
    """
    Returns the respective character for a value. Returns 'highest' character if no match is found

    Args:
        value ([int]): Value that should be mapped to a character

    Returns:
        [char]: Respective character for the given value
    """

    for bar_threshold in BAR_CHARACTERS:
        if(value < bar_threshold):
            return BAR_CHARACTERS[bar_threshold]
    return BAR_CHARACTERS[100]


def run():
    """ 
    Prepare variables and run the conversion process
    """

    createCavaConfig()

    # Create cava subprocess
    FNULL = open(os.devnull, 'w')
    cavaProcess = subprocess.Popen(
        ["cava", "-p", CAVA_CONFIG_PATH],
        stdout=FNULL,
        stderr=subprocess.STDOUT
    )

    # Open output pipe if specified
    outputPipe = None
    if (PIPE_OUT):
        print("The converted output can be found in " + PIPE_OUT)

        if os.path.exists(PIPE_OUT):
            os.remove(PIPE_OUT)

        os.mkfifo(PIPE_OUT)
        outputPipe = open(PIPE_OUT, "w")

    # Open input pipe (raw cava data)
    inputPipe = open(PIPE_IN, "rb")

    exitCode = 0
    try:
        # Run the conversion process
        convert(inputPipe, outputPipe)
    except KeyboardInterrupt:
        exitCode = 1

    # Close output pipe if needed
    if (PIPE_OUT):
        outputPipe.close()
        os.remove(PIPE_OUT)

    # Close input pipe and kill the subprocess
    inputPipe.close()
    cavaProcess.kill()

    sys.exit(exitCode)


def convert(inputPipe, outputPipe=None):
    """
    Converts values taken from the input pipe to printable characters.
    The result is either printed to STDOUT or written to the output pipe

    Args:
        inputPipe ([file]): Input file containing raw cava data
        outputPipe ([file]): Output file (if specified)
    """

    # Initialize variables
    chunk = bytesize * CAVA_BARS_NUMBER
    fmt = bytetype * CAVA_BARS_NUMBER

    emptyOutputs = 0

    # Convert
    while True:
        rawData = inputPipe.read(chunk)
        if len(rawData) < chunk:
            break

        tstring = ""
        emptyOutput = True

        for i in struct.unpack(fmt, rawData):
            value = int(i / bytenorm * 100)

            if (len(tstring) > 0):
                tstring += SEPARATOR
            tstring += valueToCharacter(value)

            if (value != 0):
                emptyOutput = False

        if (emptyOutput and HIDE_WHEN_EMPTY):
            emptyOutputs += 1
            if (emptyOutputs > EMPTY_OUTPUT_THRESHOLD):
                output("        " + os.linesep, outputPipe)
        else:
            emptyOutputs = 0
            output(tstring + os.linesep, outputPipe)


def createCavaConfig():
    """ 
    Create the temporary configuration file used by the cava subprocess
    """

    config = configparser.ConfigParser()

    config.add_section('general')
    config.set('general', 'bars', str(CAVA_BARS_NUMBER))
    config.set('general', 'overshoot', str(0))

    config.add_section('output')
    config.set('output', 'method', 'raw')
    config.set('output', 'channels', 'mono')
    config.set('output', 'mono_option', 'average')
    config.set('output', 'raw_target', PIPE_IN)
    config.set('output', 'bit_format', CAVA_BIT_FORMAT)

    config.add_section('smoothing')
    config.set('smoothing', 'integral', '0')

    with open(CAVA_CONFIG_PATH, 'w') as configfile:
        config.write(configfile)


def printTestData():
    """
    Prints test data to stdout. Useful for checking resolution and customisation configuration
    """

    print("")

    print("Bar Characters:")
    for bar_threshold in BAR_CHARACTERS:
        print('{:06.2f}: {}'.format(
            bar_threshold, BAR_CHARACTERS[bar_threshold]))

    print("")

    print("Value Test:")
    for i in range(101):
        print('{:03d}: {}'.format(i, valueToCharacter(i)))


if __name__ == "__main__":

    # Sort the dict to ensure correct character mapping
    BAR_CHARACTERS = OrderedDict(sorted(BAR_CHARACTERS.items()))

    for arg in sys.argv:
        if (arg == "h" or arg == "help"):
            print("")
            print("cava polybar parse script")
            print(
                "Converts cava raw values into characters and outputs to STDOUT or a fifo buffer")
            print("")
            print("Adjust thresholds, characters and config directly in the script")
            print(
                "If the config file at 'CONFIG_PATH' (/tmp/cava_polybar.config) is messed up, simply delet it")
            print("")
            print("Arguments:")
            print("<none>  ... Execute normally")
            print("t, test ... Run test mode (stdout only)")
            print("h, help ... Show this help message and exit (stdout only)")
            print("")
            sys.exit()

        if (arg == "t" or arg == "test"):
            printTestData()
            sys.exit()

    run()

