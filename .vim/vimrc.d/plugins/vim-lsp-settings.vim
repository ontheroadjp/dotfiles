let g:lsp_settings = {
\	'pylsp-all': {
\	    'disabled': 0,
\	    'args': ['--log-file=pylsp.log', '-vvv'],
\        'workspace_config': {
\            'pylsp': {
\	            'plugins': {
\	                'ruff': {
\	                    'enabled': v:true,
\	                },
\	            },
\                'configurationSources': ['flake8']
\            }
\        }
\    },
\}

