# ReadME

## Issue

### Environments set

-   `~/.bashrc`

    If you need your remote .bashrc to be sourced before you execute the code (for instance to change the PATH), make sure the .bashrc file does not contain lines like:

    ```
    [ -z "$PS1" ] && return
    ```

    or:

    ```
    case $- in
        *i*) ;;
        *) return;;
    esac
    ```

    in the beginning (these would prevent the bashrc to be executed when you ssh to the remote computer). You can check that e.g. the PATH variable is correctly set upon ssh, by typing (in your local computer):

    ```
    ssh YOURCLUSTERADDRESS 'echo $PATH'
    ```

    > `sed -i '6 s/^/#/' ~/.bashrc`

### vasp

1. miss `tags.yml`

### qe

1. miss `input_helper.xml`
