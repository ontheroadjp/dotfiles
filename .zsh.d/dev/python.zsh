function _python_virtual_env_activation() {
    if _is_exist deactivate; then
        deactivate
    fi
    # export VIERTUAL_ENV=''
    unset VIERTUAL_ENV
    source venv/bin/activate
    python -m site
}
alias venv='_python_virtual_env_activation'

