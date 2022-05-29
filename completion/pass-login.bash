# pass-login completion file for bash

PASSWORD_STORE_EXTENSION_COMMANDS+=(login)

__password_store_extension_complete_login() {
	local args=(-h --help -c --clip)
	COMPREPLY+=($(compgen -W "${args[*]}" -- ${cur}))
	_pass_complete_entries
}
