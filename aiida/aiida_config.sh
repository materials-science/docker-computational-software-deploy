#!/bin/bash
# This script is executed whenever the docker container is (re)started.

# Debugging.
set -x

# Environment.
export SHELL=/bin/bash

verdi setup --config=/workdir/aiida_setup.yml
verdi daemon start

# Setup AiiDA autocompletion.
grep _VERDI_COMPLETE /root/.bashrc &>/dev/null || echo 'eval "$(_VERDI_COMPLETE=source verdi)"' >>/root/.bashrc

# Check if AiiDA profile it exists already
if ! verdi profile show ${PROFILE_NAME} &>/dev/null; then
    NEED_SETUP_PROFILE=true
else
    NEED_SETUP_PROFILE=false
fi

# Setup AiiDA profile if needed.
if [[ ${NEED_SETUP_PROFILE} == true ]]; then

    # Create AiiDA profile.
    # verdi quicksetup \
    #     --non-interactive \
    #     --profile "${PROFILE_NAME}" \
    #     --email "${USER_EMAIL}" \
    #     --first-name "${USER_FIRST_NAME}" \
    #     --last-name "${USER_LAST_NAME}" \
    #     --institution "${USER_INSTITUTION}" \
    #     --db-backend "${AIIDADB_BACKEND}"
    
    verdi setup --config=/workdir/aiida_setup.yml

    # connect to remote computer
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa -q
    ssh-keyscan -f ~/.ssh/id_rsa.pub aiida.qe >>~/.ssh/known_hosts
    ssh-keyscan -f ~/.ssh/id_rsa.pub aiida.qe.6.4 >>~/.ssh/known_hosts
    ssh-keyscan -f ~/.ssh/id_rsa.pub aiida.vasp >>~/.ssh/known_hosts
    sshpass -p "docker_qe" ssh-copy-id -f -i ~/.ssh/id_rsa root@aiida.qe
    sshpass -p "docker_qe" ssh-copy-id -f -i ~/.ssh/id_rsa root@aiida.qe.6.4
    sshpass -p "docker_vasp" ssh-copy-id -f -i ~/.ssh/id_rsa root@aiida.vasp

    # Setup and configure computer.
    verdi computer show vasp || verdi computer setup \
        --non-interactive \
        --label "vasp" \
        --description "vasp container" \
        --hostname "aiida.vasp" \
        --transport ssh \
        --scheduler direct \
        --work-dir /workdir/aiida/ \
        --mpirun-command "mpirun -np {tot_num_mpiprocs}" \
        --mpiprocs-per-machine 1 &&
        verdi computer configure ssh "vasp" \
            --non-interactive \
            --safe-interval 0.0

    # Setup and configure computer.
    verdi computer show qe || verdi computer setup \
        --non-interactive \
        --label "qe" \
        --description "qe container" \
        --hostname "aiida.qe" \
        --transport ssh \
        --scheduler direct \
        --work-dir /workdir/aiida/ \
        --mpirun-command "mpirun -np {tot_num_mpiprocs}" \
        --mpiprocs-per-machine 1 &&
        verdi computer configure ssh "qe" \
            --non-interactive \
            --safe-interval 0.0
    
    # Setup and configure computer.
    verdi computer show qe.6.4 || verdi computer setup \
        --non-interactive \
        --label "qe.6.4" \
        --description "qe.6.4 container" \
        --hostname "aiida.qe.6.4" \
        --transport ssh \
        --scheduler direct \
        --work-dir /workdir/aiida/ \
        --mpirun-command "mpirun -np {tot_num_mpiprocs}" \
        --mpiprocs-per-machine 1 &&
        verdi computer configure ssh "qe.6.4" \
            --non-interactive \
            --safe-interval 0.0
fi

# Make sure that the daemon is not running, otherwise the migration will abort.
verdi daemon stop

# Daemon will start only if the database exists and is migrated to the latest version.
verdi daemon start || echo "AiiDA daemon is not running."

tail -F /dev/null
